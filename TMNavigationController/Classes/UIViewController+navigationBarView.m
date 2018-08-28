//
//  UIViewController+navigationBarView.m
//  TMNavigationController
//
//  Created by TianMing on 2018/8/27.
//  Copyright © 2018年 TianMing. All rights reserved.
//

#import "UIViewController+navigationBarView.h"
#import "TMNavigationController.h"


@implementation UIViewController (navigationBar)

@dynamic navigationCanDragBack;
@dynamic navigationRightBarImage;
@dynamic navigationBar;
@dynamic navigationBarHidden;
@dynamic navigationLeftBarHidden;
@dynamic navigationRightBarHidden;
@dynamic navigationRightBarTitleColor;
@dynamic navigationRightBarTitle;
@dynamic title;
@dynamic navigationBackButtonImage;
@dynamic navigationBarBackgroundColor;
@dynamic navigationBarBottomLineBackgroundColor;
@dynamic navigationBarTitleColor;
@dynamic navigationRightFirstBarImage;
@dynamic navigationRightFirstBarHidden;
@dynamic navigationRightFirstBarTitle;
@dynamic navigationRightFirstBarTitleColor;
@dynamic navigationBarBackgroundImage;
@dynamic navigationRightBarRedButtonShow;
@dynamic navigationLeftBarTitleColor;

