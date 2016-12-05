//
//  UIColor+YPSegment.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/5.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YPSegment)

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 */
- (void)getRGBComponents:(CGFloat [3])components;

@end
