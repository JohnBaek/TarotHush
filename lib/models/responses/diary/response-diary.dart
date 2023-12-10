
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';

import '../../enums/enum-tarot-product.dart';
import '../../hive/hive-diary-detail.dart';

/// 다이어리 응답 객체
class ResponseDiary {
  // 다이어리 아이디
  late String id = "";

  // 다이어리 등록시간
  late DateTime regDate;
  
  // 다이어리 상세
  late List<ResponseDiaryDetail> items = [];

  /// 생성자
  /// [hiveDiary] 하이브 다이어리 객체 
  ResponseDiary.fromHive(HiveDiary hiveDiary) {
    id = hiveDiary.id;
    regDate = hiveDiary.regDate;
  }
  
  /// 생성자
  /// [hiveDiaryDetails] 하이브 상세 다이어리 리스트
  fromDetailHive(List<HiveDiaryDetail> hiveDiaryDetails){
    // 모든 상세에 대해 처리한다.
    for(HiveDiaryDetail detail in hiveDiaryDetails) {
      items.add(ResponseDiaryDetail.fromHive(detail));
    }
  }
}

/// 다이어리 상세
class ResponseDiaryDetail {
  // 아이디 값
  late String id;
  
  // 카드 이미지 경로
  late ResponseTarotCardMetadata metadata;

  // 카드 시퀀스 번호
  late int sequence = 0;

  /// 생성자
  /// [hiveDiaryDetail] 하이브에서 가져온 디테일 데이터
  ResponseDiaryDetail.fromHive(HiveDiaryDetail hiveDiaryDetail){
    id = hiveDiaryDetail.id;
    metadata = hiveDiaryDetail.metadata.toResponse();
    sequence = hiveDiaryDetail.sequence;
  }
}