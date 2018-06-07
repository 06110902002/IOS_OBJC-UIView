//
//  OppoVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "OppoVC.h"
#import "CircleLayer.h"
#import "ShapeLayer_BezierParh.h"

#define PI 3.1415926


@interface OppoVC ()<CAAnimationDelegate>

@property(nonatomic,strong) CircleLayer* circleLayer;

@property(nonatomic,strong) CAShapeLayer* shapeLayer;

@property(nonatomic,strong) CAShapeLayer* shapeLayer2;

@property(nonatomic,strong) ShapeLayer_BezierParh* bezierParhLayer;

@end

@implementation OppoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    self.circleLayer = [CircleLayer layer];
//    
//    self.circleLayer.bounds = CGRectMake(0, 0, 200 , 200);      // 设置层的宽高
//    self.circleLayer.position = CGPointMake(200, 200);
//    
//    self.circleLayer.backgroundColor = [UIColor grayColor].CGColor;
//    [self.circleLayer setNeedsDisplay];
//    
//    [self.view.layer addSublayer: self.circleLayer];
//    
//    
//    UIButton* startAnim = [[UIButton alloc] initWithFrame:CGRectMake(200, 340, 120, 40)];
//    [startAnim setTitle:@"start" forState:UIControlStateNormal];
//    startAnim.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:startAnim];
//    
//    [startAnim addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self testShapeLayer];
    
    UIButton* shapeLayerAnim = [[UIButton alloc] initWithFrame:CGRectMake(200, 340, 220, 40)];
    shapeLayerAnim.tag = 23;
    [shapeLayerAnim setTitle:@"shapeLayerAnim" forState:UIControlStateNormal];
    shapeLayerAnim.backgroundColor = [UIColor grayColor];
    [self.view addSubview:shapeLayerAnim];
    
    [shapeLayerAnim addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* stopAnim = [[UIButton alloc] initWithFrame:CGRectMake(0, 340, 120, 40)];
    stopAnim.tag = 24;
    [stopAnim setTitle:@"stopAnim" forState:UIControlStateNormal];
    stopAnim.backgroundColor = [UIColor grayColor];
    [self.view addSubview:stopAnim];
    
    [stopAnim addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void) onClick:(UIButton*) button{

    switch (button.tag) {
        case 23:
        {
             [self.bezierParhLayer middlePointMoveAnim];
        }
            break;
            
        case 24:{
        
            [self.bezierParhLayer stopAnim];
        
        }break;
            
        default:
            break;
    }
    //[self startCircleAnim];
    
}

-(void)startCircleAnim{

    //开始三角形旋转
    CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    BasicAnimation.toValue=@(M_PI*2);
    BasicAnimation.duration= 0.7;
    
    BasicAnimation.delegate= self;
    
    //BasicAnimation.repeatCount = MAXFLOAT;
    
    [BasicAnimation setValue:@"BasicAnimationRotation" forKey:@"animationName"];
    [self.circleLayer removeAllAnimations];
    [self.circleLayer addAnimation:BasicAnimation forKey:@"BasicAnimationRotation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if([[anim valueForKey:@"animationName"] isEqualToString:@"BasicAnimationRotation"]){
    
        
        //启动缩小动画
        CABasicAnimation *scaleSmallAnim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleSmallAnim.fromValue= [NSNumber numberWithFloat:1.0];
        scaleSmallAnim.toValue= [NSNumber numberWithFloat:0.2];
        //scaleSmallAnim.duration= 0.7;
        //scaleSmallAnim.delegate = self;
        //animation.autoreverses=NO;
        
        //animation.removedOnCompletion=NO;
        //animation.fillMode=kCAFillModeForwards;
        
        
        CABasicAnimation *scaleBigAnim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleBigAnim.fromValue= [NSNumber numberWithFloat:0.2];
        scaleBigAnim.toValue= [NSNumber numberWithFloat:1.0];
        [scaleBigAnim setDuration:0.5];
        [scaleBigAnim setBeginTime:0.5];
        
        
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];

        groupAnimation.animations = [NSArray arrayWithObjects:scaleSmallAnim,scaleBigAnim, nil];
        groupAnimation.duration = 1.0f;
        groupAnimation.delegate = self;
        //groupAnimation.repeatCount = 2;
        
        [self.circleLayer removeAllAnimations];
        
        [groupAnimation setValue:@"scaleSmall" forKey:@"animationName"];
        [self.circleLayer addAnimation:groupAnimation forKey:@"scaleSmall"];
        
    } else if([[anim valueForKey:@"animationName"] isEqualToString:@"scaleSmall"]){ //缩放之后再
    
        [self startCircleAnim];
    }
}




-(void) testShapeLayer{

    
   self.bezierParhLayer = [[ShapeLayer_BezierParh alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) / 2) - 25, 100, 100, 100)];

    //self.bezierParhLayer.backgroundColor = [UIColor wh];
    
    [self.view addSubview:self.bezierParhLayer];
    
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
