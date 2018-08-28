//
//  TMNavigationBarView.h
//  TMNavigationController
//
//  Created by TianMing on 2018/8/27.
//  Copyright © 2018年 TianMing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^clickBackButton)(UIButton * button);
typedef void(^clickLeftButton)(UIButton * button);
typedef void(^clickRightButton)(UIButton * button);
typedef void(^clickRightFirstButton)(UIButton * button);

@interface TMNavigationBarView : UIView

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

- (instancetype)initWithFrame:(CGRect)frame;

@property (copy ,nonatomic) clickBackButton click;
@property (copy ,nonatomic) clickLeftButton leftClick;
@property (copy ,nonatomic) clickRightButton rightClick;
@property (copy ,nonatomic) clickRightFirstButton rightFirstClick;

// 设置左侧按钮 和右侧按钮 以及返回按钮点击方法
- (void)clickBackButton:(clickBackButton)block;
- (void)clickLeftButton:(clickLeftButton)block;
- (void)clickRightButton:(clickRightButton)block;
- (void)clickRightFirstButton:(clickRightFirstButton)block;

@end


