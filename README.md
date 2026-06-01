# TMNavigationController

[![CI Status](https://img.shields.io/travis/youingge/TMNavigationController.svg?style=flat)](https://travis-ci.org/youingge/TMNavigationController)
[![Version](https://img.shields.io/cocoapods/v/TMNavigationController.svg?style=flat)](https://cocoapods.org/pods/TMNavigationController)
[![License](https://img.shields.io/cocoapods/l/TMNavigationController.svg?style=flat)](https://cocoapods.org/pods/TMNavigationController)
[![Platform](https://img.shields.io/cocoapods/p/TMNavigationController.svg?style=flat)](https://cocoapods.org/pods/TMNavigationController)

史上最好用的自定义导航栏。基于 `UINavigationController` 封装，提供一个完全自定义的 `TMNavigationBarView`，
通过 `UIViewController` 分类暴露所有导航栏配置能力，并内置全屏滑动返回 / 侧滑返回手势。

## 特性

- **完全自定义导航栏**：每个页面拥有独立的 `TMNavigationBarView`，不依赖系统 `UINavigationBar`，可随意定制背景、标题、按钮、底部分割线。
- **全屏滑动返回**：默认开启全屏拖拽返回；也可切换为系统风格的左侧边缘侧滑返回。
- **分类式配置**：通过 `UIViewController (TMNavigationBarView)` 分类，用属性直接配置标题、颜色、左右按钮、返回按钮等，无需继承基类。
- **渐变背景 / 透明度**：支持导航栏渐变色与整体透明度调节，便于做沉浸式头图、滚动渐显效果。
- **左右多按钮**：支持返回按钮、左按钮、右按钮、右第二按钮，按钮均可设置文字 / 图片 / 颜色 / 点击回调。
- **RTL 适配**：内置阿拉伯语等从右到左布局适配，可全局配置布局方向。
- **全局配置**：通过 `TMNavigationConfig` 单例统一配置返回按钮图片、默认手势模式、布局方向等。

## 安装

TMNavigationController 通过 [CocoaPods](https://cocoapods.org) 发布。在 Podfile 中加入：

```ruby
pod 'TMNavigationController'
```

然后执行 `pod install`。

## 快速开始

将根控制器包进 `TMNavigationController` 即可：

```objc
#import <TMNavigationController/TMNavigationController.h>

YourViewController *root = [[YourViewController alloc] init];
TMNavigationController *nav = [[TMNavigationController alloc] initWithRootViewController:root];
self.window.rootViewController = nav;
```

push / pop 与系统用法一致：

```objc
[self.navigationController pushViewController:detailVC animated:YES];
[self.navigationController popViewControllerAnimated:YES];
```

## 导航栏配置（UIViewController 分类）

引入 Pod 后，任意 `UIViewController` 都能直接使用以下属性 / 方法配置自己的导航栏：

### 标题与背景

```objc
self.title = @"商品详情";                                   // 标题文字
self.navigationBarTitleColor = UIColor.whiteColor;          // 标题颜色
self.navigationBarBackgroundColor = UIColorFromRGB(0xEC654A);// 背景色
self.navigationBarBackgroundImage = [UIImage imageNamed:@"bar_bg"]; // 背景图
self.navigationBarBottomLineBackgroundColor = UIColor.clearColor;   // 底部分割线颜色

// 渐变背景
[self setNavigationGradientBackgroundFromColor:startColor toColor:endColor];
// 整体透明度（常用于滚动渐显）
[self setNavigationBarAlpha:0.5];
```

### 显示 / 隐藏导航栏

```objc
self.navigationBarHidden = YES;   // 隐藏整个自定义导航栏
```

### 返回按钮

```objc
self.navigationBackBarHidden = NO;                          // 显示 / 隐藏返回按钮
self.navigationBackButtonImage = [UIImage imageNamed:@"back"];// 自定义返回按钮图片

// 自定义返回点击（默认行为是 pop）
[self navigationBackButtonClickBlock:^(UIButton *button) {
    // 自定义返回逻辑
}];
```

### 左侧按钮

```objc
self.navigationLeftBarHidden = NO;                          // 显示 / 隐藏左按钮
self.navigationLeftBarTitle = @"取消";                       // 左按钮文字
self.navigationLeftBarTitleColor = UIColor.whiteColor;      // 左按钮文字颜色

[self navigationLeftButtonClickBlock:^(UIButton *button) {
    // 左按钮点击
}];
```

### 右侧按钮（支持两个）

```objc
// 右侧第一个按钮
self.navigationRightBarHidden = NO;
self.navigationRightBarImage = [UIImage imageNamed:@"share"]; // 或用文字
self.navigationRightBarTitle = @"分享";
self.navigationRightBarTitleColor = UIColor.whiteColor;
[self navigationRightButtonClickBlock:^(UIButton *button) {
    // 右按钮点击
}];

// 右侧第二个按钮
self.navigationRightFirstBarHidden = NO;
self.navigationRightFirstBarImage = [UIImage imageNamed:@"more"];
self.navigationRightFirstBarTitle = @"更多";
self.navigationRightFirstBarTitleColor = UIColor.whiteColor;
[self navigationRightFirstButtonClickBlock:^(UIButton *button) {
    // 右第二按钮点击
}];
```

## 返回手势

默认开启**全屏拖拽返回**。可按页面或全局控制：

```objc
// 单页面：是否允许全屏拖拽返回（关闭后该页无任何返回手势）
self.navigationCanDragBack = NO;

// 单页面：切换为左侧边缘 50pt 内侧滑返回（开启侧滑则不再全屏拖拽）
self.navigationCanSideslipBack = YES;
```

## 全局配置（TMNavigationConfig）

```objc
#import <TMNavigationController/TMNavigationConfig.h>

TMNavigationConfig *config = [TMNavigationConfig shareInstance];

// 全局统一返回按钮图片
config.backButtonImage = [UIImage imageNamed:@"global_back"];

// 全局强制使用侧滑返回（而非全屏拖拽）
config.forceSideslipGesture = YES;

// 切换语言时配置布局方向（RTL 适配）
config.layoutDirection = TMInterfaceLayoutDirectionRightToLeft;
```

工具方法：

```objc
UIEdgeInsets safeInsets = [TMNavigationConfig tm_safeAreaInsets]; // 安全区域
UIWindow *keyWindow      = [TMNavigationConfig tm_getKeyWindow];   // keyWindow
BOOL isRTL               = [[TMNavigationConfig shareInstance] getIsRTL]; // 是否 RTL
```

## 更新日志

### 0.2.2
- **修复 iOS 26 下页面无法 push 跳转的问题**：旧版 `pushViewController:animated:` 的防重复机制无论是否真正执行 push 都会置位 `shouldIgnorePushingViewControllers` 标志，依赖 `didShowViewController:` 回调复位。iOS 26 上该回调时机变化导致标志无法复位，后续 push 被静默忽略。新版仅在真正执行 push 后才置位标志，并移除了原有 iPad iOS 26 的特殊分支。

### 0.2.1
- 历史版本。

## 系统要求

- iOS 10.0+

## Author

youingge, 206678264@qq.com

## License

TMNavigationController is available under the MIT license. See the LICENSE file for more info.
