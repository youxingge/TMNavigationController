//
//  TMNavigationController.m
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


/*
 宏定义
 */
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define BR_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define BR_StatusBarHeight      (BR_iPhoneX ? 44.f : 20.f)
#define BR_NavigationBarHeight  44.f
#define TopBarHeight      (BR_iPhoneX ? 88.f : 64.f)
#define TabbarHeight         (BR_iPhoneX ? (49.f+34.f) : 49.f)
#define BR_TabbarSafeBottomMargin      (BR_iPhoneX ? 34.f : 0.f)



#import "TMNavigationController.h"
#import "objc/runtime.h"





@interface navigationBarView ()
@end
@implementation navigationBarView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopBarHeight)];
    if (self) {
        
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.frame = self.frame;
        [self.layer addSublayer:gradientLayer];
        self.gradientLayer = gradientLayer;
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_backgroundImageView];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-0.5,frame.size.width,0.5)];
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        [self addSubview:_lineView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.adjustsImageWhenHighlighted = NO;
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(0, BR_StatusBarHeight-10, 62, 50);
        [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.adjustsImageWhenHighlighted = NO;
        [_leftButton setTitle:@"关闭" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftButton.frame = CGRectMake(46, BR_StatusBarHeight, 50, TopBarHeight-BR_StatusBarHeight);
        [_leftButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_leftButton];
        
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.adjustsImageWhenHighlighted = NO;
        [_rightButton setTitle:@"" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightButton.frame = CGRectMake(SCREEN_WIDTH-70, BR_StatusBarHeight, 54, TopBarHeight-BR_StatusBarHeight);
        [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_rightButton];
        
        _rightRedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightRedButton.frame = CGRectMake(_rightButton.frame.origin.x + _rightButton.frame.size.width, _rightButton.frame.origin.y+6, 8, 8);
        _rightRedButton.backgroundColor = [UIColor redColor];
        [self addSubview:_rightRedButton];
        _rightRedButton.layer.cornerRadius = 4;
        _rightRedButton.layer.masksToBounds = YES;
        
        _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightFirstButton.adjustsImageWhenHighlighted = NO;
        [_rightFirstButton setTitle:@"" forState:UIControlStateNormal];
        _rightFirstButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-70- 44, BR_StatusBarHeight, 54, TopBarHeight-BR_StatusBarHeight);
        [_rightFirstButton addTarget:self action:@selector(rightFirstAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightFirstButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
        [_rightFirstButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rightFirstButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_rightFirstButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, BR_StatusBarHeight, SCREEN_WIDTH - 90*2, 44)];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorFromRGB(0x27313e);
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.5];
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
- (void)rightAction:(UIButton*)button{
    if (self.rightClick) {
        self.rightClick(button);
    }
}
- (void)rightFirstAction:(UIButton*)button{
    if (self.rightFirstClick) {
        self.rightFirstClick(button);
    }
    
}
-(void)clickBackButton:(clickBackButton)block{
    self.click = block;
}
- (void)clickLeftButton:(clickBackButton)block{
    self.leftClick = block;
}
- (void)clickRightButton:(clickRightButton)block{
    self.rightClick = block;
}
- (void)clickRightFirstButton:(clickRightFirstButton)block{
    self.rightFirstClick  = block;
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
- (void)setMyBackgroundColor:(UIColor *)myBackgroundColor{
    _myBackgroundColor = myBackgroundColor;
    if (!myBackgroundColor) {
        _backgroundImageView.backgroundColor = [UIColor whiteColor];
    }else{
        _backgroundImageView.backgroundColor = myBackgroundColor;
    }
}
- (void)setMyBackgroundImage:(UIImage *)myBackgroundImage{
    _myBackgroundImage = myBackgroundImage;
    if (!myBackgroundImage) {
        _backgroundImageView.backgroundColor = [UIColor whiteColor];
    }else{
        _backgroundImageView.image = myBackgroundImage;
    }
}
- (void)setMyTitleColor:(UIColor *)myTitleColor{
    _myTitleColor = myTitleColor;
    if (myTitleColor) {
        _titleLabel.textColor = myTitleColor;
    }
}
- (void)setMyBottomLineColor:(UIColor *)myBottomLineColor{
    _myBottomLineColor = myBottomLineColor;
    if (myBottomLineColor) {
        _lineView.backgroundColor = myBottomLineColor;
    }else{
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    }
}



@end











@implementation UIViewController (navigationBar)

@dynamic navigationCanDragBack;
@dynamic navigationRightBarImage;
@dynamic navigationBar;
@dynamic navigationBarHidden;
@dynamic navigationLeftBarHidden;
@dynamic navigationRightBarHidden;
@dynamic navigationRightBarTitleColor;
@dynamic navigationRightBarTitle;
@dynamic title;
@dynamic navigationBackButtonImage;
@dynamic navigationBarBackgroundColor;
@dynamic navigationBarBottomLineBackgroundColor;
@dynamic navigationBarTitleColor;
@dynamic navigationRightFirstBarImage;
@dynamic navigationRightFirstBarHidden;
@dynamic navigationRightFirstBarTitle;
@dynamic navigationRightFirstBarTitleColor;
@dynamic navigationBarBackgroundImage;
@dynamic navigationRightBarRedButtonShow;
@dynamic navigationLeftBarTitleColor;


- (BOOL)navigationCanDragBack{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationCanDragBack:(BOOL)navigationCanDragBack{
    TMNavigationController * nav = (TMNavigationController*)self.navigationController;
    if (!navigationCanDragBack && nav) {
        // 禁用返回手势
        nav.panGesture.enabled = NO;
    }else{
        nav.panGesture.enabled = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationCanDragBack), @(navigationCanDragBack), OBJC_ASSOCIATION_ASSIGN);
}
- (navigationBarView *)navigationBar{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar:(navigationBarView *)navigationBar{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isNavigationBar{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    objc_setAssociatedObject(self, @selector(isNavigationBar), @(navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setNavigationBackBarHidden:(BOOL)navigationBackBarHidden{
    if (navigationBackBarHidden) {
        self.navigationBar.backButton.hidden = YES;
    }else{
        self.navigationBar.backButton.hidden = NO;
    }
    objc_setAssociatedObject(self, @selector(navigationBackBarHidden), @(navigationBackBarHidden), OBJC_ASSOCIATION_ASSIGN);
    
}
- (BOOL)navigationBackBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationLeftBarHidden:(BOOL)navigationLeftBarHidden{
    // 当只有一个左侧返回按钮的时候，将按钮可触控范围增大
    if (navigationLeftBarHidden) {
        self.navigationBar.leftButton.hidden = YES;
        self.navigationBar.backButton.frame = CGRectMake(5, BR_StatusBarHeight, 65, TopBarHeight-BR_StatusBarHeight);
        [self.navigationBar.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 35)];
    }else{
        self.navigationBar.leftButton.hidden = NO;
        self.navigationBar.backButton.frame = CGRectMake(0, BR_StatusBarHeight, 50, TopBarHeight-BR_StatusBarHeight);
        [self.navigationBar.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    objc_setAssociatedObject(self, @selector(navigationLeftBarHidden), @(navigationLeftBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationLeftBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNavigationRightFirstBarHidden:(BOOL)navigationRightFirstBarHidden{
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarHidden), @(navigationRightFirstBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (UIColor*)navigationLeftBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationLeftBarTitleColor:(UIColor *)navigationLeftBarTitleColor{
    if (navigationLeftBarTitleColor) {
        [self.navigationBar.leftButton setTitleColor:navigationLeftBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationLeftBarTitleColor), navigationLeftBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)navigationRightFirstBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNavigationRightBarHidden:(BOOL)navigationRightBarHidden{
    if (navigationRightBarHidden == NO) {
        self.navigationBar.rightButton.hidden = NO;
    } else{
        self.navigationBar.rightButton.hidden = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarHidden), @(navigationRightBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationRightBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (NSString*)navigationRightBarTitle{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarTitle:(NSString *)navigationRightBarTitle{
    if (navigationRightBarTitle) {
        UIFont * font = self.navigationBar.rightButton.titleLabel.font;
        CGFloat width = [self getSizeWithString:navigationRightBarTitle withFontCustom:font].width;
        [self.navigationBar.rightButton setTitle:navigationRightBarTitle forState:UIControlStateNormal];
        self.navigationBar.rightButton.frame = CGRectMake(SCREEN_WIDTH-width-5, BR_StatusBarHeight, width, TopBarHeight-BR_StatusBarHeight);
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarTitle), navigationRightBarTitle, OBJC_ASSOCIATION_RETAIN);
}
- (NSString*)navigationRightFirstBarTitle{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarTitle:(NSString *)navigationRightFirstBarTitle{
    if (navigationRightFirstBarTitle) {
        UIFont * font = self.navigationBar.rightFirstButton.titleLabel.font;
        CGFloat width = [self getSizeWithString:navigationRightFirstBarTitle withFontCustom:font].width;
        [self.navigationBar.rightFirstButton setTitle:navigationRightFirstBarTitle forState:UIControlStateNormal];
        self.navigationBar.rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-width-5 - 75, BR_StatusBarHeight, width, TopBarHeight-BR_StatusBarHeight);
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarTitle), navigationRightFirstBarTitle, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor*)navigationRightFirstBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarTitleColor:(UIColor *)navigationRightFirstBarTitleColor{
    if (navigationRightFirstBarTitleColor) {
        [self.navigationBar.rightFirstButton setTitleColor:navigationRightFirstBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarTitleColor), navigationRightFirstBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor*)navigationRightBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarTitleColor:(UIColor *)navigationRightBarTitleColor{
    if (navigationRightBarTitleColor) {
        [self.navigationBar.rightButton setTitleColor:navigationRightBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarTitleColor), navigationRightBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage*)navigationRightFirstBarImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarImage:(UIImage *)navigationRightFirstBarImage{
    if (navigationRightFirstBarImage) {
        self.navigationBar.rightFirstButton.titleLabel.text = @"";
        [self.navigationBar.rightFirstButton setImage:navigationRightFirstBarImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarImage), navigationRightFirstBarImage, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage*)navigationRightBarImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarImage:(UIImage *)navigationRightBarImage{
    if (navigationRightBarImage) {
        self.navigationBar.rightButton.titleLabel.text = @"";
        [self.navigationBar.rightButton setImage:navigationRightBarImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarImage), navigationRightBarImage, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)title{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTitle:(NSString *)title{
    if (title && self.navigationBar ) {
        if ([self.navigationBar isKindOfClass:[navigationBarView class]]) {
            [self.navigationBar setTitle:title];
        }
    }
    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_COPY);
}
- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor{
    if (navigationBarTitleColor) {
        self.navigationBar.myTitleColor = navigationBarTitleColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarTitleColor), navigationBarTitleColor, OBJC_ASSOCIATION_COPY);
    
}
- (UIColor*)navigationBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor{
    if (navigationBarBackgroundColor) {
        self.navigationBar.myBackgroundColor = navigationBarBackgroundColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundColor), navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor*)navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage{
    if (navigationBarBackgroundImage) {
        self.navigationBar.myBackgroundImage = navigationBarBackgroundImage;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundImage), navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage*)navigationBarBackgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBarBottomLineBackgroundColor:(UIColor *)navigationBarBottomLineBackgroundColor{
    if (navigationBarBottomLineBackgroundColor) {
        self.navigationBar.myBottomLineColor = navigationBarBottomLineBackgroundColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBottomLineBackgroundColor), navigationBarBottomLineBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor*)navigationBarBottomLineBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationBackButtonImage:(UIImage *)navigationBackButtonImage{
    if (navigationBackButtonImage) {
        [self.navigationBar.backButton setImage:navigationBackButtonImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationBackButtonImage), navigationBackButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage*)navigationBackButtonImage{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationRightBarRedButtonShow:(BOOL)navigationRightBarRedButtonShow{
    if (navigationRightBarRedButtonShow) {
        self.navigationBar.rightRedButton.hidden = NO;
    }else{
        self.navigationBar.rightRedButton.hidden = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarRedButtonShow), @(navigationRightBarRedButtonShow), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationRightBarRedButtonShow{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNavigationGradientBackgroundFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor{
    self.navigationBar.gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
}
- (void)setNavigationBarAlpha:(CGFloat)alpha{
    for (UIView * view in self.navigationBar.subviews) {
        view.alpha = alpha;
    }
}
- (CGSize)getSizeWithString:(NSString*)string withFontCustom:(UIFont *)font{
    CGSize size = CGSizeMake(SCREEN_WIDTH/2, TopBarHeight);
    font == nil ? [UIFont systemFontOfSize:18] :font;
    CGRect frame =[string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font}context:nil];
    return CGSizeMake(round(frame.size.width + 0.5), round(frame.size.height + 0.5));
}

@end







@interface TMNavigationController ()<UIGestureRecognizerDelegate>
@property (strong , nonatomic) navigationBarView * barView;
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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationCanDragBack = YES;
    [self addPopGesture];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (self.navigationCanDragBack) {
//    }
//}
- (void)createBarView{
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
    navigationBarView * bar = [[navigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopBarHeight)];
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
    bar.title = viewController.title;
    viewController.navigationBar = bar;
    
    //左边第二个按钮隐藏 右边按钮隐藏
    viewController.navigationLeftBarHidden = YES;
    viewController.navigationRightBarHidden = YES;
    viewController.navigationRightFirstBarHidden = YES;
    viewController.navigationRightBarRedButtonShow = NO;
    // 设置渐变色后，设置背景颜色不起作用
    //    [viewController setGradientBackgroundFromColor:UIColorFromRGB(0x12ace5) toColor:UIColorFromRGB(0x1e82d2)];
    
    [super pushViewController:viewController animated:animated];
    
    CGRect frame = self.tabBarController.tabBar.frame;
    // 设置frame的y值, y = 屏幕高度 - tabBar高度
    frame.origin.y = SCREEN_HEIGHT - frame.size.height;
    // 修改tabBar的frame
    self.tabBarController.tabBar.frame = frame;
    
}
- (UIViewController*)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end





