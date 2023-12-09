import 'dart:developer';

import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../models/enums/enum-response-result.dart';
import '../models/enums/enum-tarot-product.dart';
import '../models/hive/hive-diary-detail.dart';
import '../models/responses/response-core.dart';
import '../models/responses/diary/response-diary.dart';
import '../models/responses/response-list.dart';
import '../utils/logger.dart';

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
  Future<ResponseCore> addCardToDiaryAsync(EnumTarotProduct enumTarotProduct ,String cardImagePath, int sequence) async {
    ResponseCore response;
    return ResponseCore(result: EnumResponseResult.error, code: "code", message: "message");
    // try {
    //   // 아이디를 생성한다.
    //   String diaryId = const Uuid().v4();
    //
    //   // 생성시간을 만든다.
    //   DateTime regDate = DateTime.now();
    //
    //   // 마스터 테이블에 데이터를 넣는다.
    //   await m_diaryBox.put(diaryId, HiveDiary(id: diaryId, regDate: regDate));
    //   m_diaryBox.values.toList().forEach((item) => print(item.id));
    //
    //   // 상세 정보에 데이터를 넣는다.
    //   String detailId = const Uuid().v4();
    //   await m_diaryDetailBox.put(
    //       detailId,
    //       HiveDiaryDetail(
    //             id: detailId
    //           , diaryId: diaryId
    //           , imagePath: cardImagePath
    //           , sequence: sequence
    //           , regDate: regDate
    //           , enumTarotProduct: enumTarotProduct
    //           ));
    //
    //   print("등록 성공");
    //
    //   return ResponseCore.only(EnumResponseResult.Success);
    // } catch(ex) {
    //   response = ResponseCore("CME1", "처리중 예외가 발생했습니다.");
    //   ErrorHandler.log(ex);
    // }
    // return response;
  }
  
  /// 시스템에 저장된 다이어리 목록을 불러온다.
  ResponseList<ResponseDiary> getDiaryList() {
    ResponseList<ResponseDiary> result;
    return ResponseList(result: EnumResponseResult.error, code: "code", message: "message");
    
    // try {
    //   // 다이어리 목록을 가져온다.
    //   List<HiveDiary> diaryList = m_diaryBox.values.toList().orderByDescending((item) => item.regDate).toList();
    //   List<ResponseDiary> items = [];
    //  
    //   // 모든 다이어리 목록에 대해 처리한다.
    //   for(HiveDiary diary in diaryList) {
    //       ResponseDiary addDiary = ResponseDiary();
    //       addDiary.id = diary.id;
    //       addDiary.regDate = diary.regDate;
    //       addDiary.diaryDetails = [];
    //      
    //       // 디테일 정보에대해 조회한다.
    //       List<HiveDiaryDetail> diaryDetails = m_diaryDetailBox.values.where((element) => element.diaryId == diary.id).toList();
    //      
    //       // 모든 상세정보에 대해 처리한다.
    //       for(HiveDiaryDetail detail in diaryDetails) {
    //         ResponseDiaryDetail addDetail = ResponseDiaryDetail();
    //         addDetail.enumTarotProduct = detail.enumTarotProduct;
    //         addDetail.imagePath = detail.imagePath;
    //         addDetail.sequence = detail.sequence;
    //         addDiary.diaryDetails.add(addDetail);
    //       }
    //       items.add(addDiary);
    //   }
    //   return ResponseList.withItem(EnumResponseResult.Success,"", "", items);
    // }catch(ex) {
    //   result = ResponseList<ResponseDiary>("CME1", "처리중 예외가 발생했습니다.");
    //   ErrorHandler.log(ex);
    // }
    //
    // return result;
  }

  /// 데이터베이스에 카드를 저장한다.
  Future<ResponseCore> addCardsAsync(List<String> selectedCards) async {
    ResponseCore response;
    return ResponseCore(result: EnumResponseResult.error, code: "code", message: "message");
    // try {
    //   // 아이디를 생성한다.
    //   String diaryId = const Uuid().v4();
    //
    //   // 생성시간을 만든다.
    //   DateTime regDate = DateTime.now();
    //
    //   // 마스터 테이블에 데이터를 넣는다.
    //   await m_diaryBox.put(diaryId, HiveDiary(id: diaryId, regDate: regDate));
    //   m_diaryBox.values.toList().forEach((item) => print(item.id));
    //
    //   // 모든 카드를 디테일 정보에 넣는다
    //   int sequence = 0;
    //   for(String cardPath in selectedCards) {
    //     String detailId = const Uuid().v4();
    //     await m_diaryDetailBox.put(
    //         detailId,
    //         HiveDiaryDetail(
    //             id: detailId
    //             , diaryId: diaryId
    //             , imagePath: cardPath
    //             , sequence: ++sequence
    //             , regDate: regDate
    //             , enumTarotProduct: EnumTarotProduct.riderWaited
    //         ));
    //   }
    //   print("등록 성공");
    //
    //   return ResponseCore.only(EnumResponseResult.Success);
    // } catch(ex) {
    //   response = ResponseCore("CME1", "처리중 예외가 발생했습니다.");
    //   ErrorHandler.log(ex);
    // }
    // return response;
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