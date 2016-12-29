//
//  YPSegmentBarButton.m
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/29.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import "YPSegmentBarButton.h"
#import "UIView+YPSegment.h"

@implementation YPSegmentBarButton

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}



@end
