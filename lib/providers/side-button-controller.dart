import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// 사이드 메인 버튼 상태 컨트롤러 
class SideMenuButtonController extends GetxController {
  /// 선택된 버튼명 
  String selectedButtonName = '';

  /// 버튼을 클릭한다.
  void click(String name){
    // 동일한 버튼일 경우 
    if(selectedButtonName == name) {
      return;
    }
    
    selectedButtonName = name;
    update();
  }
}