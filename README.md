# YPSegmentController

[![CI Status](http://img.shields.io/travis/MichaelHuyp/YPSegmentController.svg?style=flat)](https://travis-ci.org/MichaelHuyp/YPSegmentController)
[![Version](https://img.shields.io/cocoapods/v/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)
[![License](https://img.shields.io/cocoapods/l/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)
[![Platform](https://img.shields.io/cocoapods/p/YPSegmentController.svg?style=flat)](http://cocoapods.org/pods/YPSegmentController)

## Example

<img src="https://lh3.googleusercontent.com/kiRHV5ygynMxK1vN3ncNKq_CU4tNLWwJtKxsV0T8NdMv7HMrn0IWLLmpsULD1-qH214R_nhH8AA7uhciid4YZ_MEpDcYfaNPQPRzYP1XIZRZnCKs8Si6768Z7471zi-AW-dZpflYL9-gP01ocgKQEKQl32ueVs2DocNgd0ea3jLihq_k6kK4SoJrJz5JztYtp69H0_DVZmu7WTFfCOt0y-WZXA_I62fKf5WRdYRYxL03z_-gcY0SqZD7AXDi6dG6naV18tM7RmftX0sQzf-1TCpzB2VbGiY1tNrNs_LaqUPn032of9JGmFLuotKnJRy-0-Icb-63-1qyuFHCsNncdWbF_cj--XE81W0l0mbUee5VMK1t131WC702Z57l-xw2ezhHLt0LPzFdIPHEXK5YR8kcyI6F34aPc17W7lFq3rJF45_q0eft5ghDtTePgOK59PcgfcSi61SiS2t9rUeRgzfVuVCfWwZdA0dGzdyXKHz9yS962ilpf2r28454W-CG6DxhAI5PFijz8V4HiyexkpCk-95tOfrkz9qYZ3M46EKwtkL8xb_NNUV-9jv1VGRGJYlNtq1kzILf7UZDnyU-0kDlEQEIeddZI-5WAEixsLJkVr7zNW0=w1066-h680-no">


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

````objc
#import "YPViewController.h"
#import "YPSegmentController.h"
#import "UIView+YPSegment.h"

#define YPColor_RGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define YPRandomColor_RGB YPColor_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface YPViewController ()

@property (nonatomic, weak) YPSegmentController *segmentController;


@end

@implementation YPViewController

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

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"2016互联网十强企业";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.segmentController.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentController.view];
    
    
    [self.segmentController.segmentBar updateWithConfig:^(YPSegmentBarConfig *config) {
        config.itemTitleNormalColor = [UIColor blueColor];
        config.itemTitleSelectColor = [UIColor redColor];
    }];
    
    self.segmentController.segmentBar.enableTitleGradient = YES;
    self.segmentController.segmentBar.linkMode = YPSegmentBarLinkModeProgress;
    self.segmentController.segmentBar.scrollMode = YPSegmentBarScrollModeCenter;
    
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
    
    UIViewController *vc10 = [UIViewController new];
    vc10.title = @"美团-大众点评";
    vc10.view.backgroundColor = YPRandomColor_RGB;
    
    [self.segmentController setUpWithItems:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10]];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    [self.segmentController updateWithConfig:^(YPSegmentControllerConfig *config) {
        config.segmentBarTop = self.navigationController.navigationBar.bottom;
    }];
}
````

````objc

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
@property (nonatomic, assign) BOOL enableTitleGradient;

/**
 *  配置Bar的各种参数
 */
- (void)updateWithConfig:(void(^)(YPSegmentBarConfig *config))block;

@end

@protocol YPSegmentBarDelegate <NSObject>

- (void)segmentBar:(YPSegmentBar *)segmentBar didSelectedIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

````

````objc

@interface YPSegmentController : UIViewController

/** 选项条 */
@property (nonatomic, weak) YPSegmentBar *segmentBar;

/** 
 *  设置数据源
 */
- (void)setUpWithItems:(NSArray <UIViewController *>*)items;

/**
 *  修改基本配置
 */
- (void)updateWithConfig:(void(^)(YPSegmentControllerConfig *config))block;


@end

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