- (BOOL)navigationCanDragBack{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationCanDragBack:(BOOL)navigationCanDragBack{
    TMNavigationController * nav = (TMNavigationController*)self.navigationController;
    if (!navigationCanDragBack && nav) {
        // 禁用返回手势
        nav.panGesture.enabled = NO;
    }else{
        nav.panGesture.enabled = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationCanDragBack), @(navigationCanDragBack), OBJC_ASSOCIATION_ASSIGN);
}
- (TMNavigationBarView *)navigationBar{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar:(TMNavigationBarView *)navigationBar{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isNavigationBar{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    if (navigationBarHidden) {
        self.navigationBar.hidden = YES;
    }else{
        self.navigationBar.hidden = NO;
    }
    objc_setAssociatedObject(self, @selector(isNavigationBar), @(navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setNavigationBackBarHidden:(BOOL)navigationBackBarHidden{
    if (navigationBackBarHidden) {
        self.navigationBar.backButton.hidden = YES;
    }else{
        self.navigationBar.backButton.hidden = NO;
    }
    objc_setAssociatedObject(self, @selector(navigationBackBarHidden), @(navigationBackBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationBackBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationLeftBarHidden:(BOOL)navigationLeftBarHidden{
    // 当只有一个左侧返回按钮的时候，将按钮可触控范围增大
    if (navigationLeftBarHidden) {
        self.navigationBar.leftButton.hidden = YES;
        self.navigationBar.backButton.frame = CGRectMake(5, TM_StatusBarHeight, 65, TM_TopBarHeight-TM_StatusBarHeight);
        [self.navigationBar.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 35)];
    }else{
        self.navigationBar.leftButton.hidden = NO;
        self.navigationBar.backButton.frame = CGRectMake(0, TM_StatusBarHeight, 50, TM_TopBarHeight-TM_StatusBarHeight);
        [self.navigationBar.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    objc_setAssociatedObject(self, @selector(navigationLeftBarHidden), @(navigationLeftBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationLeftBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (BOOL)navigationRightFirstBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationRightFirstBarHidden:(BOOL)navigationRightFirstBarHidden{
    if (navigationRightFirstBarHidden) {
        self.navigationBar.rightFirstButton.hidden = YES;
    }else{
        self.navigationBar.rightFirstButton.hidden = NO;
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarHidden), @(navigationRightFirstBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (UIColor*)navigationLeftBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationLeftBarTitleColor:(UIColor *)navigationLeftBarTitleColor{
    if (navigationLeftBarTitleColor) {
        [self.navigationBar.leftButton setTitleColor:navigationLeftBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationLeftBarTitleColor), navigationLeftBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (void)setNavigationRightBarHidden:(BOOL)navigationRightBarHidden{
    if (navigationRightBarHidden == NO) {
        self.navigationBar.rightButton.hidden = NO;
    } else{
        self.navigationBar.rightButton.hidden = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarHidden), @(navigationRightBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationRightBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (NSString*)navigationRightBarTitle{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarTitle:(NSString *)navigationRightBarTitle{
    if (navigationRightBarTitle) {
        UIFont * font = self.navigationBar.rightButton.titleLabel.font;
        CGFloat width = [self getSizeWithString:navigationRightBarTitle withFontCustom:font].width;
        [self.navigationBar.rightButton setTitle:navigationRightBarTitle forState:UIControlStateNormal];
        self.navigationBar.rightButton.frame = CGRectMake(SCREEN_WIDTH-width-5, TM_StatusBarHeight, width, TM_TopBarHeight-TM_StatusBarHeight);
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarTitle), navigationRightBarTitle, OBJC_ASSOCIATION_RETAIN);
}
- (NSString*)navigationRightFirstBarTitle{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarTitle:(NSString *)navigationRightFirstBarTitle{
    if (navigationRightFirstBarTitle) {
        UIFont * font = self.navigationBar.rightFirstButton.titleLabel.font;
        CGFloat width = [self getSizeWithString:navigationRightFirstBarTitle withFontCustom:font].width;
        [self.navigationBar.rightFirstButton setTitle:navigationRightFirstBarTitle forState:UIControlStateNormal];
        self.navigationBar.rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-width-5 - 75, TM_StatusBarHeight, width, TM_TopBarHeight-TM_StatusBarHeight);
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarTitle), navigationRightFirstBarTitle, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor*)navigationRightFirstBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarTitleColor:(UIColor *)navigationRightFirstBarTitleColor{
    if (navigationRightFirstBarTitleColor) {
        [self.navigationBar.rightFirstButton setTitleColor:navigationRightFirstBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarTitleColor), navigationRightFirstBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor*)navigationRightBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarTitleColor:(UIColor *)navigationRightBarTitleColor{
    if (navigationRightBarTitleColor) {
        [self.navigationBar.rightButton setTitleColor:navigationRightBarTitleColor forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarTitleColor), navigationRightBarTitleColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage*)navigationRightFirstBarImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarImage:(UIImage *)navigationRightFirstBarImage{
    if (navigationRightFirstBarImage) {
        self.navigationBar.rightFirstButton.titleLabel.text = @"";
        [self.navigationBar.rightFirstButton setImage:navigationRightFirstBarImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarImage), navigationRightFirstBarImage, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage*)navigationRightBarImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightBarImage:(UIImage *)navigationRightBarImage{
    if (navigationRightBarImage) {
        self.navigationBar.rightButton.titleLabel.text = @"";
        [self.navigationBar.rightButton setImage:navigationRightBarImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarImage), navigationRightBarImage, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)title{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTitle:(NSString *)title{
    if (title && self.navigationBar ) {
        if ([self.navigationBar isKindOfClass:[TMNavigationBarView class]]) {
            [self.navigationBar setTitle:title];
        }
    }
    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_COPY);
}
- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor{
    if (navigationBarTitleColor) {
        self.navigationBar.myTitleColor = navigationBarTitleColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarTitleColor), navigationBarTitleColor, OBJC_ASSOCIATION_COPY);
    
}
- (UIColor*)navigationBarTitleColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor{
    if (navigationBarBackgroundColor) {
        self.navigationBar.myBackgroundColor = navigationBarBackgroundColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundColor), navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor*)navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage{
    if (navigationBarBackgroundImage) {
        self.navigationBar.myBackgroundImage = navigationBarBackgroundImage;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBackgroundImage), navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN);
}
- (UIImage*)navigationBarBackgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBarBottomLineBackgroundColor:(UIColor *)navigationBarBottomLineBackgroundColor{
    if (navigationBarBottomLineBackgroundColor) {
        self.navigationBar.myBottomLineColor = navigationBarBottomLineBackgroundColor;
    }
    objc_setAssociatedObject(self, @selector(navigationBarBottomLineBackgroundColor), navigationBarBottomLineBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor*)navigationBarBottomLineBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationBackButtonImage:(UIImage *)navigationBackButtonImage{
    if (navigationBackButtonImage) {
        [self.navigationBar.backButton setImage:navigationBackButtonImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self, @selector(navigationBackButtonImage), navigationBackButtonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage*)navigationBackButtonImage{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationRightBarRedButtonShow:(BOOL)navigationRightBarRedButtonShow{
    if (navigationRightBarRedButtonShow) {
        self.navigationBar.rightRedButton.hidden = NO;
    }else{
        self.navigationBar.rightRedButton.hidden = YES;
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarRedButtonShow), @(navigationRightBarRedButtonShow), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationRightBarRedButtonShow{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setNavigationGradientBackgroundFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor{
     NSLog(@"%@",self.navigationBar);
    self.navigationBar.gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
}
- (void)setNavigationBarAlpha:(CGFloat)alpha{
    for (UIView * view in self.navigationBar.subviews) {
        view.alpha = alpha;
    }
}
- (CGSize)getSizeWithString:(NSString*)string withFontCustom:(UIFont *)font{
    CGSize size = CGSizeMake(SCREEN_WIDTH/2, TM_TopBarHeight);
    font == nil ? [UIFont systemFontOfSize:18] :font;
    CGRect frame =[string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font}context:nil];
    return CGSizeMake(round(frame.size.width + 0.5), round(frame.size.height + 0.5));
}

@end
