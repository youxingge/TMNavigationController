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
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TM_TopBarHeight)];
    if (self) {
        
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.frame = self.frame;
        [self.layer addSublayer:gradientLayer];
        self.gradientLayer = gradientLayer;
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_backgroundImageView];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0,frame.size.height-0.5,frame.size.width,0.5)];
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        [self addSubview:_lineView];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.adjustsImageWhenHighlighted = NO;
        [_backButton setImage:[UIImage imageNamed:@"tm_back"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(0, TM_StatusBarHeight-10, 62, 50);
        [_backButton addTarget:self action:@selector(backLastView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.adjustsImageWhenHighlighted = NO;
        [_leftButton setTitle:@"关闭" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _leftButton.frame = CGRectMake(46, TM_StatusBarHeight, 50, TM_TopBarHeight-TM_StatusBarHeight);
        [_leftButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
        [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_leftButton];
        
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.adjustsImageWhenHighlighted = NO;
        [_rightButton setTitle:@"" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightButton.frame = CGRectMake(SCREEN_WIDTH-70, TM_StatusBarHeight, 54, TM_TopBarHeight-TM_StatusBarHeight);
        [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
//        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//        [_rightButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_rightButton];
        
        _rightRedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightRedButton.frame = CGRectMake(_rightButton.frame.origin.x + _rightButton.frame.size.width, _rightButton.frame.origin.y+6, 8, 8);
        _rightRedButton.backgroundColor = [UIColor redColor];
        [self addSubview:_rightRedButton];
        _rightRedButton.layer.cornerRadius = 4;
        _rightRedButton.layer.masksToBounds = YES;
        
        _rightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightFirstButton.adjustsImageWhenHighlighted = NO;
        [_rightFirstButton setTitle:@"" forState:UIControlStateNormal];
        _rightFirstButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _rightFirstButton.frame = CGRectMake(SCREEN_WIDTH-70- 44, TM_StatusBarHeight, 54, TM_TopBarHeight-TM_StatusBarHeight);
        [_rightFirstButton addTarget:self action:@selector(rightFirstAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightFirstButton setTitleColor:UIColorFromRGB(0x27313e) forState:UIControlStateNormal];
        [_rightFirstButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rightFirstButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self addSubview:_rightFirstButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, TM_StatusBarHeight, SCREEN_WIDTH - 90*2, 44)];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorFromRGB(0x27313e);
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.5];
        [self addSubview:_titleLabel];
        
    }
    return self;
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
    self.click = block;
}
- (void)clickLeftButton:(clickBackButton)block{
    self.leftClick = block;
}
- (void)clickRightButton:(clickRightButton)block{
    self.rightClick = block;
}
- (void)clickRightFirstButton:(clickRightFirstButton)block{
    self.rightFirstClick  = block;
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

