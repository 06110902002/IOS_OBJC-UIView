//
//  PointMoveByCircleLayer.h
//  BZCustomView
//
//  Created by 刘小兵 on 2017/10/10.
//  Copyright © 2017年 刘小兵. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

@interface PointMoveByCircleLayer : CALayer

@property(atomic,assign) CGPoint circlePointPos;

@property(nonatomic,assign) double dAngle;

-(void) playAnim;

-(void) stopAnim;

@end
