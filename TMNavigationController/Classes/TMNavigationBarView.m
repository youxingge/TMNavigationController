//
//  TMNavigationBarView.m
//  TMNavigationController
//
//  Created by TianMing on 2018/8/27.
//  Copyright © 2018年 TianMing. All rights reserved.
//

#import "TMNavigationBarView.h"
#import <UIKit/UIKit.h>
#import "TMMacro.h"

@interface TMNavigationBarView()

@end

@implementation TMNavigationBarView

+ (CGFloat)getNavigationBarHeight {
    CGFloat navHeight = TM_TopBarHeight;
    BOOL isLandscapeMode = UIDevice.currentDevice.orientation == UIDeviceOrientationLandscapeLeft || UIDevice.currentDevice.orientation == UIDeviceOrientationLandscapeRight;
    if (isLandscapeMode) {
        if (TMNavigationConfig.shareInstance.landscapeModeNavigationBarHeight) {
            navHeight = TMNavigationConfig.shareInstance.landscapeModeNavigationBarHeight;
        } else {
            navHeight = TM_NavigationBarHeight + 20;
        }
    }
    return navHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
        [self configLayout];
        [self configAction];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_gradientLayer) {
        _gradientLayer.frame = self.bounds;
    }
    if (_backgroundImageView) {
        _backgroundImageView.frame = self.bounds;
    }
}

