import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-selector.dart';
import 'package:my_app/views/view-diary.dart';
import 'package:my_app/views/view-none.dart';
import 'package:my_app/views/view-spreads.dart';
import 'package:window_manager/window_manager.dart';

import 'components/submenus/component-sub-menu-button.dart';
import 'components/submenus/component-sub-menu-title.dart';
import 'controllers/controller-side-button.dart';
import 'controllers/controller-tarot-card-list.dart';
import 'controllers/controller-widget-resize.dart';
import 'navigation-key.dart';

/// 타로 셀렉터 다이얼로그
late BuildContext tarotSelectorContext;

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

  runApp(GetMaterialApp(navigatorKey: navigatorKey, home: const StartUp()));
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
    return MaterialApp(
        title: 'Tarot Diary',
        home: const MyHomePage(title: ''),
        builder: EasyLoading.init());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 윈도우 리스너 MixIn
class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // 페이지 컨트롤러
  PageController pageController = PageController();

  // 사이드 메뉴 컨트롤러
  SideMenuController sideMenu = SideMenuController();

  WindowEffect effect = WindowEffect.transparent;
  Color color = Colors.transparent;
  MacOSBlurViewState macOSBlurViewState =
      MacOSBlurViewState.followsWindowActiveState;

  // debounce 선언 및 초기화
  final updateWindowResizeDebounced = Debouncer(
    const Duration(milliseconds: 100),
    initialValue: null,
    checkEquality: false,
  );

  get pageBuilder => null;

  void setWindowEffect(WindowEffect? value) {
    Window.setEffect(
      effect: value!,
      color: color,
    );
    setState(() => effect = value);
  }

  /// initState
  @override
  void initState() {
    // 윈도우 변경 감지 주입
    windowManager.addListener(this);
    setWindowEffect(effect);

    // 윈도우 변경감지 디바운서 리스닝
    updateWindowResizeDebounced.values.listen((event) {
      // 카드 사이즈를 업데이트한다.
      setCardSize();
    });

    // 사이드 메뉴 변경시 콜백
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });

    /// EasyLoading 콜백
    EasyLoading.addStatusCallback((status) {});

    super.initState();

    /// 화면 빌드 완료후 콜백
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setCardSize();
    });
  }

  /// 윈도우 사이즈 기반으로 카드 사이즈를 세팅한다.
  setCardSize() {
    // 카드 사이즈를 위한 화면 크기를 계산한다.
    double widthWidget = MediaQuery.of(context).size.width;

    double cardWith = 0.0;

    if (widthWidget < 900.0) {
      cardWith = 100;
    } else {
      cardWith = 150;
    }

    // 카드의 사이즈를 세팅한다.
    Get.find<WidgetResizeController>()
        .setCardWidgetSize(cardWith, cardWith * 1.7);
  }
  //
  // notifyWidgetSize(){
  //   // 사이즈를 구한다.
  //   Size viewPageSize = getWidgetSize(_pageViewKey);
  //   double correctWidth = 60;
  //   double correctHeight = 60 * 1.7;
  //
  //   // 전달한다.
  //   Get.find<WidgetResizeController>().setWindowWidgetSize(correctWidth,correctHeight);
  // }

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
    // 타로 카드 리스트 관리 컨트롤러 등록
    Get.put(TarotCardSelectorController());
    // 사이드 버튼 관리 컨트롤러 등록
    Get.put(SideMenuButtonController());
    return Scaffold(
        body: Row(
      children: [
        /// 사이드 메뉴
        Container(
            height: double.infinity,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                border: Border(
                    right: BorderSide(
                        width: 1, color: Colors.black54.withOpacity(0.1)))),
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ComponentSubMenuTitle(
                      name: 'Playing',
                    ),
                    // 다이어리 뷰 버튼
                    ComponentSubMenuButton(
                        name: 'Diary',
                        iconData: Icons.access_time_outlined,
                        onTap: () {
                          toView(const ViewDiary());
                        }),
                    // // 스프레드 세팅 버튼
                    // ComponentSubMenuButton(name: 'Spreads', iconData: Icons.account_tree_sharp, onTap: () {
                    //   toView(const ViewSpreads());
                    // }),
                  ],
                ))),
        Expanded(
            child: Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              initialRoute: '/none',
              onGenerateRoute: _onGenerateRoute,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.grey.withOpacity(0.2),
            //       border: Border(
            //           bottom: BorderSide(width: 1 , color: Colors.black54.withOpacity(0.1))
            //       )
            //   ),
            // )
          ],
        ))
      ],
    )

        // Container(
        //   margin: const EdgeInsets.only(top: 30),
        //   child:  ListView(
        //     children: [
        //       CardView(child: Text("dddd"))
        //     ],
        //   ),
        // )
        );
  }

  /// 페이지를 라우팅 한다.
  void toView(Widget widget) {
    _navigatorKey.currentState?.push(_createRoute(widget));
  }

  /// 타로 셀렉터를 오픈한다.
  Future<void> showTarotSelector(BuildContext context) async {
    tarotSelectorContext = context;
    showDialog(
        context: tarotSelectorContext,
        barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
        builder: (tarotSelectorContext) {
          return const ComponentTarotSelector();
        });
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

/// Nested 라우팅을 진행한다.
MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
  // 유효한 값이 아닌경우
  if (setting.name == null) {
    return MaterialPageRoute(builder: (context) => const ViewNone());
  }

  // 라우트경로를 가져온다.
  String routePath = setting.name!.toLowerCase();
  switch (routePath) {
    case '/diary':
      return MaterialPageRoute(builder: (context) => const ViewDiary());
    case '/spreads':
      return MaterialPageRoute(builder: (context) => const ViewSpreads());
  }

  return MaterialPageRoute(builder: (context) => const ViewNone());
}

Route _createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
