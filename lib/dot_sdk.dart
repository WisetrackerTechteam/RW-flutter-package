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

  static void setUser(Map userJson) {
    if( userJson != null ){
      _channel.invokeMethod("setUser", <String, dynamic>{'userJson': userJson});  
    } 
  }

  static void setUserLogout() {
    _channel.invokeMethod("setUserLogout");
  }

  static void onPlayStart() {
    _channel.invokeMethod("onPlayStart");
  }

  static void onPlayStartWithPeriod(int period) {
    if( period > 0 ){
      _channel.invokeMethod("onPlayStart", <String, dynamic>{'period': period});  
    } 
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
    if( pageMap != null ){
      _channel.invokeMethod("logScreen", <String, dynamic>{'pageJson': pageMap});  
    } 
  }

  static void logPurchase(Map purchaseMap) {
    if( purchaseMap != null ){
      _channel.invokeMethod("logPurchase", <String, dynamic>{'purchaseJson': purchaseMap});  
    } 
  }

  static void logEvent(Map eventMap) {
    if( eventMap != null ){
      _channel.invokeMethod("logEvent", <String, dynamic>{'conversionJson': eventMap});  
    } 
  }

  static void logClick(Map clickMap) {
    if( clickMap != null ){
      _channel.invokeMethod("logClick", <String, dynamic>{'clickJson': clickMap});  
    } 
  }

  static void setDeepLink(String uni_deepLink) {
    if( uni_deepLink != null ){
      _channel.invokeMethod("setDeepLink", <String, dynamic>{'uni_deepLink': uni_deepLink});
    } 
  }

}
