import 'package:my_app/models/responses/response-core.dart';

/// 응답 데이터 T 를 포함 하는 응답 결과 모델
class ResponseData<T> extends ResponseCore{
  /// 부모 생성자
  ResponseData({required super.result, required super.code, required super.message});

  /// 생성자
  /// [data] T 의 응답에 포함될 T 형의 데이터 
  ResponseData.withData({required super.result, required super.code, required super.message, required this.data});

  // T 로 지정된 응답 데이터
  T data = T as T;
}