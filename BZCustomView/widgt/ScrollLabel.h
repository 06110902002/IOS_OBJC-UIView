//
//  ScrollLabel.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/21.
//  Copyright © 2020 刘小兵. All rights reserved.
//  使用Label 实现跑马灯效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OnClickListener)(NSString* title);

@interface ScrollLabel : UILabel
@property(nonatomic,strong) UIView* parentView;
@property(nonatomic,strong) UIButton* upLabel;
@property(nonatomic,strong) UIButton* bottomLabel;
@property(nonatomic,copy) OnClickListener listener;

-(void) setTargetView:(UIView*) parentView withTitleArray:(NSMutableArray*)array;

-(void) setOnClickListener:(OnClickListener)listener;

-(void) start;

-(void) stop;

@end

NS_ASSUME_NONNULL_END
