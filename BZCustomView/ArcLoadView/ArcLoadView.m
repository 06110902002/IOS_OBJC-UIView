//
//  ArcLoadView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ArcLoadView.h"

@implementation ArcLoadView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.pointLayer = [CAShapeLayer layer];
         self.pointLayer.frame = CGRectMake(self.layer.frame.size.width / 2,
         120, 15, 15);

        self.pointLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:self.pointLayer];
        
        self.path = [UIBezierPath bezierPath];
        
        self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
        self.screenHeight = [[UIScreen mainScreen] bounds].size.height;

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [self pathAnim:rect];
    [self testDrawLineAnim];
    
}


-(void) testDrawLineAnim{
    NSLog(@"69----------:%f  %f",self.bounds.size.width / 2,self.screenWidth / 2);
    
    //上半部轨迹:
    UIBezierPath * path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(self.bounds.size.width, self.center.y)];
    //直线终点
    [path addLineToPoint:CGPointMake(self.center.x + 60, self.center.y)];
    //圆路径
     [path addArcWithCenter:self.center radius:60.0f startAngle:M_PI*2 endAngle:M_PI*1 clockwise:NO];
    //创建一个CAShapeLayer
    CAShapeLayer * caShapelayer = [CAShapeLayer layer];
    caShapelayer.path = path.CGPath;
    //线条宽度
    caShapelayer.lineWidth = 1.5f;
    caShapelayer.frame = self.bounds;
    //线条颜色
    caShapelayer.strokeColor = [UIColor greenColor].CGColor;
    //填充颜色
    caShapelayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:caShapelayer];
    
    //下半部轨迹:
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0, self.center.y)];
    [path2 addLineToPoint:CGPointMake(self.center.x-60,self.center.y)];
    [path2 addArcWithCenter:self.center radius:60.0f startAngle:M_PI*1 endAngle:M_PI*2 clockwise:NO];
    //创建一个CAShapeLayer
    CAShapeLayer * caShapelayer2 = [CAShapeLayer layer];
    caShapelayer2.path = path2.CGPath;
    //线条宽度
    caShapelayer2.lineWidth = 1.5f;
    caShapelayer2.frame = self.bounds;
    //线条颜色
    caShapelayer2.strokeColor = [UIColor greenColor].CGColor;
    //填充颜色
    caShapelayer2.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:caShapelayer2];
    
    //开始动画
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self drawLineAnimation:caShapelayer];
        [self drawLineAnimation:caShapelayer2];
    });
}


//绘制 Path轨迹
- (void)drawLineAnimation:(CALayer*)layer {
    
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = 2;
    //bas.delegate = self;
    bas.fromValue = [NSNumber numberWithInteger:0];
    bas.toValue = [NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
    
}



-(void) pathAnim:(CGRect)rect{
        // Drawing code
        // 初始化UIBezierPath
        // 首先设置一个起始点
        CGPoint startPoint = CGPointMake(rect.size.width/2, 120);
        // 以起始点为路径的起点
        [self.path moveToPoint:startPoint];
        // 设置一个终点
        CGPoint endPoint = CGPointMake(rect.size.width/2, rect.size.height-40);
        // 设置第一个控制点
        CGPoint controlPoint1 = CGPointMake(100, 20);
        // 设置第二个控制点
        CGPoint controlPoint2 = CGPointMake(0, 180);
        // 添加三次贝塞尔曲线
        [self.path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        // 设置另一个起始点
        [self.path moveToPoint:endPoint];
        // 设置第三个控制点
        CGPoint controlPoint3 = CGPointMake(rect.size.width-100, 20);
        // 设置第四个控制点
        CGPoint controlPoint4 = CGPointMake(rect.size.width, 180);
        // 添加三次贝塞尔曲线
        [self.path addCurveToPoint:startPoint controlPoint1:controlPoint4 controlPoint2:controlPoint3];
        // 设置线宽
        self.path.lineWidth = 3;
        // 设置线断面类型
        self.path.lineCapStyle = kCGLineCapRound;
        // 设置连接类型
        self.path.lineJoinStyle = kCGLineJoinRound;
        // 设置画笔颜色
        [[UIColor redColor] set];
        [self.path stroke];
}


-(void)startAnim{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    animation.path = self.path.CGPath;
    // 动画时间间隔
    animation.duration = 3.0f;
    // 重复次数为最大值
    animation.repeatCount = FLT_MAX;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到动画视图上

    self.pointLayer.position = CGPointMake(self.layer.frame.size.width / 2,
                                                          120);
    [self.pointLayer addAnimation:animation forKey:nil];
    
  
    


}


@end
