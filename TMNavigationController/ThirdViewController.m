//
//  ThirdViewController.m
//  TMNavigationController
//
//  Created by TianMing on 16/3/18.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "TMNavigationController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Third";
    self.navigationBarHidden = YES;
}
- (IBAction)push:(id)sender {
    FourthViewController * vc = [FourthViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
