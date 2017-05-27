//
//  TMNavigationController.m
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "TMNavigationController.h"
#import "objc/runtime.h"

@interface navigationBarView ()
@end

@implementation navigationBarView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    if (self) {
        
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.frame = self.frame;
        [self.layer addSublayer:gradientLayer];
        self.gradientLayer = gradientLayer;
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-0.5,frame.size.width,0.5)];
        _lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self addSubview:_lineView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.adjustsImageWhenHighlighted = NO;
        [_backButton setImage:[UIImage imageNamed:@"arrow_white"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(0, 20, 52, 44);
        [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.adjustsImageWhenHighlighted = NO;
        [_leftButton setTitle:@"关闭" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftButton.frame = CGRectMake(50, 20, 52, 44);
        [_leftButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_leftButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 25, SCREEN_WIDTH-90*2, 35)];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17.5];
        [self addSubview:_titleLabel];
        
    }
    return self;
}
-(void)backLastView:(UIButton*)button{
    if (self.click) {
        self.click(button);
    }
}
- (void)closeAction:(UIButton*)button{
    if (self.leftClick) {
        self.leftClick(button);
    }
}
-(void)clickBackButton:(clickBackButton)block{
    self.click = block;
}
- (void)clickLeftButton:(clickBackButton)block{
    self.leftClick = block;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    if (!title) {
        _titleLabel.text = @"";
        return;
    }
    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _titleLabel.text = title;
    [self setNeedsDisplay];
}
@end

@implementation UIViewController (navigationBar)

static char  backButtonImageKey;

@dynamic navigationBar;
@dynamic navigationBarHidden;
@dynamic leftBarHidden;
@dynamic title;
@dynamic backButtonImage;
@dynamic navigationBarBackgroundColor;
@dynamic barBottomLineBackgroundColor;

-(navigationBarView *)navigationBar{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setNavigationBar:(navigationBarView *)navigationBar{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)isNavigationBar{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    objc_setAssociatedObject(self, @selector(isNavigationBar), @(navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
-(void)setLeftBarHidden:(BOOL)leftBarHidden{
    // 当只有一个左侧返回按钮的时候，将按钮可触控范围增大
    if (leftBarHidden) {
        self.navigationBar.leftButton.hidden = YES;
        self.navigationBar.backButton.frame = CGRectMake(20, 20, 75, 44);
        [self.navigationBar.backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.navigationBar.backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    }else{
        self.navigationBar.leftButton.hidden = NO;
        self.navigationBar.backButton.frame = CGRectMake(0, 20, 52, 44);
        [self.navigationBar.backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.navigationBar.backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    }
    objc_setAssociatedObject(self, @selector(leftBarHidden), @(leftBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)leftBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
-(NSString *)title{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_COPY);
}
-(UIColor*)navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor{
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundColor), navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor*)barBottomLineBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setBarBottomLineBackgroundColor:(UIColor *)barBottomLineBackgroundColor{
    objc_setAssociatedObject(self, @selector(barBottomLineBackgroundColor), barBottomLineBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (void)setBackButtonImage:(UIImage *)backButtonImage{
    objc_setAssociatedObject(self, &backButtonImageKey, backButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage*)backButtonImage{
    return objc_getAssociatedObject(self, &backButtonImageKey);
}
- (void)setGradientBackgroundFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor{
    self.navigationBar.gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
}

@end

@interface TMNavigationController ()<UIGestureRecognizerDelegate>
@property (strong , nonatomic) navigationBarView * barView;
@end

@implementation TMNavigationController
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
    }
    return self;
}
-(void)loadView{
    [super loadView];
    [self createBarView];
    [self popGesture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)createBarView{
    self.navigationBarHidden = YES;
    self.barView  = [[navigationBarView alloc]init];
    [self.barView clickBackButton:^(UIButton *button) {
        [self popViewControllerAnimated:YES];
    }];
    [self.topViewController.view addSubview:self.barView];
    self.barView.title = self.topViewController.title;
    if (self.viewControllers.count==0) {
        self.barView.backButton.hidden = YES;
    }
}
-(void)popGesture{
    self.interactivePopGestureRecognizer.enabled = NO;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:pan];
    NSMutableArray * _targets = [self.interactivePopGestureRecognizer valueForKey:@"_targets"];
    id _UINavigationInteractiveTransition = [[_targets firstObject] valueForKey:@"_target"];
    SEL popAction = NSSelectorFromString(@"handleNavigationTransition:");
    [pan addTarget:_UINavigationInteractiveTransition action:popAction];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    navigationBarView * bar = [[navigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [viewController.view addSubview:bar];
    [bar clickBackButton:^(UIButton *button) {
        [self popViewControllerAnimated:YES];
    }];
    if (self.viewControllers.count==0) {
        bar.backButton.hidden = YES;
    }
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (viewController.navigationBarHidden) {
        bar.hidden = YES;
    }
    if (viewController.navigationBarBackgroundColor) {
        bar.backgroundColor = viewController.navigationBarBackgroundColor;
    }
    if (viewController.barBottomLineBackgroundColor) {
        bar.lineView.backgroundColor = viewController.barBottomLineBackgroundColor;
    }
    if (viewController.backButtonImage) {
        [bar.backButton setImage:viewController.backButtonImage forState:UIControlStateNormal];
    }
    bar.title = viewController.title;
    viewController.navigationBar = bar;
    viewController.leftBarHidden = YES;
    
    [super pushViewController:viewController animated:animated];
}
-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end





