import 'package:flutter/material.dart';
import 'package:dot_flutter/dot_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //페이지 관련 정보 세팅
    var screen = {};
    screen["page_id"] = "HOME";
    print("DOT HomeScreen logScreen started");
    DOT.logScreen(screen);
    print("DOT HomeScreen logScreen completed");

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home Screen',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // margin을 10px로 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen1');
                },
                child: Text('Go to Screen 1'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // margin을 10px로 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen2');
                },
                child: Text('Go to Screen 2'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // margin을 10px로 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/screen3');
                },
                child: Text('Go to Screen 3'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // margin을 10px로 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/purchase');
                },
                child: Text('Go to Purchase'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10), // margin을 10px로 설정
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/loginSuccess');

                  Map loginTp = {};
                  loginTp["event"] = "w_login_complete";
                  loginTp["loginTp"] = "email";
                  DOT.logEvent(loginTp);

                },
                child: Text('Go to LoginSuccess'),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Map signUp = {};
                    signUp["event"] = "w_signup_complete";
                    signUp["signupTp"] = "email";
                    DOT.logEvent(signUp);
                  },
                  child: Text('Sign Up'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
