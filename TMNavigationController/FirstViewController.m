//
//  FirstViewController.m
//  TMNavigationController
//
//  Created by TianMing on 16/3/18.
//  Copyright © 2016年 TianMing. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First";
    [self setTabBarItemWithTitle:@"first" image:@"2" selectedImage:@"left"];
}
-(void)setTabBarItemWithTitle:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage {
    UIImage * itemImage = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *itemSelectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.title = title;
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:itemImage selectedImage:itemSelectedImage];
    NSDictionary * dic = @{NSForegroundColorAttributeName:[UIColor redColor]};
    [self.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
}
- (IBAction)push:(id)sender {
    SecondViewController * vc = [SecondViewController new];
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
