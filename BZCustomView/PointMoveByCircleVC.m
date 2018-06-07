//
//  PointMoveByCircleVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/10/10.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "PointMoveByCircleVC.h"
#import "PointMoveByCircleLayer.h"

@interface PointMoveByCircleVC ()

@property(nonatomic,strong) PointMoveByCircleLayer* layer;

@end

@implementation PointMoveByCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void) initView{

    self.view.backgroundColor  = [UIColor whiteColor];
    
    self.layer = [PointMoveByCircleLayer layer];
    self.layer.dAngle = 0;
    self.layer.frame = CGRectMake(100, 100, 100, 100);
    
    [self.layer setNeedsDisplay];    //写这个方法才会自动触发 drawInContext：的方法
    self.layer.backgroundColor = [UIColor brownColor].CGColor;
    
    [self.view.layer addSublayer:self.layer];
    
    
    UIButton* btnAnim = [[UIButton alloc] initWithFrame:CGRectMake(180, 240, 180, 30)];
    btnAnim.backgroundColor = [UIColor grayColor];
    btnAnim.tag = 13;
    [btnAnim setTitle:@"播放动画" forState:UIControlStateNormal];
    [btnAnim addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAnim];
}

-(void) onClick:(UIButton*) button{

    switch (button.tag) {
            case 13:{
                
                //[self.layer playAnim];
                
                
//                UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
//                [bezierPath moveToPoint:CGPointMake(0, 150)];
//                [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
                
                //初始化圆点层路径
                UIBezierPath* path = [[UIBezierPath alloc] init];
                [path addArcWithCenter:CGPointMake(self.layer.frame.size.width / 2, self.layer.frame.size.width / 2)
                                radius:25
                            startAngle:0
                              endAngle:2 * 3.1415926
                             clockwise:1];
                
                
                CALayer *colorLayer = [CALayer layer];
                colorLayer.frame = CGRectMake(0, 0, 5, 5);
                colorLayer.cornerRadius = 2.5;
                colorLayer.position = CGPointMake(self.layer.frame.size.width / 2 + cos(90 * 3.1415926 / 180) * 25,
                                                  self.layer.frame.size.width / 2 + sin(90 * 3.1415926 / 180) * 25);
                
                colorLayer.backgroundColor = [UIColor redColor].CGColor;
                [self.layer addSublayer:colorLayer];
                
                //创建一个帧动画需要 的圆周 路径，这个路径 与外圆圈一一致
                CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
                animation1.keyPath = @"position";
                animation1.path = path.CGPath;
                animation1.duration = 1.0;
                animation1.repeatCount = MAXFLOAT;
                animation1.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                
                
                [colorLayer addAnimation:animation1 forKey:nil];

                
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
