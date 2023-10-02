
import 'package:get/get.dart';

/// 위젯 리사이즈 컨트롤러 
class WidgetResizeController extends GetxController {
  // 가로 
  double width = 0.0;
  // 세로
  double height = 0.0;
  
  // 사이즈를 업데이트한다.
  void notifyWidgetSize(double width , double height){
    this.width = width;
    this.height = height;
    update();
  }
}