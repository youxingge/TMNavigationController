//
//  TMNavigationViewController.h
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TMNavigationController : UINavigationController
@end

typedef void(^clickBackButton)(UIButton * button);
typedef void(^clickleftButton)(UIButton * button);

@interface navigationBarView : UIView
@property (strong ,nonatomic) CAGradientLayer * gradientLayer;
@property (copy ,nonatomic) clickBackButton click;
@property (copy ,nonatomic) clickleftButton leftClick;
@property (copy ,nonatomic) NSString * title;
@property (strong ,nonatomic) UILabel * titleLabel;
@property (strong ,nonatomic) UIButton * backButton;
@property (strong ,nonatomic) UIButton * leftButton;
@property (strong ,nonatomic) UIView * lineView;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)clickBackButton:(clickBackButton)block;
-(void)clickLeftButton:(clickBackButton)block;

@end

@interface UIViewController (navigationBar)

@property (nonatomic,strong) navigationBarView *navigationBar;
@property (nonatomic,getter=isNavigationBar)BOOL navigationBarHidden;
@property (nonatomic,assign)BOOL leftBarHidden;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UIImage *backButtonImage;
@property (nonatomic,strong)UIColor *barBottomLineBackgroundColor;
@property (nonatomic,strong)UIColor *navigationBarBackgroundColor;

- (void)setGradientBackgroundFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor;

@end
