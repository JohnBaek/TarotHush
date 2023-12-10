import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component-tarot-card-controller.dart';
import 'component-tarot-card.dart';

/// 다이어리뷰 메인 페이지
class ComponentTarotSelector extends StatelessWidget {
  const ComponentTarotSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComponentTarotCardController>(builder: (controller) {
      double widthWidget = MediaQuery.of(context).size.width;
      double cardWith = 100;
      double stackSkew = 0.5;
      double top = 0.0;

      if (widthWidget < 900.0) {
        top = 120;
      } else {
        top = 150;
      }

      double widgetWidth = widthWidget;
      int cardsPerRow =
          (widgetWidth / cardWith / stackSkew - 1 / stackSkew).floor();

      return Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Stack(children: [
          ...controller.cardMetaDataList
              .asMap()
              .map(
                (index, card) {
                  return MapEntry(
                    index,
                    Positioned(
                        left: stackSkew *
                            cardWith *
                            (index -
                                (cardsPerRow) * (index / cardsPerRow).floor()),
                        top: (top) * (index / cardsPerRow).floor(),
                        child: MouseRegion(
                        cursor: 
                          SystemMouseCursors.click, 
                          child:
                            ComponentTarotCard(metadata: card)
                        )),
                  );
                },
              )
              .values
              .toList()
        ]),
      );
    });
  }
}
