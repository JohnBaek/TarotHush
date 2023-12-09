
import '../enums/enum-tarot-product.dart';

/// 다이어리 응답 객체
class ResponseDiary {
  // 다이어리 아이디
  String id = "";

  // 다이어리 등록시간
  late DateTime regDate;
  
  // 다이어리 상세
  late List<ResponseDiaryDetail> diaryDetails;
}

/// 다이어리 상세
class ResponseDiaryDetail {
  // 카드 이미지 경로
  String imagePath = "";

  // 카드 시퀀스 번호
  int sequence = 0;

  // 카드 종류
  EnumTarotProduct enumTarotProduct = EnumTarotProduct.riderWaited;
}