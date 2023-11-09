import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/hive/hive-diary-detail.dart';
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:uuid/uuid.dart';

/// 하이브 다이어리 프로바이더
class HiveDiaryProvider extends GetxController{
  /// 다이어리 테이블
  late final tableDiary;
  
  /// 다이어리 디테일 테이블
  late final tableDiaryDetail;
  
  /// 생성자
  HiveDiaryProvider() {
    tableDiary = Hive.openBox<HiveDiary>('HiveDiary');
    tableDiaryDetail = Hive.openBox<HiveDiaryDetail>('HiveDiaryDetail');
  }
  
  /// 다이어리 요소를 하나 추가한다.
  addDiary(List<HiveDiaryDetail> detailList){
    // 상위 다이어리 요소 하나를 생성한다.
    HiveDiary hiveDiary = HiveDiary(id: const Uuid().v4(), regDate: DateTime.now());
    
    // 디테일 요소를 설정한다.
    for(HiveDiaryDetail item in detailList) {
      // 아이디 설정 
      item.diaryId = hiveDiary.id;
      // 등록시간 설정
      item.regDate = hiveDiary.regDate;
    }
    
    // 하이브에 루트 다이어리 요소를 등록한다.
    tableDiary.put(hiveDiary);
    
    // 하이브에 다이어리 디테일 요소를 등록한다.
    tableDiaryDetail.put(detailList);
  }
}