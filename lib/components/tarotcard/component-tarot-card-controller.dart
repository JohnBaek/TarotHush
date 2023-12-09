
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_app/components/tarotcard/component-tarot-card.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/models/enums/enum-card-spread-type.dart';
import 'package:my_app/models/hive/hive-diary-detail.dart';
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

import '../../models/hive/hive-tarot-card-metadata.dart';
import '../../models/responses/cards/response-tarot-metadata.dart';
import '../../models/enums/enum-tarot-product.dart';
import '../../models/responses/response-core.dart';
import '../../models/tarot-list.dart';
import '../../providers/tarot-card-provider.dart';
import '../../utils/logger.dart';

/// 타로카드 컨트롤러
class ComponentTarotCardController extends GetxController {
  // 타로 카드 셀렉터 폼 키 
  BuildContext? tarotSelectorContext;

  // 타로카드 위젯 
  List<ComponentTarotCard> tarotCards = [];

  // 선택할 카드 카운트 ( 몇개까지 선택해야하는지 )
  int completeCount = 0;

  // 선택한 카드 
  List<String> selectedCards = [];
  
  // 현재 선택한 타로카드
  String selectedCard = '';

  // 하이브 메타데이터 박스 
  late final Box<HiveTarotCardMetadata> _metaDataBox;
  
  // 하이브 다이어리 박스 
  late final Box<HiveDiary> _diaryBox;
  
  // 하이브 다이어리 디테일 박스
  late final Box<HiveDiaryDetail> _diaryDetailBox;
  
  // 카드 메타데이터
  List<ResponseTarotCardMetadata> cardMetaDataList = [];

  // 선택된 카드 리스트
  List<ResponseTarotCardMetadata> selectedCardList = [];

  @override
  void onInit() {
    super.onInit();
    
    // 하이브 인스턴스 초기화
    _metaDataBox = GetIt.instance<Box<HiveTarotCardMetadata>>();
    _diaryBox = GetIt.instance<Box<HiveDiary>>();
    _diaryDetailBox = GetIt.instance<Box<HiveDiaryDetail>>();
    
    // 모든 카드에 대해 처리한다.
    for(HiveTarotCardMetadata cardMetaData in _metaDataBox.values.toList()) {
      cardMetaDataList.add(ResponseTarotCardMetadata.fromHive(cardMetaData));
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
    cardMetaDataList.shuffle();
    update();
  }

  /// 셀렉터 에서 사용자가 선택한 카드 하나를 추가한다.
  /// [cardMetadata] 카드 메타 데이터
  void addSelectedCard(ResponseTarotCardMetadata cardMetadata) {
    // 선택된 카드에 추가 한다.
    selectedCardList.add(cardMetadata);
    update();
  }

  /// 이미 선택 했던 카드인지 확인한다.
  /// [cardMetadata] 카드 메타 데이터
  bool hasSelected(ResponseTarotCardMetadata cardMetadata){
    return selectedCardList.any((element) => element == cardMetadata);
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
    // 선택된 카드 초기화
    selectedCardList.clear();
    update();
  }

  /// 스프레드 종류에 따라 카드 선택 갯수를 조정한다.
  /// [EnumCardSpreadType] 스프레드 종류
  void setCompleteCount(EnumCardSpreadType enumSpreadType) {
    switch(enumSpreadType) {
      // 쓰리카드 스프레드 인경우 
      case EnumCardSpreadType.threeCardSpread :
        completeCount = 3;
        break;
      // 원카드 스프레드 인경우
      case EnumCardSpreadType.oneCardSpread:
        completeCount = 1;
        break;
    }
    update();
  }
  
  /// 카드 선택 완료 여부
  bool selectedCompleted(){
    return completeCount <= selectedCardList.length;
  }
  
  /// 다이얼로그의 컨텍스트를 세팅한다.
  void setContext(BuildContext? context){
    tarotSelectorContext = context;
    update();
  }
  
  /// 선택된 카드를 데이터베이스에 업데이트 한다.
  Future<ResponseCore> syncSelectedCardAsync() async {
    ResponseCore result;
    try {
      // 다이어리 정보를 추가한다.
      HiveDiary addDiary = HiveDiary(id: const Uuid().v4(), regDate: DateTime.now());
      await _diaryBox.put(addDiary.id, addDiary);
      
      // 다이어리 상세 정보를 추가한다.
      int sequence = 0;
      for(ResponseTarotCardMetadata metadata in selectedCardList) {
        // 디테일 정보 생성
        HiveDiaryDetail addDetail = HiveDiaryDetail(
              id: const Uuid().v4()
            , diaryId: addDiary.id
            , metadata: HiveTarotCardMetadata.fromResponse(metadata) 
            , sequence: ++sequence
            , regDate: addDiary.regDate
            , enumTarotProduct: metadata.enumTarotProduct
        );
        
        // 데이터베이스에 저장한다.
        await _diaryDetailBox.put(addDetail.id, addDetail);
      }
      
      result = ResponseCore.result(result: EnumResponseResult.success);
    }catch(ex) {
      result = ResponseCore(result: EnumResponseResult.error, code: "CM001", message: "데이터 처리중 예외가 발생했습니다.");
      Logger.error(ex);
    }
    return result;
  }
}