import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/models/responses/diary/response-diary.dart';

import '../components/component-card-view.dart';

/// 카드 뷰 컨트롤러 
class ViewDiaryController extends GetxController {
  /// 카드뷰 아이템
  List<ComponentCardView> cardViewItems = [];
  
  List<ResponseDiary> diaryCards = [];
  
  /// 아이템을 하나 추가한다.
  void addItem(ComponentCardView item) {
    // 앞에서 부터 추가한다.
    cardViewItems.insert(0,item);
    update();
  }
  
  void addItems(List<ResponseDiary> list){
    diaryCards.addAll(list);
    update();
  }
  
}
    
    