import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-card-view.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-core.dart';
import 'package:my_app/views/view-diary-controller.dart';

import '../../controllers/controller-tarot-card-list.dart';
import 'component-tarot-card-front.dart';

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
                  // 타로 카드 셀렉터 컨트롤러를 가져온다.
                  TarotCardSelectorController selectorController = Get.find<TarotCardSelectorController>();

                  // 카드 숫자가 선택 완료 된경우 
                  if(selectorController.isCompleted()) {
                    // 셀렉터 창을 닫는다.
                    dismissTarotSelectorDialog(selectorController);
                  }
                  // 숫자가 완료되지 않은경우
                  else {
                    // 클릭한 타로카드를 추가한다.
                    controller.addSelectedCard(cardImagePath);
                  }
                } ,
                child: Stack(
                  children: [
                    ComponentTarotCardFront(cardImagePath:cardImagePath,width: 70,height: 120),
                    Visibility(
                        visible: controller.selectedCards.where((element) => element == cardImagePath).isEmpty,
                        child:
                        const Stack(
                          alignment: Alignment.center,
                          children: [
                            ComponentTarotCardCore(fillColor:Colors.white,borderColor:Colors.black,widget:null,width: 70,height: 120,),
                            ComponentTarotCardCore(fillColor:Colors.blue,borderColor:Colors.black,widget:null,width: 70,height: 120),
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

  /// 타로 카드 셀렉터 창을 닫는다.
  void dismissTarotSelectorDialog(TarotCardSelectorController selectorController) {
    Navigator.of(selectorController.tarotSelectorContext!).pop();
    // EasyLoading.showToast("Card Selected!");

    // 타로 카드 뷰 다이어리 컨트롤러를 가져온다.
    ViewDiaryController viewDiaryController = Get.find<ViewDiaryController>();
    viewDiaryController.addItem(addNewDiaryItem(viewDiaryController,selectorController.selectedCards));
  }

  /// 다이어리에 아이템을 하나 추가한다.
  ComponentCardView addNewDiaryItem(ViewDiaryController viewDiaryController, List<String> selectedCards) {
    return ComponentCardView(
      child: 
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 모든 카드에 대해 처리한다.
          for(String selectedItem in selectedCards)
            ComponentTarotCardFront(cardImagePath: selectedItem,width: 100,height: 180)
        ],
      ), 
    );
  }
}




