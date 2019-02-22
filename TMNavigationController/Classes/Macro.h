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

#define TM_iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
#define TM_iPhoneXr (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
#define TM_iPhoneXsMax (SCREEN_WIDTH == 621.f && SCREEN_HEIGHT == 1344.f ? YES : NO)

#define TM_StatusBarHeight      ((TM_iPhoneX||TM_iPhoneXr||TM_iPhoneXsMax) ? 44.f : 20.f)
#define TM_NavigationBarHeight  44.f
#define TM_TopBarHeight      ((TM_iPhoneX||TM_iPhoneXr||TM_iPhoneXsMax) ? 88.f : 64.f)
#define TM_TabbarHeight         ((TM_iPhoneX||TM_iPhoneXr||TM_iPhoneXsMax) ? (49.f+34.f) : 49.f)
#define TM_TabbarSafeBottomMargin      ((TM_iPhoneX||TM_iPhoneXr||TM_iPhoneXsMax) ? 34.f : 0.f)

#define kWEAK_SELF __weak typeof(self) weakSelf = self;


#endif /* Macro_h */
