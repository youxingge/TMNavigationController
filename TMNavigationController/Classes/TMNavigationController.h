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
#import "UIViewController+navigationBarView.h"
#import "Macro.h"

@interface TMNavigationController : UINavigationController
@property (strong , nonatomic) UIPanGestureRecognizer * panGesture;
@end





