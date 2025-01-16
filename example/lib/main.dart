import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dot_flutter/dot_flutter.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'router_service.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized(); // binding initialized check

//   print("WiseLog SDK 예시 - Firebase를 사용한 PUSH NOTIFICATION 처리");
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// 
//   if (Platform.isIOS) {
//     FirebaseMessaging.instance.requestPermission();
//   }
//   final fcmToken = await FirebaseMessaging.instance.getToken();
//   print("WiseLog DOT FCM Token: $fcmToken");
//   final fcmTokenString = fcmToken.toString() ?? '';
//   print("WiseLog DOT FCM TokenString: $fcmTokenString");
//   DOT.setPushToken(fcmToken.toString());

// Foreground 상태에서 FCM 메시지 수신 핸들러 설정
//  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//    // 메시지가 수신된 경우, setPushClick 메소드가 해당 메시지가 와이즈트래커 대시보드를 통해서 보낸 메시지가 맞는지 확인함
//    // 와이즈트래커에서 보낸 메시지가 맞을 경우, Direct 오픈 수를 1 올려줌
//    print("WiseLog DOT FCM 메시지를 foreground 상태에서 수신하였습니다.");
//    print("WiseLog DOT FCM ${remoteMessage.notification?.body}");
//    print("WiseLog DOT FCM remotemessage.noti ${remoteMessage.notification}");
//    print("WiseLog DOT FCM remotemessage.data ${remoteMessage.data}");
//    final pushPayload = remoteMessage.data?['RW_push_payload_WP'];
//
//    if (pushPayload != null) {
//      DOT.setPushClick(pushPayload);
//    } else {
//      print("WiseLog DOT FCM remotemessage");
//    }
//  });
//
//  // Background 상태에서 FCM 메시지 수신하여 앱이 다시 열리는 경우에 대한 핸들러 설정
//  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
//    print("WiseLog DOT FCM 메시지를 수신하였습니다. (1)");
//    print("WiseLog DOT FCM ${remoteMessage.notification?.body}");
//
//    final pushPayload = remoteMessage.data?['RW_push_payload_WP'];
//    if (pushPayload != null) {
//      DOT.setPushClick(pushPayload);
//    }
//  });

//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//  RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();
//  if (initialMessage != null) {
//    final pushPayload = initialMessage.data['RW_push_payload_WP'];
//    if (pushPayload != null) {
//      // Handle the push payload
//      print("WiseLog DOT FCM 메시지를 terminated 상태에서 수신하였습니다.");
//      print("WiseLog DOT FCM ${initialMessage.notification?.body}");
//      DOT.setPushClick(pushPayload);
//    } else {
//      print("WiseLog DOT FCM 메시지를 terminated 상태에서 수신하였습니다.");
//      print("WiseLog DOT FCM ${initialMessage.notification?.body}");
//    }
//  }

  final RouterService routerService = RouterService();
  runApp(MyApp(routerService: routerService));
}

class MyApp extends StatelessWidget {

  // deferred link 수신 채널 생성 
  static const __deferredLinkOfWisetracker = MethodChannel('dot');

  final RouterService routerService;

  MyApp({required this.routerService});

  @override
  Widget build(BuildContext context) {


    __deferredLinkOfWisetracker.setMethodCallHandler((call) async {
        if (call.method == 'deferredLink') { 
           // 전달 받은 call.arguments 에 따라서 화면 이동 처리. 
           print("call.arguments " + call.arguments); 
        }
      });
      

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
