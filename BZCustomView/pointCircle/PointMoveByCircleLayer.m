//
//  PointMoveByCircleLayer.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/10/10.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PointMoveByCircleLayer.h"
#import <UIKit/UIKit.h>

#define PI 3.1415926

@implementation PointMoveByCircleLayer

-(instancetype) init{

    if(self = [super init]){
    
        self.dAngle = 0;
    }
    
    return self;
}

-(void) playAnim{

//    NSDate *scheduledTime = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimer *timer = [[NSTimer alloc] initWithFireDate:scheduledTime
//                                              interval:0.00000001
//                                                target:self
//                                              selector:@selector(task)
//                                              userInfo:nil
//                                               repeats:YES];
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
    
   

}

-(void)task {
    self.dAngle += 1;
    [self setNeedsDisplay];
    
}

-(void) stopAnim{

    
}

-(void) drawInContext:(CGContextRef)ctx{
    
    
    //画圆
    CGContextSetRGBStrokeColor(ctx,0.52f, 0.76f, 0.07f, 1.0f);
    
    CGContextSetLineWidth(ctx, 2.0);
    
    //    CGContextAddArc(ctx, self.frame.size.width / 2 - 10, self.frame.size.height / 2, 25, 0, PI, 0);
    //
    //    CGContextAddArc(ctx, self.frame.size.width / 2 + 10, self.frame.size.height / 2, 25, 0, PI, 0);
    
    
    /*
     CGContextRef c:上下文
     CGFloat x ：x，y圆弧所在圆的中心点坐标
     CGFloat y ：x，y圆弧所在圆的中心点坐标
     CGFloat radius ：所在圆的半径
     CGFloat startAngle ： 圆弧的开始的角度  单位是弧度  0对应的是最右侧的点；
     CGFloat endAngle  ： 圆弧的结束角度
     int clockwise ： 顺时针（0） 或者 逆时针(1)
     */
    CGContextAddArc(ctx, self.frame.size.width / 2, self.frame.size.height / 2, 25, 0,  2 * PI, 0);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    //画一个圆点,,将上面的定时器开启可以达到圆点绕圆周运动
//    CGContextSetRGBStrokeColor(ctx,0.12f, 0.26f, 0.07f, 1.0f);
//    CGContextAddArc(ctx,
//                    self.frame.size.width / 2 + cos(self.dAngle * PI / 180) * 25,
//                    self.frame.size.height / 2 + sin(self.dAngle * PI / 180) * 25,
//                    5,
//                    0,
//                    2 * PI,
//                    0);
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
}


@end
