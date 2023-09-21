import 'package:flutter/cupertino.dart';

/// H1 텍스트 컴포넌트
class SubjectTextH1 extends StatelessWidget {
  final String title;

  /// 생성자
  const SubjectTextH1({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
        title, style: const TextStyle(fontSize: 35));
  }
}
