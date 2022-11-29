//
//  TMNavigationConfig.m
//  TMNavigationController
//
//  Created by TianMing on 2022/11/29.
//  Copyright © 2022 TianMing. All rights reserved.
//

#import "TMNavigationConfig.h"

@implementation TMNavigationConfig

static TMNavigationConfig *_service = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        if (_service == nil) {
            _service = [[super allocWithZone:NULL] init];
        }
    });
    return _service;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [TMNavigationConfig shareInstance];
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)getIsRTL {
    TMInterfaceLayoutDirection hasRTL = [TMNavigationConfig shareInstance].layoutDirection;
    if (hasRTL) {
        if (hasRTL == TMInterfaceLayoutDirectionRightToLeft) {
            return YES;
        }
        return NO;
    }
    return [UIApplication sharedApplication].userInterfaceLayoutDirection;
}


@end
