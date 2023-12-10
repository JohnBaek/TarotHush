import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';
import 'package:my_app/models/responses/diary/response-diary.dart';

import 'component-tarot-card-controller.dart';
import 'component-tarot-card-core.dart';

/// 콜백 정의 
/// [metadata] 디테일 데이터
typedef OnTapWithParam = void Function(ResponseTarotCardMetadata metadata);

/// 타로카드 앞면
class ComponentTarotCardFront extends StatelessWidget {
  // 카드 이미지 경로
  final ResponseTarotCardMetadata metadata;
  
  // 가로
  final double width;
  
  // 새로
  final double height;

  // 클릭시 콜백 메서드 
  final OnTapWithParam onTap;
  
  /// 생성자
  /// [metadata] 카드 메타 데이터
  /// [width] 가로 
  /// [height] 새로
  /// [onTap] 클릭시 콜백 이벤트
  const ComponentTarotCardFront({super.key, required this.metadata, required this.width, required this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          onTap(metadata);
        },
        child:
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child:Container(
                child: // 카드를 리턴한다.
                ComponentTarotCardCore(
                    fillColor:Colors.white
                    , borderColor:Colors.black
                    , width: width
                    , height: height
                    , widget:Image(image: AssetImage(metadata.imagePath)
                    , fit: BoxFit.fill
                ))
            )
        ),
      );
  }
}
