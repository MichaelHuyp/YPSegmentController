//
//  YPSegmentBar.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/1.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YPSegmentBar.h"
#import "UIView+YPSegment.h"
#import "UIColor+YPSegment.h"

NSString * const YPSegmentBarSelectionDidChangeNotification = @"YPSegmentBarSelectionDidChangeNotification";

@interface YPSegmentBar ()
{
    // 记录最后一次点击的按钮
    UIButton *_lastBtn;
    
    // 记录最合适的间距
    CGFloat _caculateMargin;
    
    // 记录按钮普通状态下的RGB
    CGFloat _normalColors[3];
    
    // 记录按钮选中状态下的RGB
    CGFloat _selectedColors[3];
    
    // 记录颜色R的变化间距
    CGFloat _deltaR;
    
    // 记录颜色G的变化间距
    CGFloat _deltaG;
    
    // 记录颜色B的变化间距
    CGFloat _deltaB;
}

/** 内容承载视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 记录所有的按钮 */
@property (nonatomic, strong) NSMutableArray <UIButton *> *itemBtns;

/** 属性配置 */
@property (nonatomic, strong) YPSegmentBarConfig *config;

/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@end

@implementation YPSegmentBar


#pragma mark - Public
- (void)updateWithConfig:(void(^)(YPSegmentBarConfig *config))block
{
    if (block) block(self.config);
    
    // 按照当前的配置进行刷新
    self.backgroundColor = self.config.backgroundColor;
    
    if ([self.superview isKindOfClass:[UINavigationBar class]]) {
        self.centerX = self.superview.width * 0.5;
        self.top = 0;
        self.width = self.config.onNaviBarWidth;
    }
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemTitleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemTitleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    
    
    // 指示器
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    self.indicatorView.hidden = self.config.indicatorHidden;
    
    // 重新保存选中与普通状态下的RGB
    [_config.itemTitleNormalColor getRGBComponents:_normalColors];
    [_config.itemTitleSelectColor getRGBComponents:_selectedColors];
    _deltaR = _normalColors[0] - _selectedColors[0];
    _deltaG = _normalColors[1] - _selectedColors[1];
    _deltaB = _normalColors[2] - _selectedColors[2];
    
    
    
    
    // 刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self initialization];
    return self;
}

- (void)initialization
{
    self.backgroundColor = self.config.backgroundColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内容承载视图布局
    self.contentView.frame = self.bounds;
    
    // 计算所有按钮的宽度
    CGFloat totoalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totoalBtnWidth += btn.width;
    }
    
    // 计算最适合的间距
    CGFloat caculateMargin = (self.width - totoalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < self.config.minMargin) caculateMargin = self.config.minMargin;
    _caculateMargin = caculateMargin;
    
    // 按钮布局
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.top = 0;
        btn.left = lastX;
        btn.height = self.height;
        lastX += btn.width + caculateMargin;
    }
    
    // 设置contentSize
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if ((self.itemBtns.count == 0)) return;
    
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.width = btn.width;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    self.indicatorView.top = self.height - self.indicatorView.height;
    [self.contentView bringSubviewToFront:self.indicatorView];
    
}


#pragma mark - Setter

- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    
    // 释放资源
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    _lastBtn = nil;
    _selectIndex = 0;
    
    // 根据所有的选项数据源,创建UIButton,添加到内容视图上
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        btn.titleLabel.font = self.config.itemFont;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.config.itemTitleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemTitleSelectColor forState:UIControlStateSelected];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)setIndicatorProgress:(CGFloat)indicatorProgress
{
    // 首先拿到拖动过程中的左右按钮
    NSInteger currentIndex = (NSInteger)indicatorProgress;
    // 左按钮
    UIButton *currentBtn = self.itemBtns[currentIndex];
    // 右按钮
    UIButton *nextBtn = nil;
    if (!(currentIndex + 1 > self.itemBtns.count - 1)) {
        nextBtn = self.itemBtns[currentIndex + 1];
    }
    
    _indicatorProgress = indicatorProgress;
    
    // 进度
    CGFloat progress = (indicatorProgress - (int)indicatorProgress);
    
    if (self.linkMode == YPSegmentBarLinkModeProgress) {
        // 调节指示器随着进度变化而变化
        [UIView animateWithDuration:0.2f animations:^{
            if (currentBtn.width < nextBtn.width) {
                // 左按钮宽度小于右按钮宽度 宽度应该增长
                self.indicatorView.width = progress * (fabs(currentBtn.width - nextBtn.width)) + currentBtn.width;
            } else if (currentBtn.width > nextBtn.width) {
                // 左按钮宽度大于右按钮宽度 宽度应该减小
                self.indicatorView.width = currentBtn.width - progress * (fabs(currentBtn.width - nextBtn.width));
            }
            
            // 中心点的位置应该为左右宽度的一半 加上间距 乘以 当前进度(0~1) 再加上左按钮的centerX
            self.indicatorView.centerX =  currentBtn.centerX + progress * (currentBtn.width * 0.5 + nextBtn.width * 0.5 + _caculateMargin);
        }];
    }
    
    if (self.enableTitleColorGradient) {
        // 渐变色处理
        CGFloat currentR = _selectedColors[0] + _deltaR * progress;
        CGFloat currentG = _selectedColors[1] + _deltaG * progress;
        CGFloat currentB = _selectedColors[2] + _deltaB * progress;
        UIColor *currentColor = [UIColor colorWithRed:currentR green:currentG blue:currentB alpha:1.0f];
        [currentBtn setTitleColor:currentColor forState:UIControlStateSelected];
        [currentBtn setTitleColor:currentColor forState:UIControlStateNormal];
        CGFloat nextR = _normalColors[0] - _deltaR * progress;
        CGFloat nextG = _normalColors[1] - _deltaG * progress;
        CGFloat nextB = _normalColors[2] - _deltaB * progress;
        UIColor *nextColor = [UIColor colorWithRed:nextR green:nextG blue:nextB alpha:1.0f];
        [nextBtn setTitleColor:nextColor forState:UIControlStateNormal];
        [nextBtn setTitleColor:nextColor forState:UIControlStateSelected];
    }
    
    if (self.enableTitleSizeGradient) {
        // 字体大小渐变
        nextBtn.transform = CGAffineTransformMakeScale(1 + (progress * (self.config.fontChangeDelta - 1)), 1 + (progress * (self.config.fontChangeDelta - 1)));
        currentBtn.transform = CGAffineTransformMakeScale(self.config.fontChangeDelta - (progress * (self.config.fontChangeDelta - 1)), self.config.fontChangeDelta - (progress * (self.config.fontChangeDelta - 1)));
    }
    
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    // 数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) return;
    
    _selectIndex = selectIndex;
    
    UIButton *btn = self.itemBtns[selectIndex];
    
    [self btnClick:btn];
}

