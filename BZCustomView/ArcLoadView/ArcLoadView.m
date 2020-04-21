//
//  ArcLoadView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ArcLoadView.h"


#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degress) ((pi * degress)/180)

@interface ArcLoadView (){
     CADisplayLink *_disPlayLink;
     CGFloat _angle;
     UIBezierPath* _swingPath;
     CAShapeLayer* _swingArcLayer;
     CAShapeLayer* _swingArcPointLayer;
    BOOL _isArcReverse;
    CAKeyframeAnimation* _pathAnim;
    
}



@end

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
        
        [self initLayer];

    }
    return self;
}

-(void) initLayer{
    _angle = 0;
    _isArcReverse = false;
//    self.arcLayer = [CAShapeLayer layer];
//    self.arcPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:50.0 startAngle:0 endAngle:0.5 * M_PI clockwise:YES];
//    self.arcLayer.lineWidth = 2;
//    self.arcLayer.strokeColor = [UIColor greenColor].CGColor;
//    self.arcLayer.fillColor = nil;
//    self.arcLayer.path = self.arcPath.CGPath;
//    [self.layer addSublayer:self.arcLayer];
    
//
//     CAShapeLayer *testLayer = [CAShapeLayer layer];
//        testLayer.backgroundColor = [UIColor clearColor].CGColor;
//        testLayer.frame = CGRectMake(100, 100, 100, 100);
//        [self.layer addSublayer:testLayer];
//
//        self.arcLayer = [CAShapeLayer layer];
//         self.arcLayer.fillColor = [UIColor clearColor].CGColor;
//         self.arcLayer.strokeColor = [UIColor orangeColor].CGColor;
//         self.arcLayer.lineCap = kCALineCapRound;
//         self.arcLayer.lineWidth = 7;
//
//        _angle = 90;
//        UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50-3.5
//                                                           startAngle:DEGREES_TO_RADIANS(45)
//                                                             endAngle:DEGREES_TO_RADIANS((45 + 60))
//                                                            clockwise:YES];
//         self.arcLayer.path = thePath.CGPath;
//        [testLayer addSublayer: self.arcLayer];
//
//
//   CAShapeLayer* circlePoint = [CAShapeLayer layer];
//    circlePoint.frame = CGRectMake(cos(DEGREES_TO_RADIANS(0)), sin(DEGREES_TO_RADIANS(0)), 10, 10);
//
//   circlePoint.backgroundColor = [UIColor greenColor].CGColor;
//   [testLayer addSublayer:circlePoint];
    
    if (!_arcPath){
        _arcPath = [UIBezierPath bezierPath];
    }
    
    if (!_swingArcLayer) {
           _swingArcLayer = [CAShapeLayer layer];
           _swingArcLayer.backgroundColor = [UIColor clearColor].CGColor;
           _swingArcLayer.fillColor = [UIColor clearColor].CGColor;
           _swingArcLayer.strokeColor = [UIColor orangeColor].CGColor;
           [self.layer addSublayer:_swingArcLayer];
       }
    
        if (!_swingArcPointLayer) {
             _swingArcPointLayer = [CAShapeLayer layer];
             _swingArcPointLayer.frame = CGRectMake(cos(DEGREES_TO_RADIANS(_angle)), sin(DEGREES_TO_RADIANS(_angle)), 10, 10);
             _swingArcPointLayer.backgroundColor = [UIColor greenColor].CGColor;
             _swingArcPointLayer.lineCap = kCALineCapRound;
             _swingArcPointLayer.lineWidth = 7;
    
            [_swingArcLayer addSublayer:_swingArcPointLayer];
    
    
        }
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        //[self startArcSwingAnim:testLayer];
        
        _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(upDataWave:)];
        [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        // 设置动画的路径为心形路径
        animation.path = _arcPath.CGPath;
        NSLog(@"125------------：%@",_arcPath.CGPath);
        // 动画时间间隔
        animation.duration = 1.5f;
        // 重复次数为最大值
        animation.repeatCount = FLT_MAX;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeBackwards;
        animation.autoreverses = true;
        [_swingArcPointLayer addAnimation:animation forKey:nil];

    });
   
}

