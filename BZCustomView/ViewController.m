//
//  ViewController.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ViewController.h"
#import "TestDrawRect.h"
#import "LayerDraw.h"
#import "LayerLoadingAnim.h"

#import "OppoVC.h"
#import "PointMoveByCircleVC.h"
#import "MoveLabelVC.h"
#import "HWVC.h"
#import "SeekBarVC.h"

@interface ViewController ()<CAAnimationDelegate,CALayerDelegate>

@property(nonatomic,strong) LayerLoadingAnim* layerLoadingAnim;
@property(nonatomic,strong) LayerDraw *circleLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //[self testDrawRectInView];
    
   
    
    //[self testLayerDelegateDraw];
    
    //[self testLayerLoadingAnim];
    
    //[self testLayerDraw];
    
    //[self testKeyFrameAnim];
    
    
    
    UIButton* btnOppo = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 130, 30)];
    btnOppo.backgroundColor = [UIColor grayColor];
    btnOppo.tag = 10;
    [btnOppo setTitle:@"测试oppo动画" forState:UIControlStateNormal];
    [btnOppo addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOppo];

    UIButton* btnPoint = [[UIButton alloc] initWithFrame:CGRectMake(180, 100, 180, 30)];
    btnPoint.backgroundColor = [UIColor grayColor];
    btnPoint.tag = 11;
    [btnPoint setTitle:@"测试圆点做圆周运动" forState:UIControlStateNormal];
    [btnPoint addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPoint];
    
    UIButton* btnLabel = [[UIButton alloc] initWithFrame:CGRectMake(30, 140, 180, 30)];
    btnLabel.backgroundColor = [UIColor grayColor];
    btnLabel.tag = 12;
    [btnLabel setTitle:@"移动的标签" forState:UIControlStateNormal];
    [btnLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLabel];
    
    UIButton* btnHW = [[UIButton alloc] initWithFrame:CGRectMake(230, 140, 180, 30)];
    btnHW.backgroundColor = [UIColor grayColor];
    btnHW.tag = 13;
    [btnHW setTitle:@"华为圆形进度条" forState:UIControlStateNormal];
    [btnHW addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHW];
    
    
    UIButton* btnSeekBar = [[UIButton alloc] initWithFrame:CGRectMake(230, 190, 180, 30)];
    btnSeekBar.backgroundColor = [UIColor grayColor];
    btnSeekBar.tag = 14;
    [btnSeekBar setTitle:@"SeekBar" forState:UIControlStateNormal];
    [btnSeekBar addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSeekBar];
    
    
}

-(void) onClick:(UIButton*) button{

    switch (button.tag) {
            
            case 10:{
            
                [self presentViewController:[[OppoVC alloc] init] animated:true completion:nil];
            }
            
            break;
            
            case 11:{
            
                 [self presentViewController:[[PointMoveByCircleVC alloc] init] animated:true completion:nil];
            }
            break;
            
        case 12:{
        
            [self presentViewController:[[MoveLabelVC alloc] init] animated:true completion:nil];
        }
            break;
            
        case 13:{
            
            [self presentViewController:[[HWVC alloc] init] animated:true completion:nil];
        }
            break;
            
        case 14:{
            
            [self presentViewController:[[SeekBarVC alloc] init] animated:true completion:nil];
        }
            break;
            
        default:
            break;
    }
    
}


/**
 测试UIView绘图
 */
-(void) testDrawRectInView{

    TestDrawRect* drawRectInView = [[TestDrawRect alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:drawRectInView];
}


/**
 测试CALayer绘图
 */
-(void) testLayerDraw{
    
    self.circleLayer = [LayerDraw layer];
    
    self.circleLayer.bounds = CGRectMake(0, 0, 100, 100);      // 设置层的宽高
    [self.circleLayer setNeedsDisplay];    //写这个方法才会自动触发 drawInContext：的方法
    self.circleLayer.backgroundColor = [UIColor brownColor].CGColor;
    
    [self.view.layer addSublayer: self.circleLayer];
    
    //[self startCircleAnim];

}

-(void) startCircleAnim{
    
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat width = self.layerLoadingAnim.frame.size.width * 0.65;
    CGFloat width2= width / (sqrt(3));
    
    
    CGFloat centerX = 200 ;
    CGFloat centerY = 200;
    
    CGPoint PointA = CGPointMake(centerX+(width*(2/3.0)), centerY);
    CGPoint PointB = CGPointMake(PointA.x-width, PointA.y-width2);
    CGPoint PointC = CGPointMake(PointB.x, PointB.y+2*width2);
    
    self.circleLayer.position = PointA;         // 设置层的位置
    
    CGPathMoveToPoint(path,nil,PointA.x,PointA.y);
    CGPathAddLineToPoint(path, nil, PointB.x, PointB.y);
    CGPathAddLineToPoint(path, nil, PointC.x, PointC.y);
    CGPathAddLineToPoint(path, nil, PointA.x, PointA.y);
    
    
    
    keyFramedAnimation.path = path;
    keyFramedAnimation.duration = 1.4;
    
    keyFramedAnimation.delegate = self;
    
    //keyFramedAnimation.autoreverses = NO;
    //keyFramedAnimation.repeatCount = MAXFLOAT;
    
    
    //设置每一个路径播放的速度模式
    keyFramedAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [keyFramedAnimation setValue:@"KEYFRAME" forKey:@"animationName"];
    
    [self.circleLayer removeAllAnimations];
    [ self.circleLayer addAnimation:keyFramedAnimation forKey:@"KEYFRAME"];


}



//实现动画协议
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if([[anim valueForKey:@"animationName"] isEqualToString:@"KEYFRAME"]){
        
        self.circleLayer.hidden = true;
        //开始三角形旋转
        CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        BasicAnimation.toValue=@(M_PI*2);
        BasicAnimation.duration= 0.7;
        
        BasicAnimation.delegate=self;
        [BasicAnimation setValue:@"BasicAnimationRotation" forKey:@"animationName"];
        [self.layerLoadingAnim removeAllAnimations];
        [self.layerLoadingAnim addAnimation:BasicAnimation forKey:@"BasicAnimationRotation"];
        
        
    }else if([[anim valueForKey:@"animationName"] isEqualToString:@"BasicAnimationRotation"]){      //三角形旋转停止时执行圆点动画
    
         self.circleLayer.hidden = false;
        [self startCircleAnim];
        
    }
    
}



