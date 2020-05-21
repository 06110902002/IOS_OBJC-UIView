//
//  UIView+Resize.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/21.
//  Copyright © 2020 刘小兵. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Resize)

/** 设置x值 */
@property (assign, nonatomic) CGFloat tx_x;
/** 设置y值 */
@property (assign, nonatomic) CGFloat tx_y;
/** 设置width */
@property (assign, nonatomic) CGFloat tx_width;
/** 设置height */
@property (assign, nonatomic) CGFloat tx_height;
/** 设置size */
@property (assign, nonatomic) CGSize  tx_size;
/** 设置origin */
@property (assign, nonatomic) CGPoint tx_origin;
/** 设置center */
@property (assign, nonatomic) CGPoint tx_center;
/** 设置center.x */
@property (assign, nonatomic) CGFloat tx_centerX;
/** 设置center.y */
@property (assign, nonatomic) CGFloat tx_centerY;
/** 设置bottom */
@property (assign, nonatomic) CGFloat tx_bottom;

@end

NS_ASSUME_NONNULL_END
