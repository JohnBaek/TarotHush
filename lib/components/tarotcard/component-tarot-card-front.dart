import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component-tarot-card-core.dart';

/// 타로카드 앞면
class ComponentTarotCardFront extends StatelessWidget {
  final String cardImagePath;
  // 가로
  final double width;
  // 새로
  final double height;
  const ComponentTarotCardFront({super.key, required this.cardImagePath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return
      ComponentTarotCardCore(fillColor:Colors.white,borderColor:Colors.black,width: width,height: height,widget:Image(image: AssetImage(cardImagePath), fit: BoxFit.fill));
  }
}
