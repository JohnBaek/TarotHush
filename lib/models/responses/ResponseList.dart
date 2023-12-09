import '../enums/enum-response-result.dart';

class ResponseList<T> {
  // 응답 결과
  EnumResponseResult result = EnumResponseResult.Error;

  // 응답 메세지
  String message = "";

  // 응답코드
  String code = "";
  
  // 페이징 카운트
  int pageCount = 0;
  
  // 현재 스킵
  int skip = 0;
  
  // 전체 갯수
  int totalCount = 0;
  
  /// 응답 아이템
  List<T> items = [];

  /// 생성자 
  ResponseList(this.code,this.message);

  /// 생성자
  ResponseList.withItem(this.result,this.code,this.message,this.items);
  
  /// 생성자
  ResponseList.name(this.result);
}