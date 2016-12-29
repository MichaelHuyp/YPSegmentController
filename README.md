# YPSegmentController

[![CI Status](http://img.shields.io/travis/MichaelHuyp/YPSegmentController.svg?style=flat)](https://travis-ci.org/MichaelHuyp/YPSegmentController)
[![Version](https://img.shields.io/cocoapods/v/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)
[![License](https://img.shields.io/cocoapods/l/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)
[![Platform](https://img.shields.io/cocoapods/p/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)

## Example

![demo1](https://lh3.googleusercontent.com/KeWqSD0cMc6MRT1o30Ao4vjlKEAsNGpnh0XW_B-3Yr9nhBMfqHkNVzjIYk5J9tOORUVG6N21AWVtZyoJB8a-M22YJX0jtVgYikCECe1Z-kQOy524yyjisk82Nh7Z23LqYNuppla8D1LskPAIRSext52SxNMMoAvfrXrfNDOgCKBHFdIr5z8bDkGvQfNw890RI1NgXA00hH96oHxA8Wb6VysFDFADuTnZZAV2PTVm539YzvWqUN81iqL356sI2sdtGJW2lFOf15Z_HmHPF3V9SE3cg48A4PIDvk9TorujO7_BSRMOmdLJhl4qjIY9-BgshJJRe-Gh6fMyilHW84oz1EVqJgtKfjCBNlYvyPiBHS67le-R5DWwHZiQC8EHfQ6h8_YhVzFOzBiMtczmt-epDeb5Ppv90zTshlYALM0nMziDoOCSkcFAgrV_pUbgrTdobekbzOYRl2wjZ6kknvGzn0ESLVNMp70cLXv1nQOhoEFK-1HrmvJVTMe-s5DI8K6nvuScnJ46y6sWy6x7kRdnwJViEWvbM0KZpeDuY0tgeCBk1wlxPG3lQPSlaucGzvQoVGoaYXSLFe1b7q7cFXsppr2OaOkCmFc57ZSPz1yUvN9tIsjZADU=w990-h693-no)

目前完成功能:
1.滑动模式 Normal
2.滑动模式 Center
3.颜色渐变
4.文字大小渐变
5.滑动进度模式Progress

### 使用说明书

#### 最简单的集成方式
- 1.首先引入`YPSegmentController.h`头文件
- 2.将segmentController作为weak属性
- 3.将segmentController作为当前控制器的子控制器
- 4.将segmentController的view加到当前控制器的子视图
- 5.创建若干子控制器,调用-[YPSegmentController setUpWithItems:]方法添加.

````objc
#import "ViewController.h"
#import "YPSegmentController.h"
#import "UIView+YPSegment.h"
#import "YPMeituanDemoViewController.h"

#define YPColor_RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define YPRandomColor_RGB YPColor_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()

@property (nonatomic, weak) YPSegmentController *segmentController;

@end

@implementation ViewController

#pragma mark - Lazy

- (YPSegmentController *)segmentController
{
    if (!_segmentController) {
        YPSegmentController *vc = [YPSegmentController new];
        [self addChildViewController:vc];
        _segmentController = vc;
    }
    return _segmentController;
}

#pragma mark - Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"2016互联网十强企业";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentController.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentController.view];
    
    UIViewController *vc1 = [UIViewController new];
    vc1.title = @"腾讯";
    vc1.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc2 = [UIViewController new];
    vc2.title = @"阿里巴巴";
    vc2.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc3 = [UIViewController new];
    vc3.title = @"蚂蚁金服";
    vc3.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc4 = [UIViewController new];
    vc4.title = @"百度";
    vc4.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc5 = [UIViewController new];
    vc5.title = @"京东";
    vc5.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc6 = [UIViewController new];
    vc6.title = @"网易";
    vc6.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc7 = [UIViewController new];
    vc7.title = @"小米科技";
    vc7.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc8 = [UIViewController new];
    vc8.title = @"滴滴出行";
    vc8.view.backgroundColor = YPRandomColor_RGB;
    UIViewController *vc9 = [UIViewController new];
    vc9.title = @"陆金所";
    vc9.view.backgroundColor = YPRandomColor_RGB;
    YPMeituanDemoViewController *vc10 = [YPMeituanDemoViewController new];
    vc10.title = @"美团-大众点评";
    
    
    [self.segmentController setUpWithItems:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10]];

}

@end


````



````objc
@property (nonatomic, weak) YPSegmentController *segmentController;
````

### YPSegmentBar.h

````objc

#import <UIKit/UIKit.h>
#import "YPSegmentBarConfig.h"


typedef NS_ENUM(NSInteger, YPSegmentBarScrollMode) {
    YPSegmentBarScrollModeNormal, // 默认滚动模式
    YPSegmentBarScrollModeCenter  // 中间滚动模式
};

typedef NS_ENUM(NSInteger, YPSegmentBarLinkMode) {
    YPSegmentBarLinkModeNormal, // 默认联动模式
    YPSegmentBarLinkModeProgress  // 根据进度的联动模式
};

@protocol YPSegmentBarDelegate;

@interface YPSegmentBar : UIView


/** 数据源 */
@property (nonatomic, copy) NSArray <NSString *> *items;

/** 代理 */
@property (nonatomic, weak) id <YPSegmentBarDelegate> delegate;

/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;

/** 滚动模式 */
@property (nonatomic, assign) YPSegmentBarScrollMode scrollMode;

/** 联动模式 */
@property (nonatomic, assign) YPSegmentBarLinkMode linkMode;

/** 指示器进度 */
@property (nonatomic, assign) CGFloat indicatorProgress;

/** 是否开启标题颜色渐变 默认为No */
@property (nonatomic, assign) BOOL enableTitleColorGradient;

/** 是否开启标题大小渐变 默认为No */
@property (nonatomic, assign) BOOL enableTitleSizeGradient;

/**
 *  配置Bar的各种参数
 */
- (void)updateWithConfig:(void(^)(YPSegmentBarConfig *config))block;

@end

@protocol YPSegmentBarDelegate <NSObject>

- (void)segmentBar:(YPSegmentBar *)segmentBar didSelectedIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

UIKIT_EXTERN NSString * const YPSegmentBarSelectionDidChangeNotification;

````

### YPSegmentController.h

````objc

#import <UIKit/UIKit.h>
#import "YPSegmentBar.h"
#import "YPSegmentControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPSegmentController : UIViewController

/** 选项条 */
@property (nonatomic, weak) YPSegmentBar *segmentBar;

/** 是否开启预加载功能 */
@property (nonatomic, assign) BOOL prefetchingEnabled;

/** 背景View */
@property (nonatomic, weak) UIView *backgroundView;

/** 
 *  设置数据源
 */
- (void)setUpWithItems:(NSArray <UIViewController *>*)items;

/**
 *  修改基本配置
 */
- (void)updateWithConfig:(void(^)(YPSegmentControllerConfig *config))block;


@end

@interface UIViewController (YPSegmentControllerItem)

@property(nullable, nonatomic,readonly,strong) YPSegmentController *segmentController;

@end

NS_ASSUME_NONNULL_END

````

## Requirements

## Installation

YPSegmentController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YPSegmentController"
```

## Author

MichaelHuyp, 86812684@qq.com

## License

YPSegmentController is available under the MIT license. See the LICENSE file for more info.


