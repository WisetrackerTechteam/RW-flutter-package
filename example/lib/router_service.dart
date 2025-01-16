import 'package:dot_flutter/dot_flutter.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'purchase.dart';
import 'login_success.dart';

class RouterService extends RouteObserver<PageRoute<dynamic>>{
 
  // PAGES 유형의 이벤트 수집 확인을 위한 코드 추가
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;

    DOT.onStartPage();
    print('DOT.onStartPage() called $screenName');
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/screen1':
        return MaterialPageRoute(builder: (_) => Screen1());
      case '/screen2':
        return MaterialPageRoute(builder: (_) => Screen2());
      case '/screen3':
        return MaterialPageRoute(builder: (_) => Screen3());
      case '/purchase':
        return MaterialPageRoute(builder: (_) => Purchase());
      case '/loginSuccess':
        return MaterialPageRoute(builder: (_) => LoginSuccess());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Wise didPush called');
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Wise didPop called');
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
