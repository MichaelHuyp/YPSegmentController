//
//  YPSegmentBarConfig.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/1.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YPSegmentBarConfig.h"

@implementation YPSegmentBarConfig

+ (instancetype)defaultConfig
{
    YPSegmentBarConfig *config = [[YPSegmentBarConfig alloc] init];
    config.backgroundColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:14];
    config.itemTitleNormalColor = [UIColor blackColor];
    config.itemTitleSelectColor = [UIColor redColor];
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.minMargin = 30;
    return config;
}

@end
