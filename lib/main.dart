import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/providers/widget-resize-controller.dart';
import 'package:my_app/views/diary_view.dart';
import 'package:window_manager/window_manager.dart';


/// 뷰페이지의 사이즈를 핸들하기 위한 글로벌키
GlobalKey _pageViewKey = GlobalKey();


/// 메인 클래스
void main() async {
  /// 윈도우 사이즈 이벤트 이니셜라이즈
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  
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

  // debounce 선언 및 초기화
  final updateWindowResizeDebounced = Debouncer(
    const Duration(milliseconds: 100),
    initialValue: null,
    checkEquality: false,
  );

  /// initState
  @override
  void initState() {
    // 윈도우 변경 감지 주입
    windowManager.addListener(this);
    
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
    double correctWidth = viewPageSize.width / 11;
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'mohada',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Today\'s Tarot',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
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
              SideMenuItem(
                title: 'Exit',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: 
                GetBuilder<WidgetResizeController>(
                  builder: (controller) {
                    return
                      PageView(
                        key: _pageViewKey,
                        controller: pageController,
                        children: [
                          Container(
                            color: Colors.white,
                            child: const Center(
                                child: DiaryView()
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Users',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Files',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Download',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Settings',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Only Title',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'Only Icon',
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                          ),
                        ],
                      );
                  }
                )
            
          ),
        ],
      ),
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
