//
//  LayerDraw.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "LayerDraw.h"

#define PI 3.1415926

@implementation LayerDraw





/**
 重写本接口，达到绘图效果

 @param ctx 绘图上下文
 */
-(void) drawInContext:(CGContextRef)ctx{

    //画一个三角形
    CGFloat width = self.frame.size.width * 0.65;
    CGFloat width2= width/(sqrt(3));
    
    CGFloat centerX = self.frame.size.width/2;
    CGFloat centerY = self.frame.size.width/2;
    
    CGContextSetRGBFillColor(ctx, 0.52f, 0.26f, 0.17f, 1.0f);
    
    CGContextSetRGBStrokeColor(ctx, 0.52f, 0.76f, 0.07f, 1.0f);//画笔线的颜色
    CGContextSetLineWidth(ctx, 1.0);//线的宽度

    
    
    
        CGContextAddArc(ctx,
                        centerX+(width*(2/3.0)) ,    //x
                        centerY,    //y
                        30,     //r
                        0,      //start angle
                        2 * PI, //end angle
                        0);
    
        CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
    

    
}


@end
