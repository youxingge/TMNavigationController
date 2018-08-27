//
//  TMNavigationViewController.h
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TMNavigationController : UINavigationController
@property (strong , nonatomic) UIPanGestureRecognizer * panGesture;

@end

typedef void(^clickBackButton)(UIButton * button);
typedef void(^clickLeftButton)(UIButton * button);
typedef void(^clickRightButton)(UIButton * button);
typedef void(^clickRightFirstButton)(UIButton * button);

@interface navigationBarView : UIView
@property (strong ,nonatomic) CAGradientLayer * gradientLayer;

@property (copy ,nonatomic) NSString * title;
@property (strong ,nonatomic) UILabel * titleLabel;
@property (strong ,nonatomic) UIButton * backButton;
@property (strong ,nonatomic) UIButton * leftButton;
@property (strong ,nonatomic) UIButton * rightButton;
@property (strong ,nonatomic) UIButton * rightRedButton;
@property (strong ,nonatomic) UIButton * rightFirstButton;
@property (strong ,nonatomic) UIImageView * backgroundImageView;

@property (strong ,nonatomic) UIView * lineView;
@property (strong ,nonatomic) UIColor * myBackgroundColor;
@property (strong ,nonatomic) UIImage * myBackgroundImage;

@property (strong ,nonatomic) UIColor * myTitleColor;
@property (strong ,nonatomic) UIColor * myBottomLineColor;


-(instancetype)initWithFrame:(CGRect)frame;


@property (copy ,nonatomic) clickBackButton click;
@property (copy ,nonatomic) clickLeftButton leftClick;
@property (copy ,nonatomic) clickRightButton rightClick;
@property (copy ,nonatomic) clickRightFirstButton rightFirstClick;

// 设置左侧按钮 和右侧按钮 以及返回按钮点击方法
-(void)clickBackButton:(clickBackButton)block;
-(void)clickLeftButton:(clickLeftButton)block;
-(void)clickRightButton:(clickRightButton)block;
-(void)clickRightFirstButton:(clickRightFirstButton)block;

@end



@interface UIViewController (navigationBar)

// 是否允许全屏滑动返回
@property (nonatomic,assign)BOOL navigationCanDragBack;

@property (nonatomic,strong)navigationBarView *navigationBar;
// 标题
@property (nonatomic,copy)NSString *title;
// 标题颜色
@property (nonatomic,copy)UIColor *navigationBarTitleColor;

// 设置navigationBar的颜色
@property (nonatomic,strong)UIColor *navigationBarBackgroundColor;
// 设置navigationBar背景图
@property (nonatomic,strong)UIImage *navigationBarBackgroundImage;


// 设置bottomLine的颜色
@property (nonatomic,strong)UIColor *navigationBarBottomLineBackgroundColor;
// 隐藏navigationBar
@property (nonatomic,getter=isNavigationBar)BOOL navigationBarHidden;


// 设置backButton的图片
@property (nonatomic,assign)BOOL navigationBackBarHidden;
@property (nonatomic,strong)UIImage *navigationBackButtonImage;

// 隐藏leftBar
@property (nonatomic,assign)BOOL navigationLeftBarHidden;
@property (nonatomic,strong)UIColor * navigationLeftBarTitleColor;


// 隐藏rightFirstBar
@property (nonatomic,assign)BOOL navigationRightFirstBarHidden;
// 设置rightFirstBar文字
@property (nonatomic,strong)NSString * navigationRightFirstBarTitle;
// 设置rightFirstBar文字颜色
@property (nonatomic,strong)UIColor * navigationRightFirstBarTitleColor;
// 设置rightFirstBar图片
@property (nonatomic,strong)UIImage * navigationRightFirstBarImage;

// 隐藏rightBar
@property (nonatomic,assign)BOOL navigationRightBarHidden;
// 设置rightBar文字
@property (nonatomic,strong)NSString * navigationRightBarTitle;
// 设置rightBar文字颜色
@property (nonatomic,strong)UIColor * navigationRightBarTitleColor;
// 设置rightBar图片
@property (nonatomic,strong)UIImage * navigationRightBarImage;

@property (nonatomic,assign)BOOL navigationRightBarRedButtonShow;


// 设置导航颜色渐变色
- (void)setNavigationGradientBackgroundFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor;
// 设置导航透明度
- (void)setNavigationBarAlpha:(CGFloat)alpha;




@end
