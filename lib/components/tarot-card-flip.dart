import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/tarot-card-core.dart';

class TarotCardFlip extends StatelessWidget {
  final String cardImagePath;
  const TarotCardFlip({super.key, required this.cardImagePath});

  @override
  Widget build(BuildContext context) => Card(
      elevation: 0.0,
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlip: (){
          print(1);
        },
        onFlipDone: (status) {
        },
        front: const Stack(
            alignment: Alignment.center,
            children: [
              TarotCardCore(fillColor:Colors.white,borderColor:Colors.black,widget:null),
              TarotCardCore(fillColor:Colors.redAccent,borderColor:Colors.black,widget:null),
            ],
          ),
        back: Stack(
          alignment: Alignment.center,
          children: [
            TarotCardCore(fillColor:Colors.white,borderColor:Colors.black,widget:Image(image: AssetImage(cardImagePath), fit: BoxFit.fill)),
          ],
        ),
      ),
    );
  
  /// 카드의 아웃라인을 리턴한다.
  Widget cardOutline(double width, double height, Color fillColor, Color borderColor, Widget? childWidget) {
      if(childWidget == null) {
        return
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color:borderColor,width: 4.0),
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
            border: Border.all(color:borderColor,width: 2.0),
            color: Color(fillColor.value),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: childWidget,
        );
  }
}




