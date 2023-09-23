import '../enums/enum-tarot-product.dart';

class ResponseTarotCore {
  /// 타이틀
  String title = '';

  /// 설명
  String description = '';

  /// 이미지명
  String imageName = '';
  
  /// 타로종류
  EnumTarotProduct enumTarotProduct = EnumTarotProduct.riderWaited;
  
  /// 생성자
  ResponseTarotCore({required this.title,required this.description,required this.imageName,required this.enumTarotProduct});
}