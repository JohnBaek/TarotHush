import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/controller-tarot-card-list.dart';
import '../../controllers/controller-widget-resize.dart';

/// 다이어리뷰 메인 페이지 
class ComponentTarotSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 타로카드 상태관리 컨트롤러 등록
    Get.put(TarotCardListController());
    // EasyLoading.showToast('${Get.find<TarotCardListController>().completeCount} 장의 카드를 선택해주세요' ,toastPosition:  EasyLoadingToastPosition.top);
    return
      GetBuilder<WidgetResizeController>(builder: (widgetResizeController) {
        return
          GetBuilder<TarotCardListController>(builder: (controller){
          double widthWidget = MediaQuery.of(context).size.width;

          double cardWith = 0.0;
          double correct = 0.0;
          double stackSkew = 0.4;
          double top = 0.0;
          
          if(widthWidget < 900.0) {
            correct = 160;
            cardWith = 100;
            top = 120;
          }
          else {
            correct = 290;
            cardWith = 150;
            top = 160;
          }

          double widgetWidth = widthWidget;
          int cardsPerRow = (widgetWidth / cardWith / stackSkew - 1 / stackSkew).floor();

          return
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: 
                Stack(
                  children: [
                    ...controller.tarotCards
                        .asMap()
                        .map(
                          (index, card) {
                        return
                          MapEntry(
                            index,
                            Positioned(
                              left: stackSkew * cardWith * (index - (cardsPerRow) * (index / cardsPerRow).floor()),
                              top: (top-50) * (index / cardsPerRow).floor(),
                              child: card
                            ),
                          );
                      },
                    ).values.toList()
                  ]
              ),
            );
        });
    });
  }
}


