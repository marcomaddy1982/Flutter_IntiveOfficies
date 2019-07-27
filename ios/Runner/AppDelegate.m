#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GMSServices provideAPIKey: @"AIzaSyBaH7uXz3aUdDb815xF0KcZIjZ6-LFTP48"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
