import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 타로카드 외형 및 선택 코어 클래스
class ComponentTarotCardCore extends StatelessWidget {
  // 채울 색상
  final Color fillColor;
  // 외곽선의 컬러 
  final Color borderColor;
  // 위젯
  final Widget? widget;
  // 가로
  final double width;
  // 새로
  final double height;

  const ComponentTarotCardCore({super.key, required this.fillColor,required this.borderColor, required this.widget, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return cardOutline(width,height, fillColor, borderColor, widget);
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


