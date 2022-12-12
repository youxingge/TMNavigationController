//
//  ViewController.m
//  TMNavigationController
//
//  Created by TianMing on 16/3/18.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "ViewController.h"
#import "TMNavigationController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (strong , nonatomic) UITabBarController * tabbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
    [self performSelector:@selector(gotoWindow) withObject:self afterDelay:0];
}
-(void)initTabbar{
    
    //    [TMNavigationConfig shareInstance].forceSideslipGesture = YES;
    [TMNavigationConfig shareInstance].backButtonImage = [UIImage imageNamed:@"left"];
    
    _tabbar = [[UITabBarController alloc]init];
    TMNavigationController * nav1 = [[TMNavigationController alloc]initWithRootViewController:[FirstViewController new]];
    TMNavigationController * nav2 = [[TMNavigationController alloc]initWithRootViewController:[FirstViewController new]];
    TMNavigationController * nav3 = [[TMNavigationController alloc]initWithRootViewController:[FirstViewController new]];
    _tabbar.viewControllers = @[nav1,nav2,nav3];
    
}
-(void)gotoWindow{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = _tabbar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
