//
//  Macro.h
//  TMNavigationController
//
//  Created by TianMing on 2018/8/27.
//  Copyright © 2018年 TianMing. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kDevice_Is_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})



// 顶部安全区
CG_INLINE CGFloat KKSafeInsetTop(void) {
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeInset = UIApplication.sharedApplication.keyWindow.safeAreaInsets;
        if (UIEdgeInsetsEqualToEdgeInsets(safeInset, UIEdgeInsetsZero)) {
            return CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame);
        }
        return UIApplication.sharedApplication.keyWindow.safeAreaInsets.top;
    } else {
        return CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame);
    }
}

// 底部安全区
CG_INLINE CGFloat KKSafeInsetBottom(void) {
    if (@available(iOS 11.0, *)) {
        return UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    } else {
        return 0;
    }
}

#define TM_StatusBarHeight      KKSafeInsetTop()
#define TM_NavigationBarHeight  44.f
#define TM_TopBarHeight      (KKSafeInsetTop() + TM_NavigationBarHeight)
#define TM_TabbarSafeBottomMargin      KKSafeInsetBottom()
#define TM_TabbarHeight         (TM_TabbarSafeBottomMargin + 49.f)

#define kWEAK_SELF __weak typeof(self) weakSelf = self;


#endif /* Macro_h */
