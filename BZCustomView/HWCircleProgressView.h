//
//  HWCircleProgressView.h
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/7.
//  Copyright © 2018 刘小兵. All rights reserved.
//  仿华为天气圆形进度条

#import <UIKit/UIKit.h>

@interface HWCircleProgressView : UIView

@property(nonatomic,assign) NSInteger count;
@property(nonatomic,assign) float centerX,centerY;
@property(nonatomic,assign) float r,l;
@property(nonatomic,assign) float startAngle;
@property(nonatomic,assign) float stopAngle;
@property(nonatomic,assign) CGFloat actionDownX,actionDownY;


-(Boolean)updateStopAngle:(float) stopAngle;

@end
