
import 'package:get/get.dart';
import 'package:my_app/components/tarot-card-flip.dart';
import 'package:my_app/providers/widget-resize-controller.dart';

import '../components/tarot-card-flip.dart';
import '../models/cards/response-tarot-core.dart';
import '../models/tarot-list.dart';

/// 위젯 리사이즈 컨트롤러 
class TarotCardListController extends GetxController {
  List<TarotCardFlip> tarotCards = [];

  @override
  void onInit() {
    super.onInit();
    // 모든 카드에 대해 처리한다.
    for(ResponseTarotCore card in TarotList().cards) {
      tarotCards.add(TarotCardFlip(cardImagePath: 'assets/images/tarots/rider-waited-classic/${card.imageName}'));
    }
    // 초기화한후 최초 한번 셔플
    // tarotCards.shuffle();
  } 
  
  // 카드를 셔플한다.
  void shuffleCard(){
    // 카드를 셔플한다.
    tarotCards.shuffle();
    update();
  }
}