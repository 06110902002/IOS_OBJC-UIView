//
//  CircleLayer.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "CircleLayer.h"

#define PI 3.1415926

@implementation CircleLayer



-(void) drawInContext:(CGContextRef)ctx{

    
    //画圆
    CGContextSetRGBStrokeColor(ctx,0.52f, 0.76f, 0.07f, 1.0f);
    
    CGContextSetLineWidth(ctx, 1.0);
   
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
    CGContextAddArc(ctx, self.frame.size.width / 2 - 2, self.frame.size.height / 2, 25, - PI / 2,  PI / 2, 1);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    CGContextAddArc(ctx, self.frame.size.width / 2 + 2, self.frame.size.height / 2, 25, - PI / 2,  PI / 2, 0);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    //画一条白色的线
//    CGContextSetRGBStrokeColor(ctx,1.0, 1.0, 1.0, 1.0);
//    CGContextSetLineWidth(ctx, 4.0);
//    
//    CGPoint aPoints[2];
//    aPoints[0] = CGPointMake(self.frame.size.width / 2 - 25 - 1, self.frame.size.height / 2);
//    aPoints[1] = CGPointMake(self.frame.size.width / 2 + 25 + 1, self.frame.size.height / 2);
//    
//    CGContextAddLines(ctx, aPoints, 2);
//    CGContextDrawPath(ctx, kCGPathStroke);
    


}


@end
