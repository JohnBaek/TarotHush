
import 'package:get/get.dart';

/// 위젯 리사이즈 컨트롤러 
class WidgetResizeController extends GetxController {
  // 윈도우 위젯 가로 
  double windowWidth = 0.0;
  // 윈도우 위젯 세로
  double windowHeight = 0.0;

  // 카드 위젯 가로 
  double cardWidth = 0.0;
  // 카드 위젯 세로
  double cardHeight = 0.0;
  
  /// 윈도우 위젯의 사이즈를 업데이트한다.
  void setWindowWidgetSize(double width , double height){
    windowWidth = width;
    windowHeight = height;
    update();
  }

  /// 윈도우 위젯의 사이즈를 업데이트한다.
  void setCardWidgetSize(double width , double height){
    cardWidth = width;
    cardHeight = height;
    update();
  }
}