import "../enums/enum-response-result.dart";

/// 응답 기본 클래스
class Response {
  // 응답 결과
  EnumResponseResult result;
  
  // 응답 메세지
  String message;
  
  // 응답코드
  String code;

  /// 생성자
  Response.name(this.result, this.message, this.code);
}
