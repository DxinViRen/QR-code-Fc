//
//  AppDelegate.m
//  QRcodeMachine
//
//  Created by D.xin on 2019/10/27.
//  Copyright © 2019 koryv. All rights reserved.
//

#import "AppDelegate.h"
#import "Dx_qrNavigetionVC.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor  = [UIColor whiteColor];
    HomeViewController *home = [[HomeViewController alloc]init];
    Dx_qrNavigetionVC *dxnavi = [[Dx_qrNavigetionVC alloc]initWithRootViewController:home];
    self.window.rootViewController = dxnavi;
    

    return YES;
}




@end
