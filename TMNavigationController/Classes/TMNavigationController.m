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
@property (nonatomic, strong) NSLayoutConstraint *heigthConstranint;
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
    if (self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 避免重复push同一个viewcontroller
    if (!self.shouldIgnorePushingViewControllers) {
        [super pushViewController:viewController animated:animated];
    }
    self.shouldIgnorePushingViewControllers = YES;

    CGFloat navHeight = [TMNavigationBarView getNavigationBarHeight];
    TMNavigationBarView *barView = [[TMNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
    viewController.navigationBar = barView;
    [viewController.view addSubview:barView];
    // 添加约束
    barView.translatesAutoresizingMaskIntoConstraints = NO;
    [barView.leadingAnchor constraintEqualToAnchor:barView.superview.leadingAnchor].active = YES;
    [barView.trailingAnchor constraintEqualToAnchor:barView.superview.trailingAnchor].active = YES;
    [barView.topAnchor constraintEqualToAnchor:barView.superview.topAnchor].active = YES; //让背景色延伸到状态栏
    // 更新barView高度约束
    [self updateBarViewConstanion:barView navHeight:navHeight];
    
    if (self.viewControllers.count==1) {
        barView.backButton.hidden = YES;
    }

    [self setPropertyWithViewController:viewController barView:barView];
   
    // 设置渐变色后，设置背景颜色不起作用
// [viewController setGradientBackgroundFromColor:UIColorFromRGB(0x12ace5) toColor:UIColorFromRGB(0x1e82d2)];
    
}

// 更新barView高度约束
- (void)updateBarViewConstanion:(TMNavigationBarView *)barView navHeight:(CGFloat)navHeight {
    [barView removeConstraint:self.heigthConstranint];
    self.heigthConstranint = [barView.heightAnchor constraintEqualToConstant:navHeight];
    self.heigthConstranint.active = YES;
    [barView addConstraint:self.heigthConstranint];
    [barView.superview layoutIfNeeded];
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
// 屏幕旋转 nav高度变化
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UIViewController *topController = self.topViewController;
    CGFloat navHeight = [TMNavigationBarView getNavigationBarHeight];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // --- 旋转动画块 ---
        [self updateBarViewConstanion:topController.navigationBar navHeight:navHeight];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // 旋转结束后的回调
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end





