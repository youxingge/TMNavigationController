//
//  FourthViewController.m
//  TMNavigationController
//
//  Created by TianMing on 16/4/8.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "FourthViewController.h"
#import "TMNavigationController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FourthViewController ()

@end

@implementation FourthViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationCanDragBack = NO; // 不能全屏返回
    // 设置渐变色后，设置背景颜色不起作用
    [self setNavigationGradientBackgroundFromColor:UIColorFromRGB(0x12ace5) toColor:UIColorFromRGB(0x1e82d2)];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationCanDragBack = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Fourth";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
