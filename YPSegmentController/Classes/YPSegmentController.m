//
//  YPSegmentController.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/2.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YPSegmentController.h"
#import "UIView+YPSegment.h"


@interface YPSegmentController () <YPSegmentBarDelegate, UIScrollViewDelegate>

/** 内容视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 基本配置 */
@property (nonatomic, strong) YPSegmentControllerConfig *config;

@end

@implementation YPSegmentController

#pragma mark - Public
- (void)setUpWithItems: (NSArray <UIViewController *>*)items
{
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    NSMutableArray *titleItems = [NSMutableArray array];
    for (UIViewController *vc in items) {
        [self addChildViewController:vc];
        [titleItems addObject:vc.title];
    }
    
    self.segmentBar.items = titleItems;
    self.contentView.backgroundColor = [UIColor grayColor];
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
}


- (void)updateWithConfig:(void(^)(YPSegmentControllerConfig *config))block
{
    if (block) block(self.config);
    
    self.segmentBar.top = self.config.segmentBarTop;
    self.segmentBar.height = self.config.segmentBarHeight;
    
    // 刷新布局
    [self.segmentBar setNeedsLayout];
    [self.segmentBar layoutIfNeeded];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    if ([self.segmentBar.superview isKindOfClass:[UINavigationBar class]]) {
        self.segmentBar.frame = CGRectMake(0, 0, self.navigationController.navigationBar.width, self.navigationController.navigationBar.height);
        self.contentView.frame = CGRectMake(self.navigationController.navigationBar.left, self.navigationController.navigationBar.bottom, self.view.width, self.view.height - self.navigationController.navigationBar.bottom);
    } else {
        self.segmentBar.frame = CGRectMake(self.config.segmentBarLeft, self.config.segmentBarTop, self.config.segmentBarWidth, self.config.segmentBarHeight);
        self.contentView.frame = CGRectMake(0, self.segmentBar.bottom, self.view.width, self.view.height - self.segmentBar.bottom);
    }

    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
    

}

#pragma mark - Private
- (void)addChildVcViewToIndex:(NSInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    childVc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:childVc.view];
}

- (void)showChildVCViewsAtIndex:(NSInteger)index
{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) return;
    
    [self addChildVcViewToIndex:index];
    
    // 滚动到对应位置
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:NO];
    
    // 是否开启预加载功能
    if (!self.prefetchingEnabled) return;
    
    // 添加左右视图
    NSInteger leftIndex = index - 1;
    NSInteger rightIndex = index + 1;
    if (leftIndex >= 0) [self addChildVcViewToIndex:leftIndex];
    if (rightIndex <= self.childViewControllers.count - 1) [self addChildVcViewToIndex:rightIndex];
    // 移除视图
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        if (i == index) continue;
        if (i == leftIndex) continue;
        if (i == rightIndex) continue;
        UIViewController *vc = self.childViewControllers[i];
        [vc.view removeFromSuperview];
    }
}

#pragma mark - Lazy

- (YPSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        YPSegmentBar *segmentBar = [[YPSegmentBar alloc] init];
        segmentBar.delegate = self;
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.scrollsToTop = NO;
        contentView.bounces = NO;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (YPSegmentControllerConfig *)config
{
    if (!_config) {
        _config = [YPSegmentControllerConfig defaultConfig];
    }
    return _config;
}

#pragma mark - YPSegmentBarDelegate
- (void)segmentBar:(YPSegmentBar *)segmentBar didSelectedIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    [self showChildVCViewsAtIndex:toIndex];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    self.segmentBar.selectIndex = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!scrollView.dragging || (self.segmentBar.linkMode == YPSegmentBarScrollModeNormal && !self.segmentBar.enableTitleGradient)) return; 
    
    // 拖拽比例
    CGFloat bili = scrollView.contentOffset.x / self.contentView.width;
    
    self.segmentBar.indicatorProgress = bili;
}

@end



































