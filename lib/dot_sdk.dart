import 'dart:async';

import 'package:flutter/services.dart';

class DOT {
  static const MethodChannel _channel = const MethodChannel('dot');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    print("version :" + version);
    return version;
  }

  static void initialization() {
    print("before initialization");
    _channel.invokeMethod("initialization");
    print("after initialization");
  }

  static void setUser(String userJson) {
    _channel.invokeMethod("setUser", <String, dynamic>{'userJson': userJson});
  }

  static void setUserLogout() {
    _channel.invokeMethod("setUserLogout");
  }

  static void onPlayStart() {
    _channel.invokeMethod("onPlayStart");
  }

  static void onPlayStartWithPeriod(int period) {
    _channel.invokeMethod("onPlayStart", <String, dynamic>{'period': period});
  }

  static void onPlayStop() {
    _channel.invokeMethod("onPlayStop");
  }

  static void onStartPage() {
    _channel.invokeMethod("onStartPage");
  }

  static void onStopPage() {
    _channel.invokeMethod("onStopPage");
  }

  static void logScreen(Map pageMap) {
    _channel.invokeMethod("logScreen", <String, dynamic>{'pageJson': pageMap});
  }

  static void logPurchase(Map purchaseMap) {
    _channel.invokeMethod(
        "logPurchase", <String, dynamic>{'purchaseJson': purchaseMap});
  }

  static void logEvent(Map eventMap) {
    _channel.invokeMethod(
        "logEvent", <String, dynamic>{'conversionJson': eventMap});
  }

  static void logClick(Map clickMap) {
    _channel.invokeMethod("logClick", <String, dynamic>{'clickJson': clickMap});
  }
}
