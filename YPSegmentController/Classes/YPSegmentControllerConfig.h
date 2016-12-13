//
//  YPSegmentControllerConfig.h
//  YPSegmentController
//
//  Created by 胡云鹏 on 2016/12/5.
//  Copyright © 2016年 yongche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPSegmentControllerConfig : NSObject

+ (instancetype)defaultConfig;

/** Bar距离顶部的高度 */
@property (nonatomic, assign) CGFloat segmentBarTop;

/** Bar的x坐标 */
@property (nonatomic, assign) CGFloat segmentBarLeft;

/** Bar的高度 */
@property (nonatomic, assign) CGFloat segmentBarHeight;

/** Bar的宽度 */
@property (nonatomic, assign) CGFloat segmentBarWidth;


@end
