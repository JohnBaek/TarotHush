import 'package:flutter/cupertino.dart';

/// H1 텍스트 컴포넌트
class ComponentSubjectTextH1 extends StatelessWidget {
  final String title;

  /// 생성자
  const ComponentSubjectTextH1({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
        title, style: const TextStyle(fontSize: 35));
  }
}