- (void)configView {
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    _backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:_backgroundImageView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    [self addSubview:_lineView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = UIColorFromRGB(0x27313e);
    UIFont *titleFont = [UIFont boldSystemFontOfSize:18.5];
    if ([TMNavigationConfig shareInstance].navigationBarTitleLabelFont) {
        titleFont = [TMNavigationConfig shareInstance].navigationBarTitleLabelFont;
    }
    _titleLabel.font = titleFont;
    [self addSubview:_titleLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.adjustsImageWhenHighlighted = NO;
    UIImage *backImage = [UIImage imageNamed:@"tm_back"];
    if ([TMNavigationConfig shareInstance].backButtonImage) {
        backImage = [TMNavigationConfig shareInstance].backButtonImage;
    }
    if (kIsRTL) {
        [_backButton setImage:backImage forState:UIControlStateNormal];
        _backButton.transform = CGAffineTransformMakeScale(-1 ,1);
    }else {
        [_backButton setImage:backImage forState:UIControlStateNormal];
    }
    [self addSubview:_backButton];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.adjustsImageWhenHighlighted = NO;
    [_leftButton setTitle:@"关闭" forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_leftButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.adjustsImageWhenHighlighted = NO;
    [_rightButton setTitle:@"" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [self addSubview:_rightButton];
    
    _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightFirstButton.adjustsImageWhenHighlighted = NO;
    [_rightFirstButton setTitle:@"" forState:UIControlStateNormal];
    _rightFirstButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightFirstButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [_rightFirstButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_rightFirstButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self addSubview:_rightFirstButton];
}

- (void)configLayout {
    // 1. 开启 Auto Layout (必须步骤)
    // 只有将此属性设为 NO，手动添加的约束才会生效
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _backButton.translatesAutoresizingMaskIntoConstraints = NO;
    _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    _rightFirstButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *constraintArray = @[
        
        // --- 背景图 (铺满整个 View) ---
        [_backgroundImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_backgroundImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_backgroundImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [_backgroundImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        
        // --- 底部线条 (高度 0.5，贴底) ---
        [_lineView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [_lineView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [_lineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_lineView.heightAnchor constraintEqualToConstant:0.5],
        
        // --- 返回按钮 (_backButton) ---
        // 位置：最前侧 (LTR为左, RTL为右)
        // 使用 safeAreaLayoutGuide 避免横屏被刘海遮挡
        [_backButton.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor],
        [_backButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_backButton.widthAnchor constraintEqualToConstant:55],
        [_backButton.heightAnchor constraintEqualToConstant:ButtonViewHeight],
        
        // --- 关闭按钮 (_leftButton) ---
        // 位置：紧接在返回按钮之后
        [_leftButton.leadingAnchor constraintEqualToAnchor:_backButton.trailingAnchor],
        [_leftButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_leftButton.widthAnchor constraintEqualToConstant:50],
        [_leftButton.heightAnchor constraintEqualToConstant:ButtonViewHeight],
        
        // --- 最右侧按钮 (_rightButton) ---
        // 位置：最后侧 (LTR为右, RTL为左)
        [_rightButton.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-6],
        [_rightButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_rightButton.widthAnchor constraintEqualToConstant:55],
        [_rightButton.heightAnchor constraintEqualToConstant:ButtonViewHeight],
        
        // --- 右侧第二个按钮 (_rightFirstButton) ---
        // 位置：在 _rightButton 的内侧
        [_rightFirstButton.trailingAnchor constraintEqualToAnchor:_rightButton.leadingAnchor],
        [_rightFirstButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_rightFirstButton.widthAnchor constraintEqualToConstant:54],
        [_rightFirstButton.heightAnchor constraintEqualToConstant:ButtonViewHeight],
        
        // --- 标题 (_titleLabel) ---
        // 位置：绝对居中
        [_titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [_titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [_titleLabel.heightAnchor constraintEqualToConstant:ButtonViewHeight],
        // 限制最大宽度：确保标题太长时不会遮挡左右两边的按钮
        // 左边距 >= 90 (参考原代码)
        [_titleLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:90],
        // 右边距 <= -90
        [_titleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-90]
    ];
    
    // 2. 激活约束
    // 使用 activateConstraints 批量激活，代码更整洁，性能更好
    [NSLayoutConstraint activateConstraints:constraintArray];
    [self layoutIfNeeded];
}

- (void)configAction {
    [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightFirstButton addTarget:self action:@selector(rightFirstAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backLastView:(UIButton*)button{
    if (self.click) {
        self.click(button);
    }
}
- (void)closeAction:(UIButton*)button{
    if (self.leftClick) {
        self.leftClick(button);
    }
}
- (void)rightAction:(UIButton*)button{
    if (self.rightClick) {
        self.rightClick(button);
    }
}
- (void)rightFirstAction:(UIButton*)button{
    if (self.rightFirstClick) {
        self.rightFirstClick(button);
    }
}
- (void)clickBackButton:(clickBackButton)block{
    self.click = [block copy];
}
- (void)clickLeftButton:(clickBackButton)block{
    self.leftClick = [block copy];
}
- (void)clickRightButton:(clickRightButton)block{
    self.rightClick = [block copy];
}
- (void)clickRightFirstButton:(clickRightFirstButton)block{
    self.rightFirstClick  = [block copy];
}
- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    _gradientLayer = gradientLayer;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    if (!title) {
        _titleLabel.text = @"";
        return;
    }
    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }
    _titleLabel.text = title;
}
- (void)setMyBackgroundColor:(UIColor *)myBackgroundColor{
    _myBackgroundColor = myBackgroundColor;
    if (!myBackgroundColor) {
        _backgroundImageView.backgroundColor = [UIColor clearColor];
    }else{
        _backgroundImageView.backgroundColor = myBackgroundColor;
    }
}
- (void)setMyBackgroundImage:(UIImage *)myBackgroundImage{
    _myBackgroundImage = myBackgroundImage;
    if (!myBackgroundImage) {
        _backgroundImageView.backgroundColor = [UIColor clearColor];
    }else{
        _backgroundImageView.image = myBackgroundImage;
    }
}
- (void)setMyTitleColor:(UIColor *)myTitleColor{
    _myTitleColor = myTitleColor;
    if (myTitleColor) {
        _titleLabel.textColor = myTitleColor;
    }
}
- (void)setMyBottomLineColor:(UIColor *)myBottomLineColor{
    _myBottomLineColor = myBottomLineColor;
    if (myBottomLineColor) {
        _lineView.backgroundColor = myBottomLineColor;
    }else{
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    }
}


@end


