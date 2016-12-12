//
//  YPSegmentBar.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/1.
//  Copyright © 2016年 yongche. All rights reserved.
//

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
@property (nonatomic, assign) BOOL enableTitleGradient;


/**
 *  配置Bar的各种参数
 */
- (void)updateWithConfig:(void(^)(YPSegmentBarConfig *config))block;

@end

@protocol YPSegmentBarDelegate <NSObject>

- (void)segmentBar:(YPSegmentBar *)segmentBar didSelectedIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

UIKIT_EXTERN NSString * const YPSegmentBarSelectionDidChangeNotification;
