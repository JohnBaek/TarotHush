import "../enums/enum-response-result.dart";

/// 응답 기본 코어 클래스
class ResponseCore {
  // 응답 결과
  EnumResponseResult result = EnumResponseResult.error;

  // 응답 메세지
  String message = "";

  // 응답코드
  String code = "";
  
  /// 생성자
  /// [result] 응답 결과
  /// [code] 응답 코드
  /// [message] 응답 메세지
  ResponseCore({required this.result ,required this.code , required this.message});

  /// 생성자
  /// [result] 결과
  ResponseCore.result({required this.result});
}
