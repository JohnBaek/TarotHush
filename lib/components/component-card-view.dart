import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComponentCardView extends StatelessWidget {
  final Widget child;
  const ComponentCardView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return 
      Container(
      margin: const EdgeInsets.fromLTRB(20,10,20,10) ,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: child,
    );
  }
}
