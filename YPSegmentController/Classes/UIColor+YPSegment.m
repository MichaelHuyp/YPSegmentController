//
//  UIColor+YPSegment.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/5.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "UIColor+YPSegment.h"

@implementation UIColor (YPSegment)

- (void)getRGBComponents:(CGFloat [3])components
{
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 1);
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
