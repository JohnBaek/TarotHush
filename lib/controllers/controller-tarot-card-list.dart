import 'dart:ffi';

import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-flip.dart';

import '../components/tarotcard/component-tarot-card-flip.dart';
import '../models/cards/response-tarot-core.dart';
import '../models/tarot-list.dart';

/// 위젯 리사이즈 컨트롤러 
class TarotCardListController extends GetxController {
  List<ComponentTarotCardFlip> tarotCards = [];
  
  // 선택할 카드 카운트 ( 몇개까지 선택해야하는지 )
  int completeCount = 0;
  
  // 선택한 카드 
  List<String> selectedCards = [];
  
  @override
  void onInit() {
    super.onInit();
    // 모든 카드에 대해 처리한다.
    for(ResponseTarotCore card in TarotList().cards) {
      tarotCards.add(ComponentTarotCardFlip(cardImagePath: 'assets/images/tarots/rider-waited-classic/${card.imageName}'));
    }
  } 
  
  /// 카드를 셔플한다.
  void shuffleCard(){
    // 카드를 셔플한다.
    tarotCards.shuffle();
    update();
  }
  
  /// 카드를 추가한다.
  void addSelectedCard(String cardImagePath) {
    if(selectedCards.where((element) => element == selectedCards).isEmpty) {
      selectedCards.add(cardImagePath);
    }
    update();
  }
}