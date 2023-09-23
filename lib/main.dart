import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/widgets/transparent_macos_sidebar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/providers/tarot-card-list-controller.dart';
import 'package:my_app/providers/widget-resize-controller.dart';
import 'package:my_app/views/tarot-selector.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';


/// 뷰페이지의 사이즈를 핸들하기 위한 글로벌키
GlobalKey _pageViewKey = GlobalKey();


/// 메인 클래스
void main() async {
  /// 윈도우 사이즈 이벤트 이니셜라이즈
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    fullScreen: false,
    skipTaskbar: true,
    center: false,
    alwaysOnTop: false, // This hide the taskbar and appear the app on top
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  
  runApp(const GetMaterialApp(home: StartUp()));
  configLoading();
}

/// Easyloading 초기화
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorSize = 45.0
    ..indicatorColor = Colors.transparent
    ..backgroundColor = Colors.transparent
    ..progressColor = Colors.transparent
    ..radius = 10.0
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

/// 시작 클래스
class StartUp extends StatelessWidget {
  const StartUp({super.key});

  /// 빌더
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Tarot Diary', 
        theme: const CupertinoThemeData(brightness: Brightness.light),
        home: const MyHomePage(title: ''),
        builder: EasyLoading.init()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 윈도우 리스너 MixIn
class _MyHomePageState extends State<MyHomePage> with WindowListener{
  // 페이지 컨트롤러
  PageController pageController = PageController();
  
  // 사이드 메뉴 컨트롤러 
  SideMenuController sideMenu = SideMenuController();

  WindowEffect effect = WindowEffect.transparent;
  Color color = Colors.transparent;
  MacOSBlurViewState macOSBlurViewState = MacOSBlurViewState.followsWindowActiveState;

  // debounce 선언 및 초기화
  final updateWindowResizeDebounced = Debouncer(
    const Duration(milliseconds: 100),
    initialValue: null,
    checkEquality: false,
  );

  void setWindowEffect(WindowEffect? value) {
    Window.setEffect(
      effect: value!,
      color: this.color,
    );
    this.setState(() => this.effect = value);
  }
  
  /// initState
  @override
  void initState() {
    // 윈도우 변경 감지 주입
    windowManager.addListener(this);
    this.setWindowEffect(this.effect);
    
    // 윈도우 변경감지 디바운서 리스닝
    updateWindowResizeDebounced.values.listen((event) {
      // 뷰페이지의 현재 사이즈를 구한다.
      notifyWidgetSize();
    });
    
    // 사이드 메뉴 변경시 콜백 
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    
    /// EasyLoading 콜백
    EasyLoading.addStatusCallback((status) { 
    });

    super.initState();

    /// 화면 빌드 완료후 콜백
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyWidgetSize();
    });
  }

  notifyWidgetSize(){
    // 사이즈를 구한다.
    Size viewPageSize = getWidgetSize(_pageViewKey);
    double correctWidth = viewPageSize.width / 8;
    double correctHeight = correctWidth * 1.7;

    // 전달한다.
    Get.find<WidgetResizeController>().notifyWidgetSize(correctWidth,correctHeight);
  }

  /// 종료시 
  @override
  void dispose() {
    // 윈도우 리스너 자원 해제
    windowManager.removeListener(this);
    super.dispose();
  }

  /// 윈도우 사이즈 변경시 
  @override
  void onWindowResize() {
    // 디바운싱
    updateWindowResizeDebounced.setValue(null);
  }

  @override
  Widget build(BuildContext context) {
    // 위젯 리사이즈 상태관리 컨트롤러 등록
    Get.put(WidgetResizeController());
    return CupertinoPageScaffold(
      child:
      Container(
        margin: const EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                openSideMenuWidth: 200,
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.blue[100],
                selectedHoverColor: Colors.blue[100],
                selectedColor: Colors.lightBlue,
                selectedTitleTextStyle: const TextStyle(fontSize: 14, color: Colors.white),
                unselectedTitleTextStyle: const TextStyle(fontSize: 14) ,
                selectedIconColor: Colors.white,
              ),
              items: [
                SideMenuItem(
                  title: 'Playing',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.credit_card_outlined),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const Divider(
                      endIndent: 8,
                      indent: 8,
                    );
                  },
                ),
                SideMenuItem(
                  title: 'Settings',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            Expanded(
                child: PageView(
                  scrollDirection: Axis.vertical,
                  key: _pageViewKey,
                  controller: pageController,
                  children: [
                    TarotSelector()

                    // ListView(
                    //   children: [
                    //     TarotSelector()
                    //   ],
                    // )
                  ],
                )
            ),
          ],
        )
      ) ,
    );
  }
}



/// 위젯의 사이즈를 구한다.
getWidgetSize(GlobalKey key) {
  if (key.currentContext != null) {
    final RenderBox renderBox =
    key.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    return size;
  }
}
