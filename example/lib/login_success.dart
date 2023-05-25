import 'package:dot_flutter/dot_flutter.dart';
import 'package:flutter/material.dart';

class LoginSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // user 관련 정보 셋팅
    Map user = {};
    user["sx"] = "male";
    user["ag"] = "30-39";
    user["ut1"] = "vvvip";
    DOT.setUser(user);

    //페이지 관련 정보 세팅
    var screen = {};
    screen["page_id"] = "LOGIN_SUCCESS";
    DOT.logScreen(screen);

    return Scaffold(
      appBar: AppBar(
        title: Text('LoginSuccess'),
      ),
      body: Center(
        child: Text(
          'LoginSuccess',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
