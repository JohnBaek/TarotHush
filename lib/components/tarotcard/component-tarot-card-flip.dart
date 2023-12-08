import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-card-view.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-core.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/views/view-diary-controller.dart';
import 'package:uuid/uuid.dart';

import '../../controllers/controller-tarot-card-list.dart';
import '../../models/hive/hive-diary-detail.dart';
import '../../models/responses/Response.dart';
import 'component-tarot-card-front.dart';
import '../../navigation-key.dart';

/// 타로 카드 완전체 객체
class ComponentTarotCardFlip extends StatelessWidget {
  // 카드이미지의 저장 경로 
  final String cardImagePath;
  /// 생성자 
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
                onTap:() async {
                  // 타로 카드 셀렉터 컨트롤러를 가져온다.
                  TarotCardSelectorController selectorController = Get.find<TarotCardSelectorController>();

                  // 카드 숫자가 선택 완료 된경우 
                  if(selectorController.isCompleted()) {
                    return;
                  }

                  // 클릭한 타로카드를 추가한다.
                  ResponseResult result = await controller.addSelectedCardAsync(cardImagePath);

                  // 실패일경우
                  if(result.result != EnumResponseResult.Success) {
                    EasyLoading.showToast(result.message);
                    return;
                  }

                  // 선택이 완료된경우 2초후 자동 닫힘
                  if(selectorController.isCompleted()) {
                    dismissTarotSelectorDialog(selectorController);
                    EasyLoading.showToast("Card Selected");
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
    
    // Call of reference 방지
    List<String> cardList = [];
    for(String card in selectorController.selectedCards) {
      cardList.add(card);
    }
    
    // 선택된 카드를 세팅한다.
    viewDiaryController.addItem(addNewDiaryItem(cardList));
  }

  /// 다이어리에 아이템을 하나 추가한다.
  ComponentCardView addNewDiaryItem(List<String> selectedCards) {
    print("addNewDiaryItem");
    selectedCards.forEach((element) {
      print(element);
    });
    
    
    return ComponentCardView(
      dateTime: DateTime.now(),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 모든 카드에 대해 처리한다.
          for(int i=0; i < selectedCards.length; i++)
            Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    print(selectedCards[i]);
                    showTarotScreen(navigatorKey.currentContext!,selectedCards[i]);
                  },
                  child:
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child:Container(
                          margin: const EdgeInsets.fromLTRB(20,20,20,10),
                          child: ComponentTarotCardFront(cardImagePath: selectedCards[i],width: 100,height: 180)
                      )
                  ),
                ),
                // 선택된 카드의 번호
                Text((i + 1).toString())
              ],
            )
        ],
      ),
    );
  }

  /// 확대된 타로카드를 출력한다.
  showTarotScreen(BuildContext buildContext, String selectedCard)  {
    showDialog(
        context: buildContext,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (buildContext) {
          return
            GetBuilder<TarotCardSelectorController>(
                builder: (TarotCardSelectorController controller) {
                  return
                    Dialog(
                        backgroundColor: Colors.transparent,
                        child: ComponentTarotCardFront(
                          width: 300,
                          height: 500,
                          cardImagePath: selectedCard,
                        )
                    );
                }
            );
            
        }
    );
  }
}




