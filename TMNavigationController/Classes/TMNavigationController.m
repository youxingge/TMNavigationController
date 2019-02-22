//
//  TMNavigationController.m
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "TMNavigationController.h"


@interface TMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TMNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
    }
    return self;
}
- (void)loadView{
    [super loadView];
    [self createBarView];
    self.navigationCanDragBack = YES;
    [self addPopGesture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createBarView{
    self.navigationBarHidden = YES;
    TMNavigationBarView * barView  = [[TMNavigationBarView alloc]init];
    kWEAK_SELF
    [barView clickBackButton:^(UIButton *button) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    [self.topViewController.view addSubview:barView];
    barView.title = self.topViewController.title;
    if (self.viewControllers.count==0) {
        barView.backButton.hidden = YES;
    }
}
- (void)addPopGesture{
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:pan];
    NSMutableArray * _targets = [self.interactivePopGestureRecognizer valueForKey:@"_targets"];
    id _UINavigationInteractiveTransition = [[_targets firstObject] valueForKey:@"_target"];
    NSString * pop = @"handleNavigationTransition:";
    SEL popAction = NSSelectorFromString(pop);
    [pan addTarget:_UINavigationInteractiveTransition action:popAction];
    self.panGesture = pan;
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0  || self.childViewControllers.count==1 || [[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    TMNavigationBarView * barView = [[TMNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TM_TopBarHeight)];
    viewController.navigationBar =  barView;
    [viewController.view addSubview: barView];
    kWEAK_SELF
    [barView clickBackButton:^(UIButton *button) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    if (self.viewControllers.count==0) {
        barView.backButton.hidden = YES;
    }
    if (self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self setPropertyWithViewController:viewController barView:barView];
   
    // 设置渐变色后，设置背景颜色不起作用
// [viewController setGradientBackgroundFromColor:UIColorFromRGB(0x12ace5) toColor:UIColorFromRGB(0x1e82d2)];
    
    [super pushViewController:viewController animated:animated];
    
    CGRect frame = self.tabBarController.tabBar.frame;
    // 设置frame的y值, y = 屏幕高度 - tabBar高度
    frame.origin.y = SCREEN_HEIGHT - frame.size.height;
    // 修改tabBar的frame
    self.tabBarController.tabBar.frame = frame;
    
}
- (void)setPropertyWithViewController:(UIViewController*)viewController barView:(TMNavigationBarView *)barView{
    barView.title = viewController.title;
    barView.hidden = viewController.navigationBarHidden;
    barView.myBackgroundImage = viewController.navigationBarBackgroundImage;
    barView.myBackgroundColor = viewController.navigationBarBackgroundColor;
    barView.myTitleColor = viewController.navigationBarTitleColor;
    barView.myBottomLineColor = viewController.navigationBarBottomLineBackgroundColor;
    
    
    // 默认 左边第二个按钮隐藏、右边按钮隐藏
    viewController.navigationLeftBarHidden = YES;
    viewController.navigationRightBarHidden = YES;
    viewController.navigationRightFirstBarHidden = YES;
    viewController.navigationRightBarRedButtonShow = NO;
    
}
- (UIViewController*)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end