- (void)upDataWave:(CADisplayLink *)link{
    
    if(_isArcReverse){
        if (_angle <= -45) {
            _angle = -45;
            _isArcReverse = false;
        }else{
            _angle -= 4.5f;
            _isArcReverse = true;

        }
        
    }else{
        if(_angle >=-45 && _angle <= 180){
            _angle += 4.5f;
            _isArcReverse = false;
        }else if(_angle > 180){
            
            _isArcReverse = true;
        }
    }
    
//    if (!_swingArcLayer) {
//        _swingArcLayer = [CAShapeLayer layer];
//        _swingArcLayer.backgroundColor = [UIColor clearColor].CGColor;
//        _swingArcLayer.fillColor = [UIColor clearColor].CGColor;
//        _swingArcLayer.strokeColor = [UIColor orangeColor].CGColor;
//        [self.layer addSublayer:_swingArcLayer];
//    }
//    if (!_swingArcPointLayer) {
//         _swingArcPointLayer = [CAShapeLayer layer];
//         _swingArcPointLayer.frame = CGRectMake(cos(DEGREES_TO_RADIANS(_angle)), sin(DEGREES_TO_RADIANS(_angle)), 10, 10);
//         _swingArcPointLayer.fillColor = [UIColor clearColor].CGColor;
//         _swingArcPointLayer.strokeColor = [UIColor orangeColor].CGColor;
//         _swingArcPointLayer.lineCap = kCALineCapRound;
//         _swingArcPointLayer.lineWidth = 7;
//
//        [_swingArcLayer addSublayer:_swingArcPointLayer];
//
//
//    }
//    if (!_arcPath){
//        _arcPath = [UIBezierPath bezierPath];
//    }
    [_arcPath removeAllPoints];
    [_arcPath addArcWithCenter:CGPointMake(50, 50)
                        radius:50 - 3.5
                    startAngle:DEGREES_TO_RADIANS(_angle)
                      endAngle:DEGREES_TO_RADIANS((60 + _angle))
                     clockwise:true];
    _swingArcLayer.path = _arcPath.CGPath;
   // [self startAnimByPath:_arcPath];
}

-(void) startAnimByPath:(UIBezierPath*) path{
    if (path) {
        if (!_pathAnim) {
            _pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
           _pathAnim.duration = 0.2f;
           _pathAnim.repeatCount = FLT_MAX;
           _pathAnim.removedOnCompletion = NO;
           _pathAnim.fillMode = kCAFillModeBackwards;
           _pathAnim.autoreverses = true;

        }
        _pathAnim.path = path.CGPath;
        //[_swingArcPointLayer addAnimation:_pathAnim forKey:nil];

    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"121-----------:");
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

    [self.pointLayer addAnimation:animation forKey:nil];
    
}

/**
   启动圆弧摆动动画
 */
- (void)startArcSwingAnim:(CAShapeLayer *)shapeLayer{
//    //初始化一个动画
//    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
//    //动画运动的方式，现在指定的是围绕Z轴旋转
//    baseAnimation.keyPath = @"transform.rotation.z";
//    //动画持续时间
//    baseAnimation.duration = 0.75;
//    //动画次数
//    baseAnimation.repeatCount = MAXFLOAT;
//    //开始的角度
//    baseAnimation.fromValue = [NSNumber numberWithFloat:-(M_PI/6)];
//    //结束的角度
//    baseAnimation.toValue = [NSNumber numberWithFloat:M_PI/6.5];
//    //动画的运动方式
//    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    //是否反向移动动画
//    baseAnimation.autoreverses = YES;
//    //动画结束后的状态
//    baseAnimation.fillMode = kCAFillModeForwards;
//    [baseAnimation setValue:@"left" forKey:@"left"];
//    [shapeLayer addAnimation:baseAnimation forKey:@"left"];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 2.0f;
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.repeatCount = INFINITY;
    
    [shapeLayer addAnimation:animation forKey:nil];


}


@end
