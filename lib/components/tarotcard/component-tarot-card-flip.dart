import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-core.dart';

import '../../controllers/controller-tarot-card-list.dart';

/// 타로 카드 완전체 객체
class ComponentTarotCardFlip extends StatelessWidget {
  final String cardImagePath;
  const ComponentTarotCardFlip({super.key, required this.cardImagePath});
  
  @override
  Widget build(BuildContext context) => Card(
      elevation: 0.0,
      color: const Color(0x00000000),
      child:
        GetBuilder<TarotCardSelectorController>(
          builder: (TarotCardSelectorController controller) { 
            return
              GestureDetector(
                onTap:() {
                  // 클릭한 타로카드를 추가한다.
                  controller.addSelectedCard(cardImagePath);

                  // 타로 카드 셀렉터 컨트롤러를 가져온다.
                  TarotCardSelectorController selectorController = Get.find<TarotCardSelectorController>();

                  // 카드 숫자가 선택 완료 된경우 
                  if(selectorController.isCompleted()) {
                    // 셀렉터 창을 닫는다.
                    Future.delayed(const Duration(seconds: 1),() {
                      Navigator.pop(selectorController.tarotSelectorContext!);
                    });
                  }
                } ,
                child: Stack(
                  children: [
                    // 뒷면
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ComponentTarotCardCore(fillColor:Colors.white,borderColor:Colors.black,widget:Image(image: AssetImage(cardImagePath), fit: BoxFit.fill)),
                      ],
                    ),
                    Visibility(
                        visible: controller.selectedCards.where((element) => element == cardImagePath).isEmpty,
                        child:
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            ComponentTarotCardCore(fillColor:Colors.white,borderColor:Colors.black,widget:null),
                            ComponentTarotCardCore(fillColor:Colors.blue,borderColor:Colors.black,widget:null),
                          ],
                        )
                    )
                  ],
                ),
              );
          },)
    );
  
  /// 카드의 아웃라인을 리턴한다.
  Widget cardOutline(double width, double height, Color fillColor, Color borderColor, Widget? childWidget) {
      if(childWidget == null) {
        return
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color:borderColor,width: 1.0),
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
            border: Border.all(color:borderColor,width: 1.0),
            color: Color(fillColor.value),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: childWidget,
        );
  }
}




