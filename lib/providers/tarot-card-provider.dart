import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../models/enums/enum-response-result.dart';
import '../models/enums/enum-tarot-product.dart';
import '../models/hive/hive-diary-detail.dart';
import '../models/responses/Response.dart';
import '../services/error-handler.dart';

/// 하이브 다이어리 프로바이더
class HiveDiaryProvider extends GetxController{
  /// Hive 다이어리 박스
  late final Box<HiveDiary> m_diaryBox;

  /// Hive 다이어리 상세 박스
  late final Box<HiveDiaryDetail> m_diaryDetailBox;

  /// 생성자
  HiveDiaryProvider(){
    m_diaryBox = GetIt.instance<Box<HiveDiary>>();
    m_diaryDetailBox = GetIt.instance<Box<HiveDiaryDetail>>();
  }

  /// 데이터베이스에 카드를 추가한다.
  Future<ResponseResult> addCardToDiaryAsync(EnumTarotProduct enumTarotProduct ,String cardImagePath, int sequence) async {
    ResponseResult response;
    try {
      // 아이디를 생성한다.
      String diaryId = const Uuid().v4();

      // 생성시간을 만든다.
      DateTime regDate = DateTime.now();

      // 마스터 테이블에 데이터를 넣는다.
      await m_diaryBox.put(diaryId, HiveDiary(id: diaryId, regDate: regDate));
      m_diaryBox.values.toList().forEach((item) => print(item.id));

      // 상세 정보에 데이터를 넣는다.
      String detailId = const Uuid().v4();
      await m_diaryDetailBox.put(
          detailId,
          HiveDiaryDetail(
                id: detailId
              , diaryId: diaryId
              , imagePath: cardImagePath
              , sequence: sequence
              , regDate: regDate
              , enumTarotProduct: enumTarotProduct
              ));

      print("등록 성공");

      return ResponseResult.name(EnumResponseResult.Success);
    } catch(ex) {
      response = ResponseResult("CME1", "처리중 예외가 발생했습니다.");
      ErrorHandler.log(ex);
    }
    return response;
  }
  
  // /// 다이어리 요소를 하나 추가한다.
  // addDiary(List<HiveDiaryDetail> detailList){
  //   // 상위 다이어리 요소 하나를 생성한다.
  //   HiveDiary hiveDiary = HiveDiary(id: const Uuid().v4(), regDate: DateTime.now());
  //
  //   // 디테일 요소를 설정한다.
  //   for(HiveDiaryDetail item in detailList) {
  //     // 아이디 설정 
  //     item.diaryId = hiveDiary.id;
  //     // 등록시간 설정
  //     item.regDate = hiveDiary.regDate;
  //   }
  //
  //   // 하이브에 루트 다이어리 요소를 등록한다.
  //   m_diaryBox.put(hiveDiary);
  //
  //   // 하이브에 다이어리 디테일 요소를 등록한다.
  //   diaryDetailBox.put(detailList);
  // }
}