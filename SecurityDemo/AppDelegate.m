//
//  AppDelegate.m
//  SecurityDemo
//
//  Created by TaiHuiTao on 16/8/29.
//  Copyright © 2016年 Lee2Go. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
-(void)loadOtherLoginView
{
    NSLog(@"viewcontrol 调用APPdelegate里的方法");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

   //调用viewcontrol里的方法。
   NSString * launchImageName = [self.myViewController getIphoneLaunchImageName];
   //设备启动图片为控制器的背景图片
   UIImage *img = [UIImage imageNamed:launchImageName];
   self.myViewController.view.layer.contents = (id) img.CGImage;
   NSString *myStr = self.myViewController.myStr;
   NSLog(@"myStr= %@",myStr);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
