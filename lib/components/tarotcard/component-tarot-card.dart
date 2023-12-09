import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-card-view.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-core.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';
import 'package:my_app/utils/logger.dart';
import 'package:my_app/views/diary/view-diary-controller.dart';
import 'package:uuid/uuid.dart';

import 'component-tarot-card-controller.dart';
import '../../models/hive/hive-diary-detail.dart';
import '../../models/responses/response-core.dart';
import '../../providers/tarot-card-provider.dart';
import 'component-tarot-card-front.dart';
import '../../navigation-key.dart';

/// 타로 카드 객체
class ComponentTarotCard extends StatelessWidget {
  // 타로카드 메타 정보 
  final ResponseTarotCardMetadata tarotCardMetadata;
  
  /// 생성자 
  /// [tarotCardMetadata] 타로카드 메타정보
  const ComponentTarotCard({super.key, required this.tarotCardMetadata});
  
  @override
  Widget build(BuildContext context) => Card(
      elevation: 0.0,
      color: const Color(0x00000000),
      child:
        GetBuilder<ComponentTarotCardController>(
          builder: (ComponentTarotCardController controller) { 
            return
              GestureDetector(
                // 타로카드 클릭시
                onTap:() async {
                  clickCard(controller,tarotCardMetadata);
                } ,
                child: Stack(
                  children: [
                    // 카드의 앞면
                    ComponentTarotCardFront(imagePath:tarotCardMetadata.imagePath ,width: 70 ,height: 120),
                    
                    // 카드를 클릭해서 선택한 경우 카드의 뒷면을 보이게 처리하기 위한
                    Visibility(
                        // 선택하지 않은경우 뒷면을 보인다.
                        visible: !controller.hasSelected(tarotCardMetadata) ,
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
  void dismissTarotSelectorDialog(ComponentTarotCardController selectorController) {
    Navigator.of(selectorController.tarotSelectorContext!).pop();
    // Call of reference 방지
    List<String> cardList = [];
    for(String card in selectorController.selectedCards) {
      cardList.add(card);
    }
    
    // 선택된 카드를 세팅한다.
    // viewDiaryController.addItem(addNewDiaryItem(cardList));
  }

  /// 다이어리에 아이템을 하나 추가한다.
  ComponentDiaryItem addNewDiaryItem(List<String> selectedCards) {
    print("addNewDiaryItem");
    selectedCards.forEach((element) {
      print(element);
    });
    return ComponentDiaryItem(
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
                          child: ComponentTarotCardFront(imagePath: selectedCards[i],width: 100,height: 180)
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
            GetBuilder<ComponentTarotCardController>(
                builder: (ComponentTarotCardController controller) {
                  return
                    Dialog(
                        backgroundColor: Colors.transparent,
                        child: ComponentTarotCardFront(
                          width: 300,
                          height: 500,
                          imagePath: selectedCard,
                        )
                    );
                }
            );
        }
    );
  }

  /// 카드 클릭시
  /// [controller] ComponentTarotCardController 객체
  /// [tarotCardMetadata] 타로카드 메타 데이터
  Future<void> clickCard(ComponentTarotCardController controller, ResponseTarotCardMetadata tarotCardMetadata) async {
    try {
      // 카드 추가
      controller.addSelectedCard(tarotCardMetadata);

      // 선택이 완료된경우 2초후 자동 닫힘
      if(controller.selectedCompleted()) {
        // 데이터베이스에 선택된 카드를 추가한다.
        ResponseCore responseCore = await controller.syncSelectedCardAsync();
        
        // 실패한 경우
        if(responseCore.result != EnumResponseResult.success) {
          EasyLoading.showError(responseCore.message);
        }
        
        dismissTarotSelectorDialog(controller);
      } 
    }catch(ex) {
      Logger.error(ex);
      EasyLoading.showError("예외가 발생 했습니다.");
    }
  }
}




