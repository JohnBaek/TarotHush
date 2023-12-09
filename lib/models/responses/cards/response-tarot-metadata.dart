import 'package:my_app/models/hive/hive-tarot-card-metadata.dart';

import '../../enums/enum-tarot-product.dart';

/// 타로카드 정보에 대한 모델
class ResponseTarotCardMetadata {
  // 타이틀
  late String title;

  // 설명
  late String description;

  // 이미지명
  late String imagePath;
  
  // 타로종류
  late EnumTarotProduct enumTarotProduct;
  
  /// 생성자
  /// [title] 타이틀
  /// [description] 설명
  /// [imagePath] 이미지명
  /// [enumTarotProduct] 타로종류
  ResponseTarotCardMetadata({required this.title,required this.description,required this.imagePath,required this.enumTarotProduct});

  /// 생성자
  /// [from] ResponseTarotCardMetadata 형의 객체를 TarotCardMetadata 로 변환 한다.
  ResponseTarotCardMetadata.fromHive(HiveTarotCardMetadata from) {
    title = from.title;
    description = from.description;
    imagePath = from.imagePath;
    enumTarotProduct = from.enumTarotProduct;
  }
}