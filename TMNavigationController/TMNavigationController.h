//
//  TMNavigationViewController.h
//  Demo
//
//  Created by TianMing on 16/3/10.
//  Copyright © 2016年 TianMing. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TMNavigationController : UINavigationController
@end
typedef void(^clicBackButton)(UIButton * button);
@interface navigationBarView : UIView
@property (copy ,nonatomic) clicBackButton click;
-(void)clickBackButton:(clicBackButton)block;
@property (copy ,nonatomic) NSString * title;
@property (strong ,nonatomic)UILabel * titleLabel;
@property (strong ,nonatomic)UIButton * backButton;
-(instancetype)initWithFrame:(CGRect)frame;
@end
