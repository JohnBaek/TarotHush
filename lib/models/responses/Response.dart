import "../enums/enum-response-result.dart";

/// 응답 기본 클래스
class ResponseResult {
  // 응답 결과
  EnumResponseResult result = EnumResponseResult.Error;
  
  // 응답 메세지
  String message = "";
  
  // 응답코드
  String code = "";

  /// 생성자 
  ResponseResult(this.code,this.message);

  /// 생성자
  ResponseResult.name(this.result);
}
