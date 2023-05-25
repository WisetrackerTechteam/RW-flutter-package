import 'package:dot_flutter/dot_flutter.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //페이지 관련 정보 세팅
    var screen = {};
    screen["page_id"] = "SCREEN1";
    DOT.logScreen(screen);

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 1'),
      ),
      body: Center(
        child: Text(
          'Screen 1',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
