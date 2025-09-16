#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TMMacro.h"
#import "TMNavigationBarView.h"
#import "TMNavigationConfig.h"
#import "TMNavigationController.h"
#import "UIViewController+TMNavigationBarView.h"

FOUNDATION_EXPORT double TMNavigationControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char TMNavigationControllerVersionString[];

