//
//  YPSegmentBarConfig.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/1.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface YPSegmentBarConfig : NSObject


+ (instancetype)defaultConfig;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;

/** 按钮普通状态下文字颜色 */
@property (nonatomic, strong) UIColor *itemTitleNormalColor;

/** 按钮选中状态下文字颜色 */
@property (nonatomic, strong) UIColor *itemTitleSelectColor;

/** 按钮文字字体 */
@property (nonatomic, strong) UIFont *itemFont;

/** 指示器颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;

/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/** 文字间的最小间距 */
@property (nonatomic, assign) CGFloat minMargin;

/** 指示器是否隐藏 */
@property (nonatomic, assign) BOOL indicatorHidden;

/** 在导航条上的宽度 */
@property (nonatomic, assign) CGFloat onNaviBarWidth;


@end
