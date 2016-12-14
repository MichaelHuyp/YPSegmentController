//
//  YPSegmentController.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/2.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPSegmentBar.h"
#import "YPSegmentControllerConfig.h"

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
