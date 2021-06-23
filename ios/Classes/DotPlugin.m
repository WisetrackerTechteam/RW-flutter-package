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
           
        } else if ([@"setDeepLink" isEqualToString:call.method]){
            [DOT setDeepLink:[self getString:call param1:@"uni_deepLink"]];
            doExecute = true;
        } else if ([@"setUser" isEqualToString:call.method]){
            NSString *userStr = [self getString:call param1:@"userJson"];
            NSData *data = [userStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"userDict in handleMethodCall : %@", userDict);
            
            User *user = [[User alloc] init];
            if( [userDict objectForKey:@"mbr"] != nil) {
                [user setMember:[userDict objectForKey:@"mbr"]];
            }
            if( [userDict objectForKey:@"sx"] != nil) {
                [user setGender:[userDict objectForKey:@"sx"]];
            }
            if( [userDict objectForKey:@"ag"] != nil) {
                [user setAge:[userDict objectForKey:@"ag"]];
            }
            if( [userDict objectForKey:@"ut1"] != nil) {
                [user setAttribute1:[userDict objectForKey:@"ut1"]];
            }
            if( [userDict objectForKey:@"ut2"] != nil) {
                [user setAttribute2:[userDict objectForKey:@"ut2"]];
            }
            if( [userDict objectForKey:@"ut3"] != nil) {
                [user setAttribute3:[userDict objectForKey:@"ut3"]];
            }
            if( [userDict objectForKey:@"ut4"] != nil) {
                [user setAttribute4:[userDict objectForKey:@"ut4"]];
            }
            if( [userDict objectForKey:@"ut5"] != nil) {
                [user setAttribute5:[userDict objectForKey:@"ut5"]];
            }
            if( [userDict objectForKey:@"mbl"] != nil) {
                [user setMemberGrade:[userDict objectForKey:@"mbl"]];
            }
            if( [userDict objectForKey:@"mbid"] != nil) {
                [user setMemberId:[userDict objectForKey:@"mbid"]];
            }
            if( [userDict objectForKey:@"isLogin"] != nil) {
                [user setIsLogin:[userDict objectForKey:@"isLogin"]];
            }
            if( [userDict objectForKey:@"loginTp"] != nil) {
                [user setLoginTp:[userDict objectForKey:@"loginTp"]];
            }
            if( [userDict objectForKey:@"signupTp"] != nil) {
                [user setSignupTp:[userDict objectForKey:@"signupTp"]];
            }
            
            [DOT setUser:user];
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
