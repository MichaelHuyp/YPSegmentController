//
//  YPSegmentControllerConfig.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/5.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YPSegmentControllerConfig.h"

@implementation YPSegmentControllerConfig

+ (instancetype)defaultConfig
{
    YPSegmentControllerConfig *config = [[YPSegmentControllerConfig alloc] init];
    
    config.segmentBarTop = 20;
    
    config.segmentBarLeft = 0;
    
    config.segmentBarHeight = 44;
    
    config.segmentBarWidth = [UIScreen mainScreen].bounds.size.width;
    
    return config;
}

@end
