//
//  LayerLoadingAnim.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "LayerLoadingAnim.h"

#define PI 3.1415926

@implementation LayerLoadingAnim


-(instancetype)init{

    if(self = [super init]){
    
        
        
    } return self;

}



-(void) drawInContext:(CGContextRef)ctx{


    //画一个三角形
    CGFloat width = self.frame.size.width * 0.65;
    CGFloat width2= width/(sqrt(3));
    
    CGFloat centerX = self.frame.size.width/2;
    CGFloat centerY = self.frame.size.width/2;

    CGContextSetRGBFillColor(ctx, 0.52f, 0.76f, 0.07f, 1.0f);
    CGPoint sPoints[3];
    sPoints[0] = CGPointMake(centerX+(width*(2/3.0)), centerY);
    sPoints[1] = CGPointMake(sPoints[0].x-width, sPoints[0].y-width2);
    sPoints[2] = CGPointMake(sPoints[1].x, sPoints[1].y+2*width2);
    CGContextAddLines(ctx, sPoints, 3);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
    
}

@end
