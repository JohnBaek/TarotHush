
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-flip.dart';
import 'package:my_app/models/enums/enum-spread-type.dart';

import '../models/cards/response-tarot-core.dart';
import '../models/tarot-list.dart';

/// 위젯 리사이즈 컨트롤러 
class TarotCardSelectorController extends GetxController {
  // 타로 카드 셀렉터 폼 키 
  BuildContext? tarotSelectorContext;

  // 타로카드 위젯 
  List<ComponentTarotCardFlip> tarotCards = [];

  // 선택할 카드 카운트 ( 몇개까지 선택해야하는지 )
  int completeCount = 0;

  // 선택한 카드 
  List<String> selectedCards = [];
  
  // 현재 선택한 타로카드
  String selectedCard = '';
  
  @override
  void onInit() {
    super.onInit();
    // 모든 카드에 대해 처리한다.
    for(ResponseTarotCore card in TarotList().cards) {
      tarotCards.add(ComponentTarotCardFlip(cardImagePath: 'assets/images/tarots/rider-waited-classic/${card.imageName}'));
    }
  } 
  
  /// 현재 선택한 셀렉트 카드를 업데이트한다.
  void setSelectedCard(String card) {
    selectedCard = card;
    update();
  }
  
  /// 카드를 셔플한다.
  void shuffleCard(){
    // 카드를 셔플한다.
    tarotCards.shuffle();
    update();
  }
  
  /// 카드를 추가한다.
  void addSelectedCard(String cardImagePath) {
    // 등록된적 없는 카드인경우 
    if(!selectedCards.any((item) => item == cardImagePath)) {
      selectedCards.add(cardImagePath);
    }
    update();
  }

  
  /// 선택한 카드를 초기화한다.
  void clearSelectedCards(){
    selectedCards.clear();
    update();
  }

  /// 스프레드 카운트를 세팅한다.
  void setCompleteCount(EnumSpreadType enumSpreadType) {
    switch(enumSpreadType) {
      // 쓰리카드 스프레드인경우 
      case EnumSpreadType.threeCardSpread :
        completeCount = 3;
        break;
      case EnumSpreadType.oneCardSpread:
        completeCount = 1;
        break;
    }
    update();
  }
  
  /// 카드 선택 완료 여부
  bool isCompleted(){
    return completeCount <= selectedCards.length;
  }
  
  /// 다이얼로그의 컨텍스트를 세팅한다.
  void setContext(BuildContext? context){
    tarotSelectorContext = context;
    update();
  }
}