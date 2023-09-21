import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/subject-text-h1.dart';
import '../components/tarot-card-flip.dart';

/// 다이어리뷰 메인 페이지 
class DiaryView extends StatelessWidget {
  const DiaryView({super.key});
  static const List<String> cards = [
    '00-TheFool.png'
    ,'01-TheMagician.png'
    ,'02-TheHighPriestess.png'
    ,'03-TheEmpress.png'
    ,'04-TheEmperor.png'
    ,'05-TheHierophant.png'
    ,'06-TheLovers.png'
    ,'07-TheChariot.png'
    ,'08-Strength.png'
    ,'09-TheHermit.png'
    ,'10-WheelOfFortune.png'
    ,'11-Justice.png'
    ,'12-TheHangedMan.png'
    ,'13-Death.png'
    ,'14-Temperance.png'
    ,'15-TheDevil.png'
    ,'16-TheTower.png'
    ,'17-TheStar.png'
    ,'18-TheMoon.png'
    ,'19-TheSun.png'
    ,'20-Judgement.png'
    ,'21-TheWorld.png'
    ,'Cups01.png'
    ,'Cups02.png'
    ,'Cups03.png'
    ,'Cups04.png'
    ,'Cups05.png'
    ,'Cups06.png'
    ,'Cups07.png'
    ,'Cups08.png'
    ,'Cups09.png'
    ,'Cups10.png'
    ,'Cups11.png'
    ,'Cups12.png'
    ,'Cups13.png'
    ,'Cups14.png'
    ,'Pentacles01.png'
    ,'Pentacles02.png'
    ,'Pentacles03.png'
    ,'Pentacles04.png'
    ,'Pentacles05.png'
    ,'Pentacles06.png'
    ,'Pentacles07.png'
    ,'Pentacles08.png'
    ,'Pentacles09.png'
    ,'Pentacles10.png'
    ,'Pentacles11.png'
    ,'Pentacles12.png'
    ,'Pentacles13.png'
    ,'Pentacles14.png'
    ,'Swords01.png'
    ,'Swords02.png'
    ,'Swords03.png'
    ,'Swords04.png'
    ,'Swords05.png'
    ,'Swords06.png'
    ,'Swords07.png'
    ,'Swords08.png'
    ,'Swords09.png'
    ,'Swords10.png'
    ,'Swords11.png'
    ,'Swords12.png'
    ,'Swords13.png'
    ,'Swords14.png'
    ,'Wands01.png'
    ,'Wands02.png'
    ,'Wands03.png'
    ,'Wands04.png'
    ,'Wands05.png'
    ,'Wands06.png'
    ,'Wands07.png'
    ,'Wands08.png'
    ,'Wands09.png'
    ,'Wands10.png'
    ,'Wands11.png'
    ,'Wands12.png'
    ,'Wands13.png'
    ,'Wands14.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0) ,
            child: TarotCardFlip(cardImagePath: 'assets/images/tarots/rider-waited-classic/${cards[Random().nextInt(cards.length)]}'),
          ),
          const SizedBox(height: 30),
          CupertinoButton.filled(
            onPressed: () {},
            child: const Text('Enabled'),
          ),
        ],
      ),
    );
  }

}


