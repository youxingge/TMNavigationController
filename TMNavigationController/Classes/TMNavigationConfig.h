//
//  TMNavigationConfig.h
//  TMNavigationController
//
//  Created by TianMing on 2022/11/29.
//  Copyright © 2022 TianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TMInterfaceLayoutDirection) {
    TMInterfaceLayoutDirectionLeftToRight = 1,    //从左到右
    TMInterfaceLayoutDirectionRightToLeft        //从右到左
};

NS_ASSUME_NONNULL_BEGIN

@interface TMNavigationConfig : NSObject

// 获取安全区域
+ (UIEdgeInsets)tm_safeAreaInsets;

// 获取keyWindow
+ (UIWindow *)tm_getKeyWindow;

+ (instancetype)shareInstance;

// 切换语言时候，外部设置RTL
@property (nonatomic, assign) TMInterfaceLayoutDirection layoutDirection;

// 默认全屏滑动返回
// 可选全局配置 侧滑返回
@property (nonatomic, assign) BOOL forceSideslipGesture;

// 配置全局的导航栏左侧返回按钮图片
@property (nonatomic, strong, nullable) UIImage *backButtonImage;

// 配置全局的导航栏标题
@property (nonatomic, strong, nullable) UIFont *navigationBarTitleLabelFont;

// 配置全局的 横屏时候导航栏高度
@property (nonatomic, assign) CGFloat landscapeModeNavigationBarHeight;

// 获取RTL
- (BOOL)getIsRTL;


@end

NS_ASSUME_NONNULL_END
