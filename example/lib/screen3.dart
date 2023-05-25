import 'package:dot_flutter/dot_flutter.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //페이지 관련 정보 세팅
    var screen = {};
    screen["page_id"] = "SCREEN3";
    DOT.logScreen(screen);

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
      ),
      body: Center(
        child: Text(
          'Screen 3',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
