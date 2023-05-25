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


  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
