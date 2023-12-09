
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/components/tarotcard/component-tarot-card-flip.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/models/enums/enum-spread-type.dart';

import '../models/cards/response-tarot-core.dart';
import '../models/enums/enum-tarot-product.dart';
import '../models/responses/Response.dart';
import '../models/tarot-list.dart';
import '../providers/tarot-card-provider.dart';
import '../services/error-handler.dart';

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
  
  // 데이터 베이스에 저장을 하기 위한 프로바이더 
  late HiveDiaryProvider m_hiveDiaryProvider;
  
  @override
  void onInit() {
    super.onInit();
    
    // 하이브 다이어리 초기화
    m_hiveDiaryProvider = Get.put(HiveDiaryProvider());
    
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
  
  
  void addSelectedCard(String cardImagePath) {
    // 선택된 카드에 추가한다.
    selectedCards.add(cardImagePath);
    update();
  }
  
  // /// 카드를 추가한다.
  // Future<ResponseResult> addSelectedCardAsync(String cardImagePath) async {
  //   ResponseResult response;
  //   try {
  //     // 등록된적 있는 카드인경우 
  //     if(selectedCards.any((item) => item == cardImagePath)) {
  //       return ResponseResult("CME001", "등록된적이 있는 카드입니다.");
  //     }
  //     //
  //     // // 데이터베이스에 카드를 추가한다.
  //     // response = await m_hiveDiaryProvider.addCardToDiaryAsync(
  //     //     EnumTarotProduct.riderWaited ,
  //     //     cardImagePath,
  //     //     1
  //     // );
  //
  //     // // 결과가 성공이 아닌경우
  //     // if(response.result != EnumResponseResult.Success) {
  //     //   return response;
  //     // }
  //
  //     // 선택된 카드에 추가한다.
  //     selectedCards.add(cardImagePath);
  //
  //     // UI 를 업데이트한다.
  //     update();
  //   } catch(ex) {
  //     response = ResponseResult("CME099", "에러가 발생했습니다.");
  //     ErrorHandler.log(ex);
  //   }
  //   return response;
  // }

  
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