import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 사이드 서브 메뉴 타이틀 
class SubMenuTitle extends StatelessWidget {
  /// 타이틀 명
  final String name;
  
  /// 생성자
  const SubMenuTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(name, textAlign: TextAlign.left,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }
}
