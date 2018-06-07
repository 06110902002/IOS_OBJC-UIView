//
//  ShapeLayer_BezierParh.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ShapeLayer_BezierParh.h"

#define PI 3.1415926

@implementation ShapeLayer_BezierParh


-(instancetype) initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self.layer addSublayer:self.leftArcLayer];
        [self.layer addSublayer:self.rightArcLayer];
        [self.layer addSublayer:self.leftPointLayer];
        [self.layer addSublayer:self.rightPointLayer];
    }
    
    return self;

}


/**
 重写get属性

 @return CAShapeLayer
 */
-(CAShapeLayer*) leftArcLayer{


    if (!_leftArcLayer) {
        _leftArcLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path addArcWithCenter:center radius:25 startAngle: -PI / 2 endAngle:PI / 2 clockwise:YES];
        
        
        _leftArcLayer.borderColor = [UIColor blackColor].CGColor;
        _leftArcLayer.lineWidth = 1.f;
        _leftArcLayer.path = path.CGPath;
        _leftArcLayer.fillColor = [UIColor clearColor].CGColor;
        _leftArcLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    return _leftArcLayer;
    
}


-(CAShapeLayer*) rightArcLayer{
    
    
    if (!_rightArcLayer) {
        _rightArcLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path addArcWithCenter:center radius:25 startAngle: PI / 2 endAngle:-PI / 2 clockwise:YES];
        
        
        _rightArcLayer.borderColor = [UIColor blackColor].CGColor;
        _rightArcLayer.lineWidth = 1.f;
        _rightArcLayer.path = path.CGPath;
        _rightArcLayer.fillColor = [UIColor clearColor].CGColor;
        _rightArcLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    return _rightArcLayer;
    
}


-(CAShapeLayer*) leftPointLayer{

    if (!_leftPointLayer) {
        _leftPointLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);

        _leftPointLayer.bounds = CGRectMake(0, 0, 2, 2);
        _leftPointLayer.position = center;
        _leftPointLayer.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _leftPointLayer;
}

-(CAShapeLayer*) rightPointLayer{
    
    if (!_rightPointLayer) {
        _rightPointLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        _rightPointLayer.bounds = CGRectMake(0, 0, 2, 2);
        _rightPointLayer.position = center;
        _rightPointLayer.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _rightPointLayer;
}


-(void) startAnim{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.7f;
    animation.fromValue = @(1);
    animation.toValue = @(0.0);
    //animation.delegate = self;
    //animation.repeatCount = MAXFLOAT;
    
    // 保持动画结束时的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:@"arcRotateAnim" forKey:@"animationName"];
    
    [self.leftArcLayer addAnimation:animation forKey:@""];
    [self.rightArcLayer addAnimation:animation forKey:@""];
    
    
    //画布旋转动画
    CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    BasicAnimation.toValue=@(M_PI*2);
    BasicAnimation.duration= 0.7;
    
    BasicAnimation.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [BasicAnimation setValue:@"BasicAnimationRotation" forKey:@"animationName"];
    [self.layer removeAllAnimations];
    [self.layer addAnimation:BasicAnimation forKey:@"BasicAnimationRotation"];

    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self middlePointMoveAnim];
        
    });

}

-(void) middlePointMoveAnim{

    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    moveAnim.fromValue = [NSValue valueWithCGPoint:center];
    moveAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(center.x , center.y  - 25)];
    moveAnim.duration = 0.5f;
    moveAnim.delegate = self;
    
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.removedOnCompletion = NO;
    
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //[self.leftPointLayer removeAllAnimations];
    [moveAnim setValue:@"positionAnimation" forKey:@"moveAnim"];
    [self.leftPointLayer addAnimation:moveAnim forKey:@""];
    
    
    
    CABasicAnimation *moveRightAnim = [CABasicAnimation animationWithKeyPath:@"position"];
   
    moveRightAnim.fromValue = [NSValue valueWithCGPoint:center];
    moveRightAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(center.x , center.y  + 25)];
    moveRightAnim.duration = 0.5f;
    //moveRightAnim.delegate = self;
    moveRightAnim.fillMode = kCAFillModeForwards;
    moveRightAnim.removedOnCompletion = NO;
    moveRightAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //[self.rightPointLayer removeAllAnimations];
    [self.rightPointLayer addAnimation:moveRightAnim forKey:@""];

}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if([[anim valueForKey:@"animationName"] isEqualToString:@"arcRotateAnim"]){
    
        if(flag){
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
               [self middlePointMoveAnim];
                
            });
        }
        
        
    }
    else if([[anim valueForKey:@"moveAnim"] isEqualToString:@"positionAnimation"]){

        if(flag){
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self startAnim];
                
            });

        }
        
    }

}

-(void) stopAnim{

    
    for (CALayer* layer in self.layer.sublayers){
    
        [layer removeAllAnimations];
    }
    
    [self.layer removeAllAnimations];
    
    

}




@end
