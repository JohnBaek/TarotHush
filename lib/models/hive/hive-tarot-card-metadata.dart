import 'package:hive/hive.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';

import '../enums/enum-tarot-product.dart';

part "hive-tarot-card-metadata.g.dart";

/// 타롯 카드 메타 데이터에 대한 Hive 모델
@HiveType(typeId: 99)
class HiveTarotCardMetadata {
  // 타이틀
  @HiveField(0)
  late String title;

  // 설명
  @HiveField(1)
  late String description;

  // 이미지 명
  @HiveField(2)
  late String imagePath;

  // 타로 종류
  @HiveField(3)
  late EnumTarotProduct enumTarotProduct;

  /// 생성자
  /// [title] 타이틀 
  /// [description] 설명 
  /// [imagePath] 이미지 명 
  /// [enumTarotProduct] 타로 종류 
  HiveTarotCardMetadata({
      required this.title
    , required this.description
    , required this.imagePath
    , required this.enumTarotProduct
  });

  /// 생성자
  /// [from] ResponseTarotCardMetadata 형의 객체를 TarotCardMetadata 로 변환 한다.
  HiveTarotCardMetadata.fromResponse(ResponseTarotCardMetadata from) {
    title = from.title;
    description = from.description;
    imagePath = from.imagePath;
    enumTarotProduct = from.enumTarotProduct;
  }

  /// HiveTarotCardMetadata 를 ResponseTarotCardMetadata 으로 변환한다.
  ResponseTarotCardMetadata toResponse() {
    return ResponseTarotCardMetadata(title: title, description: description , enumTarotProduct: enumTarotProduct , imagePath: imagePath);
  }
}