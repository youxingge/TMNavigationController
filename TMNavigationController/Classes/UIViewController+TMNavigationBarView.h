//
//  UIViewController+TMNavigationBarView.h
//  TMNavigationController
//
//  Created by TianMing on 2019/2/22.
//  Copyright © 2019 TianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TMNavigationBarView)
// 是否允许全屏滑动返回
@property (nonatomic,assign)BOOL navigationCanDragBack;
// 顶部导航
@property (nonatomic,strong)TMNavigationBarView *navigationBar;
// 标题
@property (nonatomic,copy)NSString* title;
// 标题颜色
@property (nonatomic,copy)UIColor* navigationBarTitleColor;

// 设置navigationBar的颜色
@property (nonatomic,strong)UIColor* navigationBarBackgroundColor;
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

- (void)navigationBackButtonClickBlock:(void (^)(UIButton* button))block;
- (void)navigationLeftButtonClickBlock:(void (^)(UIButton* button))block;
- (void)navigationRightButtonClickBlock:(void (^)(UIButton* button))block;
- (void)navigationRightFirstButtonClickBlock:(void (^)(UIButton* button))block;




@end

NS_ASSUME_NONNULL_END
