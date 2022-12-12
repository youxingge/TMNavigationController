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

+ (instancetype)shareInstance;

// 切换语言时候，外部设置RTL
@property (nonatomic ,assign) TMInterfaceLayoutDirection layoutDirection;

// 默认全屏滑动返回
// 可选全局配置 侧滑返回
@property (nonatomic ,assign) BOOL forceSideslipGesture;

@property (nonatomic ,strong ,nullable) UIImage *backButtonImage;

// 获取RTL
- (BOOL)getIsRTL;


@end

NS_ASSUME_NONNULL_END
