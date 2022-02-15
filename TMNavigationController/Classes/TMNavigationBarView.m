//
//  TMNavigationBarView.m
//  TMNavigationController
//
//  Created by TianMing on 2018/8/27.
//  Copyright © 2018年 TianMing. All rights reserved.
//

#import "TMNavigationBarView.h"
#import "Macro.h"

@interface  TMNavigationBarView()

@end

@implementation TMNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TM_TopBarHeight)];
    if (self) {
        [self configView];
    }
    return self;
}
- (void)configView {
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = self.frame;
    [self.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:_backgroundImageView];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,self.bounds.size.height-0.5,self.bounds.size.width,0.5)];
    _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    [self addSubview:_lineView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, TM_StatusBarHeight, SCREEN_WIDTH - 90*2, ButtonViewHeight)];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = UIColorFromRGB(0x27313e);
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.5];
    [self addSubview:_titleLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.adjustsImageWhenHighlighted = NO;
    if (kIsRTL) {
        _backButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        UIImage *image = [[UIImage imageNamed:@"tm_back"] imageFlippedForRightToLeftLayoutDirection] ;
        [_backButton setImage:image forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(SCREEN_WIDTH - 55, TM_StatusBarHeight, 55, ButtonViewHeight);
    }else {
        [_backButton setImage:[UIImage imageNamed:@"tm_back"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(0, TM_StatusBarHeight, 55, ButtonViewHeight);
    }
    [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.adjustsImageWhenHighlighted = NO;
    [_leftButton setTitle:@"关闭" forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if (kIsRTL) {
        _leftButton.frame = CGRectMake(50, TM_StatusBarHeight, 50, ButtonViewHeight);
    }else {
        _leftButton.frame = CGRectMake(50, TM_StatusBarHeight, 50, ButtonViewHeight);
    }
    [_leftButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.adjustsImageWhenHighlighted = NO;
    [_rightButton setTitle:@"" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if (kIsRTL) {
        _rightButton.frame = CGRectMake(5, TM_StatusBarHeight, 55, ButtonViewHeight);
    }else {
        _rightButton.frame = CGRectMake(SCREEN_WIDTH-70, TM_StatusBarHeight, 55, ButtonViewHeight);
    }
    [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [self addSubview:_rightButton];
    
    _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightFirstButton.adjustsImageWhenHighlighted = NO;
    [_rightFirstButton setTitle:@"" forState:UIControlStateNormal];
    _rightFirstButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if (kIsRTL) {
        _rightFirstButton.frame = CGRectMake(70 , TM_StatusBarHeight, 54, ButtonViewHeight);
    }else {
        _rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-70- 44, TM_StatusBarHeight, 54, ButtonViewHeight);
    }
    [_rightFirstButton addTarget:self action:@selector(rightFirstAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightFirstButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
    [_rightFirstButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_rightFirstButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self addSubview:_rightFirstButton];
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
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _titleLabel.text = title;
    [self setNeedsDisplay];
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

