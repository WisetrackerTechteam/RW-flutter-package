
import 'dart:async';

import 'package:flutter/services.dart';

class Dot {
  static const MethodChannel _channel = const MethodChannel('dot');

  static initialization() {
    _channel.invokeMethod("initialization");
  }
  static setUser(String userJson) {
    _channel.invokeMethod("setUser",<String, dynamic>{'userJson': userJson});
  }
  static setUserLogout(){
    _channel.invokeMethod("setUserLogout");
  }
  static onPlayStart(){
    _channel.invokeMethod("onPlayStart");
  }
  static onPlayStartWithPeriod(int period){
    _channel.invokeMethod("onPlayStart", <String, dynamic>{'period': period} );
  }
  static onPlayStop(){
    _channel.invokeMethod("onPlayStop");
  }
  static onStartPage(){
    _channel.invokeMethod("onStartPage");
  }
  static onStopPage(){
    _channel.invokeMethod("onStopPage");
  }
  static logScreen(String pageJson){
    _channel.invokeMethod("logScreen", <String, dynamic>{'pageJson': pageJson});
  }
  static logPurchase(String purchaseJson){
    _channel.invokeMethod("logPurchase", <String, dynamic>{'purchaseJson': purchaseJson});
  }
  static logEvent(String conversionJson){
    _channel.invokeMethod("logEvent", <String, dynamic>{'conversionJson': conversionJson});
  }
  static logClick(String clickJson){
    _channel.invokeMethod("logClick", <String, dynamic>{'clickJson': clickJson});
  }
}
