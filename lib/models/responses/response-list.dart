import 'package:my_app/models/responses/response-core.dart';

/// List<T> 의 응답 데이터 리스트를 포함하는 응답 결과 모델
class ResponseList<T> extends ResponseCore {
  /// 부모 생성자
  ResponseList({required super.result, required super.code, required super.message});

  /// 생성자
  /// [items] List<T> 의 응답에 포함될 List<T> 형의 데이터 
  ResponseList.withData({
      required super.result
    , required super.code
    , required super.message
    , required this.items
  });

  /// 생성자
  /// [items] List<T> 의 응답에 포함될 List<T> 형의 데이터 
  /// [pageCount] 페이징 될 숫자 
  /// [skip] 현재 스킵 
  /// [totalCount] 전체 갯수 
  ResponseList.withDataQuery({
    required super.result
  , required super.code
  , required super.message
  , required this.items
  , required this.pageCount 
  , required this.skip
  , required this.totalCount
  });
  
  // 페이징 될 숫자 
  int pageCount = 0;
  
  // 현재 스킵
  int skip = 0;
  
  // 전체 갯수
  int totalCount = 0;

  // List<T> 로 지정된 응답 데이터
  List<T> items = [];
}