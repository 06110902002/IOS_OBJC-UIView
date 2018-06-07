//
//  HWCircleProgressView.m
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/7.
//  Copyright © 2018 刘小兵. All rights reserved.
//

#import "HWCircleProgressView.h"
#define PI 3.1415926

@implementation HWCircleProgressView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        
        self.stopAngle = 90.0f;
        self.startAngle = 0.0f;
    }
    return self;
}

-(void) layoutSubviews{
    
    self.centerX = self.frame.size.width / 2;
    self.centerY = self.frame.size.height / 2;
    
    self.r = self.frame.size.width / 2 * 0.8f;
    self.l = self.frame.size.width / 2 * 0.1f;
    
}


/**
 根据半径和角度计算x坐标

 @param r 半径
 @param angle 角度
 @return x 座标
 */
-(float) calculateX:(float) r angle:(float) angle{
    
    angle = angle * ((2 * PI) / 360);  //转换为弧度
    double x = r * sin(angle);
    double xFinal = self.centerX + x;
    return (float) xFinal;
    
}

-(float) calculateY:(float)r angle:(float) angle{
    
    angle = angle * ((2 * PI) / 360);
    double y = r * cos(angle);
    double yFinal = self.centerY - y;
    return (float) yFinal;
}


/**
 弧度转角度

 @param radian 弧度
 @return 角度值
 */
-(float) radian2Angle:(float)radian{
    
    float tmp = round(radian / PI * 180);
    return tmp >= 0 ? tmp : 360 + tmp;
}


/**
 2点之间计算角度

 @param x1
 @param y1
 @param x2
 @param y2
 @return
 */
-(float) getAngle:(float)x1 posy1:(float)y1 posx2:(float)x2 posy2:(float) y2{
    
    // 两点在X轴的距离
    float lenX = (float) (x2 - x1);
    // 两点在Y轴距离
    float lenY = (float) (y2 - y1);
    // 两点距离
    float lenXY = (float) sqrt((double) (lenX * lenX + lenY * lenY));
    // 计算弧度
    float radian = (float) acos(lenX / lenXY) * (y2 < y1 ? -1 : 1);
    // 计算角度
    double angle = [self radian2Angle:radian];//radian2Angle(radian);
    
    return (float) angle;
}

-(float) comfirmNumIs6Times:(int)n{
    float mol = n % 6;
    if (mol == 0) {
        return n;
    }
    return n - mol;
}
-(Boolean)updateStopAngle:(float) stopAngle{
    
    if (stopAngle >= self.startAngle && stopAngle <= 360) {
        self.stopAngle = stopAngle;
        [self setNeedsDisplay];//invalidate();
        return true;
    } else
        return false;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    
    for (float angle = 0; angle <= 360; angle += 6.0) {
        float xStart = [self calculateX:self.r angle:angle];//calculateX(r, angle);
        float xStop = [self calculateX:self.r - self.l angle:angle];//calculateX(r - l, angle);
        
        float yStart = [self calculateY:self.r angle:angle];//calculateY(r, angle);
        float yStop = [self calculateY:self.r - self.l angle:angle];//calculateY(r - l, angle);
        
        if (angle <= self.stopAngle && angle >= self.startAngle) {
           // linePaint.setShader(shader);
            CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);//线框颜色

        } else {
            //linePaint.setShader(shaderWhite);
            CGContextSetStrokeColorWithColor(context, [[UIColor yellowColor] CGColor]);//线框颜色

        }

        if (angle == self.stopAngle) {

            float xStartL = [self calculateX:self.r * 1.05f angle:angle];//calculateX(r * 1.05f, angle);
            float xStopL = [self calculateX:self.r - self.l angle:angle];//calculateX((r - l), angle);

            float yStartL = [self calculateY:self.r * 1.05f angle:angle];//calculateY(r * 1.05f, angle);
            float yStopL = [self calculateY:self.r  - self.l angle:angle];//calculateY((r - l), angle);
            //canvas.drawLine(xStartL, yStartL, xStopL, yStopL, linePaint);    //画彩色的长线
            
            CGContextMoveToPoint(context, xStartL, yStartL);
            CGContextAddLineToPoint(context, xStopL,yStopL);

        } else {
            //canvas.drawLine(xStart, yStart, xStop, yStop, linePaint);           //画所有的短线
            
            CGContextMoveToPoint(context, xStart, yStart);
            CGContextAddLineToPoint(context, xStop,yStop);
        }
        
   
        CGContextStrokePath(context);   // 关闭路径渲染
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    self.actionDownX = point.x;
    self.actionDownY = point.y;
    //NSLog(@"170-------:%f",point.x);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]];
    
    float newAngle = [self getAngle:self.actionDownX posy1:self.actionDownY posx2:point.x posy2:point.y];//getAngle(actionDownX, actionDownY, event.getX(), event.getY());
    
    newAngle = [self comfirmNumIs6Times:newAngle];//comfirmNumIs6Times(newAngle);    //如果不取刻度值，滑动起来就会变得很流畅
    
    //stopTem = (int) (newAngle / 6);
    //setStopAngle(newAngle);
    [self updateStopAngle:newAngle];
    //NSLog(@"186---------:move:%f",point.x);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}


@end
