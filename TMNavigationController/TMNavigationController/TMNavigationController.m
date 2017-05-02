//
//  TMNavigationController.m
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#import "TMNavigationController.h"
#import "objc/runtime.h"

@interface navigationBarView ()
@end
@implementation navigationBarView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    if (self) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-0.5,frame.size.width,0.5)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self addSubview:lineView];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 25, 200, 35)];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(15, 20, 80, 44);
        [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_backButton];
    }
    return self;
}
-(void)backLastView:(UIButton*)button{
    if (self.click) {
        self.click(button);
    }
}
-(void)clickBackButton:(clickBackButton)block{
    self.click = block;
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
@dynamic title;
@dynamic backButtonImage;
@dynamic navigationBarBackgroundColor;

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
- (void)setBackButtonImage:(UIImage *)backButtonImage{
    objc_setAssociatedObject(self, &backButtonImageKey, backButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage*)backButtonImage{
    return objc_getAssociatedObject(self, &backButtonImageKey);
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
    [bar clickBackButton:^(UIButton *button) {
        [self popViewControllerAnimated:YES];
    }];
    [viewController.view addSubview:bar];
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
    if (viewController.backButtonImage) {
        [bar.backButton setImage:viewController.backButtonImage forState:UIControlStateNormal];
    }
    bar.title = viewController.title;
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





