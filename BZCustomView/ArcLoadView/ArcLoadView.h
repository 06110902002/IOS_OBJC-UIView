//
//  ArcLoadView.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArcLoadView : UIView
@property(nonatomic,strong)UIBezierPath *path;
@property(nonatomic,strong)UIView* pointView;
@property(nonatomic,strong)CAShapeLayer* pointLayer;

@property(nonatomic,assign) CGFloat screenWidth;
@property(nonatomic,assign) CGFloat screenHeight;

-(void) startAnim;

@end

NS_ASSUME_NONNULL_END
