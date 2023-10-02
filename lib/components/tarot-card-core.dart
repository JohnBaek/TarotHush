import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/providers/widget-resize-controller.dart';

/// 타로카드 외형 및 선택 코어 클래스
class TarotCardCore extends StatelessWidget {
  // 채울 색상
  final Color fillColor;
  // 외곽선의 컬러 
  final Color borderColor;
  // 위젯
  final Widget? widget;

  const TarotCardCore({super.key, required this.fillColor,required this.borderColor, required this.widget});

  @override
  Widget build(BuildContext context) {
    return 
      GetBuilder<WidgetResizeController>(builder: (controller){
        return cardOutline(controller.width,controller.height, fillColor, borderColor, widget);
      });
  }
}


/// 카드의 아웃라인을 리턴한다.
Widget cardOutline(double width, double height, Color fillColor, Color borderColor, Widget? childWidget) {
  if (childWidget == null) {
    return
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 4.0),
          color: Color(fillColor.value),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
      );
  }
  return
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3.0),
        color: Color(fillColor.value),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: childWidget,
    );
}


