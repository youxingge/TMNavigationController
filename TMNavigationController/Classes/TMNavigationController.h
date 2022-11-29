//
//  TMNavigationViewController.h
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "objc/runtime.h"
#import "TMNavigationBarView.h"
#import "UIViewController+TMNavigationBarView.h"
#import "TMMacro.h"

@interface TMNavigationController : UINavigationController

@property (strong , nonatomic) UIPanGestureRecognizer * panGesture;

// 单独控制某个导航侧滑
@property (nonatomic,assign) BOOL navigationCanSideslipBack;


@end





