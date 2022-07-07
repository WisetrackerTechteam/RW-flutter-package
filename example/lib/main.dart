import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dot_flutter/dot_flutter.dart'; //  고객사 적용 방법 ( peubspec.yarl

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DOT.initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      navigatorObservers: [MyRouteObserver()],
      home: Screen1(),
      routes: {
        'screen2': (context) => Screen2(),
        'screen3': (context) => Screen3(),
      },
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wisetracker.startPage("screen1");
    print("screen1");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Screen 1'),
            SizedBox(height: 30.0),
            RaisedButton(
              child: Text('Screen 2'),
              onPressed: () => Navigator.of(context).pushNamed('screen2'),
            ),
            RaisedButton(
              child: Text('Screen 3'),
              onPressed: () => Navigator.of(context).pushNamed('screen3'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _eventOccured2,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _eventOccured2() {
    // Wisetracker.setGoalProductArray(["aaa", "bbb", "ccc"]);
    // Wisetracker.sendTransaction;

    // Wisetracker.setOrderProductArray(["aaa", "bbb", "ccc"]);
    // Wisetracker.sendTransaction;
    // Wisetracker.setOrderQuantityArray([1]);
    // Wisetracker.setOrderAmountArray([550000]);
    // Wisetracker.setOrderNo("tr012345");
    // Wisetracker.setPageIdentity("ODR");

    // Wisetracker.setOrderNo("orderno20200910");
    // Wisetracker.setProduct("nike123", "nikeshoes12345");
    // Wisetracker.setPageIdentity("ODR");
    // Wisetracker.setOrderAmountArray([10000.0, 20000.0, 30000.0]);
    // Wisetracker.setOrderQuantityArray([1, 3, 8]);
    // Wisetracker.putRevenueData("pnc", "pnc11111111");
    // Wisetracker.setOrderProductArray(['상품코드1', '상품코드2']);

    var purchase = {};
    purchase["ordNo"] = "주문번호";
    purchase["curcy"] = "화폐단위";

    var product1 = {};
    product1["pg1"] = "상품카테고리(대)";
    product1["pnc"] = "상품코드1";
    product1["pnAtr1"] = "상품속성#1";

    List productArray = [];
    productArray.add(product1);
    purchase["product"] = productArray;

    DOT.logPurchase(purchase);
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    var screen = {};
    screen["pi"] = "MAIN";
    screen["curcy"] = "화폐단위";

    DOT.logScreen(screen);
    return Scaffold(appBar: AppBar(), body: Center(child: Text('Screen 2')));
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Wisetracker.startPage("screen2");

    var screen = {};
    screen["pi"] = "DTL";
    screen["event"] = "view_product";

    DOT.logScreen(screen);

    return Scaffold(appBar: AppBar(), body: Center(child: Text('Screen 3')));
  }
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  // -------------------
  // ÷추가
  var screenName = '';
  void _sendScreenView(PageRoute<dynamic> route) {
    var currentScreenName = route.settings.name;
    if (screenName != currentScreenName) {
      print('screenName  $screenName --> $currentScreenName ');
      DOT.onStartPage();
      this.screenName = currentScreenName;
    }
  }
  // ---------

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    // -------------------
    // ÷추가
    if (route is PageRoute) {
      _sendScreenView(route); // ÷추가
    }
    // ------
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // -------------------
    // ÷추가
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute); // ÷추가
    }
    // ------
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    // -------------------
    // ÷추가
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
    // -------------------
  }
}
