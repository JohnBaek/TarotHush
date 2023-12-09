import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component-tarot-card-core.dart';

/// 타로카드 앞면
class ComponentTarotCardFront extends StatelessWidget {
  // 카드 이미지 경로
  final String imagePath;
  
  // 가로
  final double width;
  
  // 새로
  final double height;
  
  /// 생성자
  /// [imagePath] 이미지 경로
  /// [width] 가로 
  /// [height] 새로
  const ComponentTarotCardFront({super.key, required this.imagePath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return
      // 카드를 리턴한다.
      ComponentTarotCardCore(
            fillColor:Colors.white
          , borderColor:Colors.black
          , width: width
          , height: height
          , widget:Image(image: AssetImage(imagePath)
          , fit: BoxFit.fill
      ));
  }
}