- (void)setFrame:(CGRect)frame
{
    CGRect newFrame = frame;
    
    if ([self.superview isKindOfClass:[UINavigationBar class]]) {
        newFrame.origin.y = 0;
        newFrame.size.width = self.config.onNaviBarWidth;
        newFrame.origin.x = self.superview.width * 0.5 - newFrame.size.width * 0.5;
    }
    
    [super setFrame:newFrame];

}

#pragma mark - Action
- (void)btnClick:(UIButton *)btn
{
    // 触发代理
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectedIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    
    // 通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YPSegmentBarSelectionDidChangeNotification object:nil userInfo:@{@"didSelectedIndex" : @(btn.tag), @"fromIndex" : @(_lastBtn.tag)}];
    
    [btn setTitleColor:self.config.itemTitleNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.config.itemTitleSelectColor forState:UIControlStateSelected];
    
    if (self.enableTitleSizeGradient) {
        // 字体渐变大小
        if (!_lastBtn || (_lastBtn == btn)) {
            btn.transform = CGAffineTransformIdentity;
            btn.transform = CGAffineTransformMakeScale(self.config.fontChangeDelta, self.config.fontChangeDelta);
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                btn.transform = CGAffineTransformMakeScale(self.config.fontChangeDelta, self.config.fontChangeDelta);
                _lastBtn.transform = CGAffineTransformIdentity;
            }];
        }
    }
    


    
    _selectIndex = btn.tag;
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
 
    [UIView animateWithDuration:0.2f animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    

    // 滚动模式
    if (self.scrollMode == YPSegmentBarScrollModeNormal) {
        // 转换坐标系
        CGRect newFrame = [btn convertRect:btn.bounds toView:self.window];
        CGFloat scrollX = self.contentView.contentOffset.x;
        if (newFrame.origin.x < (btn.width + self.config.minMargin)) {
            scrollX = btn.centerX - btn.width * 1.5 - self.config.minMargin;
        } else if (newFrame.origin.x > (self.contentView.bounds.size.width - btn.width - (btn.width + self.config.minMargin))) {
            scrollX = btn.centerX - self.contentView.width + btn.width * 1.5 + self.config.minMargin;
        }
        if (scrollX < 0) {
            scrollX = 0;
        }
        if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
            scrollX = self.contentView.contentSize.width - self.contentView.width;
        }
        [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
        

    } else if (self.scrollMode == YPSegmentBarScrollModeCenter) {
        CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
        if (scrollX < 0) {
            scrollX = 0;
        }
        if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
            scrollX = self.contentView.contentSize.width - self.contentView.width;
        }
        [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Lazy
- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.scrollsToTop = NO;
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (NSMutableArray<UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (YPSegmentBarConfig *)config
{
    if (!_config) {
        _config = [YPSegmentBarConfig defaultConfig];
        [_config.itemTitleNormalColor getRGBComponents:_normalColors];
        [_config.itemTitleSelectColor getRGBComponents:_selectedColors];
        _deltaR = _normalColors[0] - _selectedColors[0];
        _deltaG = _normalColors[1] - _selectedColors[1];
        _deltaB = _normalColors[2] - _selectedColors[2];
    }
    return _config;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        CGFloat indicatorH = self.config.indicatorHeight;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        indicatorView.hidden = self.config.indicatorHidden;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

@end

































































