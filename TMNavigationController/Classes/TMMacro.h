//
//  TMMacro.h
//  TMNavigationController
//
//  Created by 天明 on 2022/2/16.
//  Copyright © 2022 TianMing. All rights reserved.
//

#ifndef TMMacro_h
#define TMMacro_h

#import "TMNavigationConfig.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 阿拉伯语等适配
#define kIsRTL [[TMNavigationConfig shareInstance] getIsRTL]

// 顶部安全区
CG_INLINE CGFloat TMSafeInsetTop(void) {
    return [TMNavigationConfig tm_safeAreaInsets].top;
}

// 底部安全区
CG_INLINE CGFloat TMSafeInsetBottom(void) {
    return [TMNavigationConfig tm_safeAreaInsets].bottom;
}

#define TM_StatusBarHeight      TMSafeInsetTop()
#define TM_NavigationBarHeight  44.f
#define TM_TopBarHeight      (TMSafeInsetTop() + TM_NavigationBarHeight)
#define TM_TabbarSafeBottomMargin      TMSafeInsetBottom()
#define TM_TabbarHeight         (TM_TabbarSafeBottomMargin + 49.f)

#define kWEAK_SELF __weak typeof(self) weakSelf = self;


#endif /* TMMacro_h */
