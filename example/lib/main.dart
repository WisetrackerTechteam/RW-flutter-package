import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_screen.dart';
import 'router_service.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

void main() {
  final RouterService routerService = RouterService();

  runApp(MyApp(routerService: routerService));
}

class MyApp extends StatelessWidget {
  final RouterService routerService;

  MyApp({required this.routerService});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouterService.generateRoute,
      initialRoute: '/',
      home: HomeScreen(),
      navigatorObservers: [
        routerService,
        _DeepLinkNavigatorObserver(),
      ],
    );
  }
}

class _DeepLinkNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _handleDeepLink(route.settings.name);
  }

  void _handleDeepLink(String? routeName) {
    if (routeName == '/deeplink') {
      // Handle the deep link here
      print('Received deep link!');
    }
  }
}
