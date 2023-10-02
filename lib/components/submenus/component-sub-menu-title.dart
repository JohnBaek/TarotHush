import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 사이드 서브 메뉴 타이틀 
class ComponentSubMenuTitle extends StatelessWidget {
  /// 타이틀 명
  final String name;
  
  /// 생성자
  const ComponentSubMenuTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
      padding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(name, textAlign: TextAlign.left,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.black.withOpacity(0.3)),
        ),
      ),
    );
  }
}
