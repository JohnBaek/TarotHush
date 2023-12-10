import 'package:darq/darq.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';
import 'package:my_app/models/responses/diary/response-diary.dart';
import 'package:my_app/utils/logger.dart';

import '../../components/component-card-view.dart';
import '../../models/hive/hive-diary-detail.dart';
import '../../models/hive/hive-diary.dart';
import '../../models/responses/response-data.dart';
import '../../models/responses/response-list.dart';

/// 카드 뷰 컨트롤러 
class ViewDiaryController extends GetxController {
  // 최초 데이터 패칭 여부
  bool _hasFetched = false;
  
  // 다이어리 리스트
  List<ResponseDiary> diaryList = [];
  
  // 다이어리 박스 
  late final Box<HiveDiary> _hiveDiaryBox;
  
  // 다이어리 디테일 박스
  late final Box<HiveDiaryDetail> _hiveDiaryDetailBox;
  
  @override
  void onInit() {
    super.onInit();
    _hiveDiaryBox = GetIt.instance<Box<HiveDiary>>();
    _hiveDiaryDetailBox = GetIt.instance<Box<HiveDiaryDetail>>();
  }
  
  /// 패치 여부를 업데이트한다
  /// [hasFetched] 패치 여부
  void updateFetch(bool hasFetched){
    _hasFetched = hasFetched;
    update();
  }
  
  
  /// 다이어리 리스트를 추가한다.
  /// [list] 다이어리 리스트
  void addDiaryList(List<ResponseDiary> list){
    diaryList.addAll(list);
    update();
  }
  
  /// 다이어리 리스트를 초기화한다.
  void clearDiary() {
    diaryList = [];
    update();
  }
  
  /// 데이터베이스에 저장된 다이어리 리스트를 가져온다.
  Future<ResponseList<ResponseDiary>> getDiaryAsync() async {
    ResponseList<ResponseDiary> result;
    try {
      // 저장된 모든 하이브 다이어리 리스트를 가져온다.
      List<HiveDiary> hiveDiaryList = _hiveDiaryBox.values.orderByDescending((element) => element.regDate).toList();
      
      // 저장된 모든 하이브 다이어리 상세 리스트를 가져온다.
      List<HiveDiaryDetail> hiveDiaryDetailList = _hiveDiaryDetailBox.values.toList();
      
      // 응답 결과 아이템 정보 
      List<ResponseDiary> items = [];
      
      // 모든 하이브 다이어리 리스트에 대해 처리
      for(HiveDiary hiveDiary in hiveDiaryList) {
        ResponseDiary addDiary = ResponseDiary.fromHive(hiveDiary);
        
        // 해당하는 상세 아이템을 조회한다.
        List<HiveDiaryDetail> detailList = hiveDiaryDetailList
            .where((element) => element.diaryId == addDiary.id)
            .orderBy((element) => element.sequence)
            .toList();
        
        // 디테일 정보를 추가 한다.
        addDiary.fromDetailHive(detailList);
        items.add(addDiary);
      }
      
      result = ResponseList.withData(result: EnumResponseResult.success, code: "", message: "", items: items);
    }catch(ex) {
      Logger.error(ex);
      result = ResponseList(result: EnumResponseResult.error, code: "CMM01", message: "처리중 예외가 발생했습니다.");
    }
    return result;
  } 
  
  /// 패치 여부 플래그를 반환한다.
  bool getHasFetched() {
    return _hasFetched;
  }

  /// 다이어리를 추가한다.
  /// [diary] ResponseDiary 객체
  void addDiary(ResponseDiary diary) {
    // 데이터를 추가한다.
    diaryList.insert(0, diary);
    update();
  }
  
  //
  // /// 다이어리에 데이터를 하나 추가한다.
  // Future<ResponseData<ResponseTarotCardMetadata>> addDiaryAsync(ResponseTarotCardMetadata metadata) async{
  //   ResponseData<ResponseTarotCardMetadata> result;
  //   try {
  //    
  //    
  //   }catch(ex) {
  //     Logger.error(ex);
  //   }
  //   return result;
  // }
}
    
    