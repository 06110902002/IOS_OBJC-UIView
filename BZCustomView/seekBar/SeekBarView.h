//
//  SeekBarView.h
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/13.
//  Copyright © 2018 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^OnProgress)(CGFloat);

@interface SeekBarView : UIView

@property(nonatomic,assign) CGRect viewFrame;

@property(nonatomic,assign) BOOL firstTouchInCircle;

@property(nonatomic,assign) CGFloat posX;
@property(nonatomic,assign) CGFloat posY;
@property(nonatomic,assign) CGFloat radius;

@property(nonatomic,assign) CGRect textRect;

@property(nonatomic,strong) OnProgress progerssListener;

@end
