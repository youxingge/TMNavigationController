//
//  SecondViewController.m
//  TMNavigationController
//
//  Created by TianMing on 16/3/18.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "TMNavigationController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBarTitleColor = [UIColor whiteColor];
    self.navigationBarBackgroundColor = [UIColor blueColor];
    self.navigationBackButtonImage = [UIImage imageNamed:@"tm_back"];
    

//    self.navigationRightFirstBarHidden = NO;
//    self.navigationRightFirstBarTitle = @"分享";
//    self.navigationRightFirstBarTitleColor = [UIColor whiteColor];
    
    self.navigationRightBarHidden = NO;
    self.navigationRightBarTitle = @"右边啊";
    self.navigationRightBarTitleColor = [UIColor whiteColor];
//    self.navigationRightBarImage = [UIImage imageNamed:@"tm_back"];

//    self.navigationLeftBarHidden = NO;
//    self.navigationLeftBarTitleColor = [UIColor whiteColor];
    kWEAK_SELF
    [self navigationRightButtonClickBlock:^(UIButton * button) {
        NSLog(@"ddddddd");
        weakSelf.title = @"right";
    }];
   

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationCanSideslipBack = YES;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationCanSideslipBack = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SecondSecondSecondSecondSecondSecondSecondSecondSecond";

    
}
- (IBAction)push:(id)sender {
    ThirdViewController * vc = [ThirdViewController new];
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
