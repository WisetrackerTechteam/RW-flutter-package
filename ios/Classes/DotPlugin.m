#import "DotPlugin.h"
#import <DOT/DOT.h>

@implementation DotPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"dot"
            binaryMessenger:[registrar messenger]];
  DotPlugin* instance = [[DotPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (NSString*)getString:(FlutterMethodCall*)call param1:(NSString*)param1 {
    NSString *returnStr = call.arguments[param1];
    return returnStr;
}

- (NSNumber*)getNumber:(FlutterMethodCall*)call param1:(NSString*)param1 {
    NSNumber *returnNum = call.arguments[param1];
    return returnNum;
}

- (NSArray*)getList:(FlutterMethodCall*)call param1:(NSString*)param1 {
    NSArray *returnArray = [[NSArray alloc] init];
    returnArray = call.arguments[param1];
    return returnArray;
}

- (NSInteger)getInteger:(FlutterMethodCall*)call param1:(NSString*)param1 {
    NSInteger returnInt = (NSInteger) call.arguments[param1];
    return returnInt;
}

- (NSMutableDictionary*)getDictionary:(FlutterMethodCall*)call param1:(NSString*)param1 {
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
    returnDict = call.arguments[param1];
    return returnDict;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    bool doExecute = false;
    @try {
        if ([@"getPlatformVersion" isEqualToString:call.method]) {
            result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
        } else if ([@"initialization" isEqualToString:call.method]){
            [DOT initialization:nil application:UIApplication.sharedApplication];
            doExecute = true;
        } else if ([@"logEvent" isEqualToString:call.method]){
            [DOT logEvent:[self getDictionary:call param1:@"conversionJson"]];
            doExecute = true;
        } else if ([@"logPurchase" isEqualToString:call.method]){
            [DOT logPurchase:[self getDictionary:call param1:@"purchaseJson"]];
            doExecute = true;
        } else if ([@"logScreen" isEqualToString:call.method]){
            [DOT logScreen:[self getDictionary:call param1:@"pageJson"]];
            doExecute = true;
        } else if ([@"logClick" isEqualToString:call.method]){
            [DOT logClick:[self getDictionary:call param1:@"clickJson"]];
            doExecute = true;
        } else if ([@"onStartPage" isEqualToString:call.method]){
            [DOT onStartPage];
            doExecute = true;
        } else if ([@"onStopPage" isEqualToString:call.method]){
           
        } else if ([@"setUser" isEqualToString:call.method]){
            
            doExecute = true;
        } 
        else if ([@"setUser" isEqualToString:call.method]){
            [DOT setUserLogout];
            doExecute = true;
        }else {
            result(FlutterMethodNotImplemented);
        }
    }
    @catch (NSException * e) {
        NSLog(@"Error: %@%@", [e name], [e reason]);
    }
    @finally {
        if( doExecute ){
            result(call.method);
        }else{
          result(FlutterMethodNotImplemented);
        }
    }
    
}




@end
