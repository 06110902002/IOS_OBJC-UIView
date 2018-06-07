//
//  ShapeLayer_BezierParh.h
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/22.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 测试ShaperLayer + UIBezierPath绘制 画图动画  画路径动画
 */
@interface ShapeLayer_BezierParh : UIView<CAAnimationDelegate>

@property(nonatomic,strong) CAShapeLayer* leftArcLayer;
@property(nonatomic,strong) CAShapeLayer* rightArcLayer;

@property(nonatomic,strong) CAShapeLayer* leftPointLayer;
@property(nonatomic,strong) CAShapeLayer* rightPointLayer;

-(void) startAnim;

-(void) middlePointMoveAnim;

-(void) stopAnim;

@end
