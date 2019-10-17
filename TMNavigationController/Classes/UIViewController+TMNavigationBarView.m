//
//  UIViewController+TMNavigationBarView.m
//  TMNavigationController
//
//  Created by TianMing on 2019/2/22.
//  Copyright © 2019 TianMing. All rights reserved.
//

#import "UIViewController+TMNavigationBarView.h"
#import "TMNavigationController.h"

@implementation UIViewController (TMNavigationBarView)

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
    
    if ([self.navigationController isKindOfClass:[TMNavigationController class]]) {
        TMNavigationController * nav = (TMNavigationController*)self.navigationController;
        if (nav && [nav isKindOfClass:TMNavigationController.class]) {
            if (nav.panGesture) {
                if (!navigationCanDragBack ) {
                    // 禁用返回手势
                    nav.panGesture.enabled = NO;
                }else{
                    nav.panGesture.enabled = YES;
                }
            }
        }
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
        [self.navigationBar.titleLabel setFrame:CGRectMake(45, TM_StatusBarHeight, SCREEN_WIDTH - 90, 44)];
    }else{
        self.navigationBar.leftButton.hidden = NO;
        [self.navigationBar.leftButton setFrame:CGRectMake(45, TM_StatusBarHeight, 45, TM_TopBarHeight-TM_StatusBarHeight)];
        [self.navigationBar.titleLabel setFrame:CGRectMake(80, TM_StatusBarHeight, SCREEN_WIDTH - 80*2, 44)];
        self.navigationBar.backButton.frame = CGRectMake(0, TM_StatusBarHeight, 45, TM_TopBarHeight-TM_StatusBarHeight);
        [self.navigationBar.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    objc_setAssociatedObject(self, @selector(navigationLeftBarHidden), @(navigationLeftBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)navigationLeftBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
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
        self.navigationBar.rightButton.frame = CGRectMake(SCREEN_WIDTH-50, TM_StatusBarHeight, 50, TM_TopBarHeight-TM_StatusBarHeight);
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
        self.navigationBar.rightButton.frame = CGRectMake(SCREEN_WIDTH-width-10, TM_StatusBarHeight, width+5, TM_TopBarHeight-TM_StatusBarHeight);
        [self.navigationBar.rightButton setTitle:navigationRightBarTitle forState:UIControlStateNormal];
        CGFloat rightFirstButtonWidth = 0;
        if (self.navigationBar.rightFirstButton.hidden==NO) {
            rightFirstButtonWidth = [self getSizeWithString:self.navigationBar.rightFirstButton.titleLabel.text withFontCustom:[UIFont systemFontOfSize:16]].width;
            self.navigationBar.rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-rightFirstButtonWidth-width-15, TM_StatusBarHeight, rightFirstButtonWidth+5, TM_TopBarHeight-TM_StatusBarHeight);
        }else{
            [self.navigationBar.titleLabel setFrame:CGRectMake(width+10, TM_StatusBarHeight, SCREEN_WIDTH - (width+10)*2, 44)];
        }
    }
    objc_setAssociatedObject(self, @selector(navigationRightBarTitle), navigationRightBarTitle, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)navigationRightFirstBarHidden{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationRightFirstBarHidden:(BOOL)navigationRightFirstBarHidden{
    if (navigationRightFirstBarHidden) {
        self.navigationBar.rightFirstButton.hidden = YES;
        if (self.navigationLeftBarHidden) {
            [self.navigationBar.titleLabel setFrame:CGRectMake(45, TM_StatusBarHeight, SCREEN_WIDTH - 90, 44)];
        }else{
            [self.navigationBar.titleLabel setFrame:CGRectMake(80, TM_StatusBarHeight, SCREEN_WIDTH - 80*2, 44)];
        }
    }else{
        self.navigationBar.rightFirstButton.hidden = NO;
        if (self.navigationLeftBarHidden) {
            [self.navigationBar.titleLabel setFrame:CGRectMake(45, TM_StatusBarHeight, SCREEN_WIDTH - 100-50, 44)];
        }else{
            [self.navigationBar.titleLabel setFrame:CGRectMake(90, TM_StatusBarHeight, SCREEN_WIDTH - 90*2, 44)];
        }
    }
    objc_setAssociatedObject(self, @selector(navigationRightFirstBarHidden), @(navigationRightFirstBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (NSString*)navigationRightFirstBarTitle{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationRightFirstBarTitle:(NSString *)navigationRightFirstBarTitle{
    if (navigationRightFirstBarTitle) {
        UIFont * font = self.navigationBar.rightFirstButton.titleLabel.font;
        CGFloat width = [self getSizeWithString:navigationRightFirstBarTitle withFontCustom:font].width;
        CGFloat rightFirst = 0;
        if (self.navigationBar.rightButton.titleLabel.text.length==0) {
            rightFirst = 40;
        }
        self.navigationBar.rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-rightFirst-width-10, TM_StatusBarHeight, width+5, TM_TopBarHeight-TM_StatusBarHeight);
        [self.navigationBar.rightFirstButton setTitle:navigationRightFirstBarTitle forState:UIControlStateNormal];
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

- (void)navigationBackButtonClickBlock:(void (^)(UIButton* button))block{
    if (self.navigationBar) {
        self.navigationBar.click = [block copy];
    }
}
- (void)navigationLeftButtonClickBlock:(void (^)(UIButton* button))block{
    if (self.navigationBar) {
        self.navigationBar.leftClick = [block copy];
    }
}
- (void)navigationRightButtonClickBlock:(void (^)(UIButton* button))block{
    if (self.navigationBar) {
        self.navigationBar.rightClick = [block copy];
    }
}
- (void)navigationRightFirstButtonClickBlock:(void (^)(UIButton* button))block{
    if (self.navigationBar) {
        self.navigationBar.rightFirstClick = [block copy];
    }
}

@end
