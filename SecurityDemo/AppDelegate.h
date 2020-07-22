//
//  AppDelegate.h
//  SecurityDemo
//
//  Created by TaiHuiTao on 16/8/29.
//  Copyright © 2016年 Lee2Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak,nonatomic) ViewController *myViewController;

-(void)loadOtherLoginView;

@end

