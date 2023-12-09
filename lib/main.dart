import 'dart:io';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_app/components/tarotcard/component-tarot-selector.dart';
import 'package:my_app/models/hive/hive-diary-detail.dart';
import 'package:my_app/models/hive/hive-tarot-card-metadata.dart';
import 'package:my_app/services/tarotcard-metadata-setter.dart';
import 'package:my_app/views/diary/view-diary.dart';
import 'package:my_app/views/view-none.dart';
import 'package:window_manager/window_manager.dart';

import 'components/submenus/component-sub-menu-button.dart';
import 'components/submenus/component-sub-menu-title.dart';
import 'components/tarotcard/component-tarot-card-controller.dart';
import 'controllers/controller-side-button.dart';
import 'controllers/controller-widget-resize.dart';
import 'models/enums/enum-tarot-product.dart';
import 'models/hive/hive-diary.dart';

import 'package:path/path.dart' as pathHelper;

/// 타로 셀렉터 다이얼로그
late BuildContext tarotSelectorContext;

/// 메인 클래스
void main() async {
  // 윈도우 관련 정보들을 초기화한다.
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    fullScreen: false,
    skipTaskbar: true,
    center: false,
    alwaysOnTop: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // Hive 로컬 데이터베이스 이니셜라이즈 [/Users/john/Library/Containers/com.example.myApp/Data]
  Hive
    ..init( pathHelper.join(Directory.current.path, "TarotHushLocalData") )
    ..registerAdapter(HiveDiaryAdapter())
    ..registerAdapter(HiveDiaryDetailAdapter())
    ..registerAdapter(HiveEnumTarotProductAdapter())
    ..registerAdapter(HiveTarotCardMetadataAdapter());

  // DI 인스턴스 등록
  GetIt.instance.registerSingleton<Box<HiveDiary>>(await Hive.openBox<HiveDiary>('diary'));
  GetIt.instance.registerSingleton<Box<HiveDiaryDetail>>(await Hive.openBox<HiveDiaryDetail>('diaryDetail'));
  GetIt.instance.registerSingleton<Box<HiveTarotCardMetadata>>(await Hive.openBox<HiveTarotCardMetadata>('tarotCardMetadata'));

  // 타로카드 메타 데이터 이니셜라이저를 실행
  await TarotCardMetadataSetter(tarotCardMetadataBox: GetIt.instance<Box<HiveTarotCardMetadata>>()).initMetaAsync();

  // EasyLoading 을 초기화 한다.
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

  // 어플리케이션을 시작한다.
  runApp(const GetMaterialApp(home: StartUp()));
}

/// 시작 클래스
class StartUp extends StatelessWidget {
  const StartUp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tarot Diary',
        home: const StartUpState(title: ''),
        builder: EasyLoading.init());
  }
}

/// 시작 클래스 에 대한 상태 클래스
class StartUpState extends StatefulWidget {
  const StartUpState({super.key, required this.title});
  final String title;
  @override
  State<StartUpState> createState() => _StartUpStateState();
}

/// 시작 클래스 에 대한 상태 클래스 구현체
class _StartUpStateState extends State<StartUpState> with WindowListener {
  // 화면간 이동을 위한 네비게이션 글로벌 키
  final _navigatorKey = GlobalKey<NavigatorState>();

  // 윈도우 사이즈 변경 감지 debounce 선언 및 초기화
  final updateWindowResizeDebounced = Debouncer(
    const Duration(milliseconds: 100),
    initialValue: null,
    checkEquality: false,
  );

  /// initState
  @override
  void initState() {
    super.initState();

    // 윈도우 변경 감지 주입
    windowManager.addListener(this);

    // EasyLoading 콜백
    EasyLoading.addStatusCallback((status) {});

    // 화면 빌드 완료후 콜백
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setCardSizeByWindowSize();
    });

    // 윈도우 변경 감지 디바운서 콜백
    updateWindowResizeDebounced.values.listen((event) {
      setCardSizeByWindowSize();
    });
  }

  /// 윈도우 사이즈 기반으로 카드 사이즈를 세팅한다.
  void setCardSizeByWindowSize() {
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
    // 콜백을 호출 해준다.
    updateWindowResizeDebounced.setValue(null);
  }

  @override
  Widget build(BuildContext context) {
    // 위젯 리사이즈 상태관리 컨트롤러 등록
    Get.put(WidgetResizeController());
    // 타로 카드 리스트 관리 컨트롤러 등록
    Get.put(ComponentTarotCardController());
    // 사이드 버튼 관리 컨트롤러 등록
    Get.put(SideMenuButtonController());
    return Scaffold(
        body: Row(
          children: [
            // 사이드 메뉴
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
              ],
            ))
      ],
    ));
  }

  /// 페이지를 라우팅 한다.
  /// [page] 이동할 위젯 페이지
  void toView(Widget page) {
    _navigatorKey.currentState?.push(_createRoute(page));
  }

  /// 타로 셀렉터를 오픈한다.
  /// [context] 현재 컨텍스트 정보
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

/// Nested 라우팅을 진행한다.
/// [setting] 라우팅 세팅 정보
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
  }

  return MaterialPageRoute(builder: (context) => const ViewNone());
}

/// 라우트 정보를 생성한다
/// [Widget] 대상 위젯 정보
Route _createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
