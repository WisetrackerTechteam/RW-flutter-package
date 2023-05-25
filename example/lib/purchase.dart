import 'package:dot_flutter/dot_flutter.dart';
import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //페이지 관련 정보 세팅
    var screen = {};
    screen["page_id"] = "PURCHASE";
    DOT.logScreen(screen);

    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
      ),
      body: Center(
        child: Text(
          'Purchase',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
