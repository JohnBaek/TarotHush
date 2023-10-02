import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// None 뷰 페이지 
class ViewNone extends StatelessWidget {
  const ViewNone({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: 
        Row(
          children: [
            Text('Tarot Hush', textAlign: TextAlign.left,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.3)),
            ),
            Text(', Improve yourself everyday.', textAlign: TextAlign.left,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.3)),
            )
          ],
        )
    );
  }
}
