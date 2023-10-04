import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-flip.dart';
import 'package:my_app/models/enums/enum-spread-type.dart';

import '../components/component-card-view.dart';
import '../components/tarotcard/component-tarot-card-front.dart';
import '../models/cards/response-tarot-core.dart';
import '../models/tarot-list.dart';

/// 카드 뷰 컨트롤러 
class ViewDiaryController extends GetxController {
  /// 카드뷰 아이템
  List<ComponentCardView> cardViewItems = [];
  
  @override
  void onInit() {
    super.onInit();
  } 
  
  /// 아이템을 하나 추가한다.
  void addItem(ComponentCardView item) {
    // 앞에서 부터 추가한다.
    cardViewItems.insert(0,item);
    update();
  }
}
    
    