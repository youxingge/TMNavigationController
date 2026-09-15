//
//  TMNavigationController.m
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "TMNavigationController.h"
#import "TMNavigationConfig.h"

@interface TMNavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>
// 忽略
@property (nonatomic, assign) BOOL shouldIgnorePushingViewControllers;

@end

@implementation TMNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
//        NSLog(@"%@",rootViewController.childViewControllers);
    }
    return self;
}
- (void)loadView{
    [super loadView];
    [self createBarView];
    self.navigationCanDragBack = YES;
    self.delegate = self;
    [self addPopGesture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([TMNavigationConfig shareInstance].forceSideslipGesture) {
        self.navigationCanSideslipBack = YES;
    }
}

- (void)createBarView {
    self.navigationBarHidden = YES;
    TMNavigationBarView * barView  = [[TMNavigationBarView alloc]init];
    __weak typeof(self) weakSelf = self;
    [barView clickBackButton:^(UIButton *button) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    [self.topViewController.view addSubview:barView];
    barView.title = self.topViewController.title;
    if (self.viewControllers.count==0) {
        barView.backButton.hidden = YES;
    }
}
- (void)addPopGesture {
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
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (kIsRTL) { // 适配阿拉伯
        if (translation.x >= 0  || self.childViewControllers.count==1 || [[self valueForKey:@"_isTransitioning"] boolValue]) {
            return NO;
        }
    }else {
        if (translation.x <= 0  || self.childViewControllers.count==1 || [[self valueForKey:@"_isTransitioning"] boolValue]) {
            return NO;
        }
    }
    // 如果开启了侧滑 50 以内
    CGPoint touchPoint = [gestureRecognizer locationInView:self.view];
    if (self.navigationCanSideslipBack) {
        CGFloat locationX = kIsRTL ? SCREEN_WIDTH - touchPoint.x : touchPoint.x;
        if (locationX > 50) {
            return NO;
        }
    }
    return YES;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 栈内已有控制器才需要隐藏 TabBar，推根控制器时保持显示
    BOOL shouldHideTabBar = self.viewControllers.count > 0;
    viewController.hidesBottomBarWhenPushed = shouldHideTabBar;

    // 无动画 push 不走转场，willShowViewController 里的隐藏会晚于首帧布局而闪现 TabBar，故提前同步一次
    if (!animated) {
        if (@available(iOS 26.0, *)) {
            [self.tabBarController setTabBarHidden:shouldHideTabBar animated:animated];
        }
    }

    // iOS 26 起 didShowViewController 回调时机变化，上面的锁可能永不解除导致后续无法跳转，故不加锁直接 push
    if (@available(iOS 26.0, *)) {
        [super pushViewController:viewController animated:animated];
    } else {
        // iOS 26 以下靠锁避免转场动画期间重复 push 同一个控制器
        if (!self.shouldIgnorePushingViewControllers) {
            [super pushViewController:viewController animated:animated];
            self.shouldIgnorePushingViewControllers = YES;
        }
    }

    TMNavigationBarView * barView = [[TMNavigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TM_TopBarHeight)];
    viewController.navigationBar =  barView;
    [viewController.view addSubview: barView];
   
    if (self.viewControllers.count==1) {
        barView.backButton.hidden = YES;
    }
    
    [self setPropertyWithViewController:viewController barView:barView];
   
    // 设置渐变色后，设置背景颜色不起作用
// [viewController setGradientBackgroundFromColor:UIColorFromRGB(0x12ace5) toColor:UIColorFromRGB(0x1e82d2)];
    
}
// iOS 26 起 hidesBottomBarWhenPushed 不再作用于悬浮 TabBar，需在转场开始时显式同步显隐；pop 回根控制器同样由此恢复
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (@available(iOS 26.0, *)) {
        BOOL shouldHideTabBar = viewController != navigationController.viewControllers.firstObject;
        [navigationController.tabBarController setTabBarHidden:shouldHideTabBar animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.shouldIgnorePushingViewControllers = NO;
}
- (void)setPropertyWithViewController:(UIViewController*)viewController barView:(TMNavigationBarView *)barView {
    barView.title = viewController.title;
    barView.hidden = viewController.navigationBarHidden;
    barView.myBackgroundImage = viewController.navigationBarBackgroundImage;
    barView.myBackgroundColor = viewController.navigationBarBackgroundColor;
    barView.myTitleColor = viewController.navigationBarTitleColor;
    barView.myBottomLineColor = viewController.navigationBarBottomLineBackgroundColor;
    // 默认点击返回方法
    __weak typeof(self) weakSelf = self;
    [barView clickBackButton:^(UIButton *button) {
        [weakSelf popViewControllerAnimated:YES];
    }];
    // 默认 左边第二个按钮隐藏、右边按钮隐藏
    viewController.navigationLeftBarHidden = YES;
    viewController.navigationRightBarHidden = YES;
    viewController.navigationRightFirstBarHidden = YES;
    
}
- (UIViewController*)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}
// 支持子控制器旋转方向
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





