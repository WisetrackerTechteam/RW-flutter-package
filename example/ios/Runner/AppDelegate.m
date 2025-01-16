#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <DOT/DOT.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
 
  // S: Wisetracker SDK init
  [DOT initialization:launchOptions application:application];
  #ifdef DEBUG
    [DOT checkDebugMode:true];
  #else
    [DOT checkDebugMode:false];
  #endif
  // E: Wisetracker SDK init
    
    /** Deferred Url 사용 예시
    [DOT initializationForDeferredCallback:launchOptions application:application callback:^{
        // deferred deeplink  정보는 [DOT getDeferredUrl]로 사용이 가능하며,
        // 앱에서는 해당 변수를 다음과 같이 사용할  수 있음.
        // 1. callback 이 호출되는 시점에 즉시 __deferredUrl 화면으로 이동 처리. __deferredUrl 값이 nil 이면 메인 화면으로 이동 처리.
        // 2. __deferredUrl 변수값을 어딘가에 저장하고, 회원가입 이후, 로그인이 완료된 이후등과 같이 필요한 시점에 저장된 값을 꺼내서 이동 처리.
        // 3. 사용 가능한 Deferred deeplink 정보가 없는 경우에는, __deferredUrl 값이 널(NULL) 이 될 수 있음을 고려하여 사용.
        NSString* __deferredUrl = @"mrcm";
        // NSString* __deferredUrl = [DOT getDeferredUrl];
        NSLog(@"Deferred callback executed %@", __deferredUrl);
        if(__deferredUrl != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                // Flutter로 메시지 전송
                FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
                FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                    methodChannelWithName:@"dot"
                          binaryMessenger:controller.binaryMessenger];
                [methodChannel invokeMethod:@"deferredLink" arguments:__deferredUrl];
            });
        }
    }];
   */

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