-(void) testLayerLoadingAnim{

    LayerLoadingAnim* loadAnimLayer = [[LayerLoadingAnim alloc] init];
    
    loadAnimLayer.bounds = CGRectMake(0, 0, 100, 100);      // 设置层的宽高
    
    loadAnimLayer.position = CGPointMake(100, 100);         // 设置层的位置
    
    // 开始绘制图层
    [loadAnimLayer setNeedsDisplay];//写这个方法才会自动触发 drawInContext：的方法
    
    [self.view.layer addSublayer:loadAnimLayer];

}






/**
 测试使用CLayer的代理进行，画图，但是不能将代理设置为UIView这个对象，因为CALayer的内部默认代理就是UIView这个对象，
 如果设置会出现冲突
 */
-(void) testLayerDelegateDraw{

    
    CALayer *layer = [CALayer layer];
    // 设置层的宽高
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置层的位置
    layer.position = CGPointMake(100, 100);
    layer.delegate = self;
    // 开始绘制图层
    [layer setNeedsDisplay];//无论采取哪种方法来自定义层，都必须调用CALayer的setNeedsDisplay方法才能正常绘图。
    [self.view.layer addSublayer:layer];
    
}

//在代理方法中,,实现CALayer的代理方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);//这不填充，空心
    // 设置边框宽度
    CGContextSetLineWidth(ctx, 5);
    
    // 将矩形放到路径中
    CGContextAddRect(ctx, layer.bounds);
    
    // 绘制路径
    CGContextStrokePath(ctx);
}


/**--------------------------代理方法end---------------------------**/





/**
 测试帧动画
 */
-(void) testKeyFrameAnim{

    
    LayerLoadingAnim *layer = [LayerLoadingAnim layer];
    
    layer.bounds = CGRectMake(0, 0, 100, 100);      // 设置层的宽高
    
    layer.position = CGPointMake(200, 200);         // 设置层的位置
    
    // 开始绘制图层
    [layer setNeedsDisplay];//写这个方法才会自动触发 drawInContext：的方法
    self.layerLoadingAnim = layer;
    [self.view.layer addSublayer:layer];

    
    //开始动画
    //[self keyFramed:layer];
    //动画结束之后改变layer位置
    //layer.position = CGPointMake(layer.position.x, layer.position.y+200);
    

    
}


-(void)keyFramed:(CALayer *)layer{
    CAKeyframeAnimation *keyFramedAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
//    CGFloat x = layer.position.x;
//    CGFloat y = layer.position.y;
//    
//    //添加贝塞尔曲线路径
//    CGPathMoveToPoint(path, nil, x, y);
//    CGPathAddCurveToPoint(path, nil, x+200, y, x+200, y+100, x, y+100);
//    CGPathAddCurveToPoint(path, nil, x+200, y+100, x+200, y+200, x, y+200);
    
    
    CGFloat width = layer.frame.size.width*0.65;
    CGFloat width2=width/(sqrt(3));

    
    CGFloat centerX =layer.frame.size.width/2;
    CGFloat centerY =layer.frame.size.width/2;
    
    CGPoint PointA=CGPointMake(centerX+(width*(2/3.0)), centerY);
    CGPoint PointB=CGPointMake(PointA.x-width, PointA.y-width2);
    CGPoint PointC=CGPointMake(PointB.x, PointB.y+2*width2);
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:PointA];
//    [path addLineToPoint:PointB];
//    [path addLineToPoint:PointC];
//    
//    [path closePath];

    
    CGPathMoveToPoint(path,nil,PointA.x,PointA.y);
    CGPathAddLineToPoint(path, nil, PointB.x, PointB.y);
    CGPathAddLineToPoint(path, nil, PointC.x, PointC.y);
    CGPathAddLineToPoint(path, nil, PointA.x, PointA.y);
    
    
    
    keyFramedAnimation.path = path;
    keyFramedAnimation.duration = 1.2;
    
    
    keyFramedAnimation.autoreverses = NO;
    keyFramedAnimation.repeatCount = MAXFLOAT;
    //keyFramedAnimation.timingFunctions = [NSArray arrayWithObjects:kCAMediaTimingFunctionLinear,nil];
    
    
    //设置每一个路径播放的速度模式
    keyFramedAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    
    [layer addAnimation:keyFramedAnimation forKey:@"KEYFRAME"];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
