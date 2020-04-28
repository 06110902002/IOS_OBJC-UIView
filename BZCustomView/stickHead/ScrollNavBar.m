//
//  ScrollNavBar.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollNavBar.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation ScrollNavBar

-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self initAttr];
    }
    return self;
    
}

-(void) initAttr{
    
    self.nCurIndex = 0;
    self.btnList = [NSMutableArray array];
}

-(void)iniTitles:(NSMutableArray*) titles{
    
    self.titleList = titles;
    
    self.itemWidth = SCREEN_WIDTH / [self.titleList count];
    
    [self.titleList enumerateObjectsUsingBlock:^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(idx * self.itemWidth, 0, self.itemWidth, 40.0)];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = idx;
        [button addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.btnList  addObject:button];
        
    }];
    
    //创建底部线条
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0, SCREEN_WIDTH, 0.5f)];
    lineView.backgroundColor = [UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:233.0 / 255.0 alpha:1.0];
    [self addSubview:lineView];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 40.0, self.itemWidth, 1.5f)];
    self.bottomLine.backgroundColor = [UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0];
    [self addSubview:self.bottomLine];


}


//本接口主要，创建中间滚动视图
-(void)initSegmentView:(NSMutableArray*) views{


}

-(void)onClickListener:(UIButton*) button{
    
    if(self.delegate != nil){
        [self.delegate onChangeListener:button.tag];
    }
    
    [self.segmentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * button.tag, 42.5, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
    
    
    NSValue* fromValue = [NSValue valueWithCGPoint:CGPointMake(self.nCurIndex * self.itemWidth + 0.5 * self.itemWidth,40.0)];
    NSValue* toValue = [NSValue valueWithCGPoint:CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0)];
    [self startLineMoveAnimFromValue:fromValue toValue:toValue duration:0.3];

    self.nCurIndex = button.tag;
    
    [self updateTitleBtnStatus:button.tag];
    
    self.finalPos = CGPointMake(button.tag * self.itemWidth + 0.5 * self.itemWidth, 40.0);
}

-(void) updateTitleBtnStatus:(NSInteger)idx{

    [self.btnList enumerateObjectsUsingBlock:^(UIButton* button, NSUInteger index, BOOL * _Nonnull stop) {
       
        if(idx == index){
            [button setTitleColor:[UIColor colorWithRed:118.0f / 255.0 green:198.f / 255.0 blue:192.0f / 255.0 alpha:1.0] forState:UIControlStateNormal];
            
        }else{
            [button setTitleColor:[UIColor colorWithRed:119.0 / 255.0 green:119.0 / 255.0 blue:119.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        }

    }];
}

-(void)startLineMoveAnimFromValue:(NSInteger) idx{
    
     NSValue* fromValue = [NSValue valueWithCGPoint:CGPointMake(self.nCurIndex * self.itemWidth + 0.5 * self.itemWidth,40.0)];
       NSValue* toValue = [NSValue valueWithCGPoint:CGPointMake(idx * self.itemWidth + 0.5 * self.itemWidth, 40.0)];
       [self startLineMoveAnimFromValue:fromValue toValue:toValue duration:0.3];

       self.nCurIndex = idx;
       
       [self updateTitleBtnStatus:idx];
       
       self.finalPos = CGPointMake(idx * self.itemWidth + 0.5 * self.itemWidth, 40.0);
}

//private method---线条移动启动动画
-(void) startLineMoveAnimFromValue:(id) fromValue toValue:(id) toValue  duration:(CFTimeInterval) time{
    
    self.moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    self.moveAnimation.fromValue = fromValue;
    self.moveAnimation.toValue = toValue;
    self.moveAnimation.delegate = self;
    self.moveAnimation.removedOnCompletion = NO;
    self.moveAnimation.fillMode = kCAFillModeForwards;
    self.moveAnimation.duration = time;
    
    [self.bottomLine.layer removeAllAnimations];
    [self.bottomLine.layer addAnimation:self.moveAnimation forKey:@"onStart"];
   

}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
       if([self.bottomLine.layer.animationKeys.lastObject isEqualToString:@"onStart"]){
        
           CGRect frame = self.bottomLine.frame;
           frame.origin.x = self.finalPos.x;
           self.bottomLine.frame = frame;
           
    }
}


-(void)dealloc{
   

}



-(void) updateLabelStatus:(NSNotification *)msg{
    
    
    NSDictionary* tmpInfo = [msg object];
    UIScrollView* scroll = (UIScrollView*)[tmpInfo objectForKey:@"scroll"];
    
    
    [self.bottomLine.layer removeAllAnimations];
    CGRect frame = self.bottomLine.frame;
    frame.origin.x = scroll.contentOffset.x / SCREEN_WIDTH * self.itemWidth;
    self.bottomLine.frame = frame;
    [self.bottomLine layoutIfNeeded];
    
    self.nCurIndex = scroll.contentOffset.x / SCREEN_WIDTH;
    [self updateTitleBtnStatus:self.nCurIndex];
}

@end
    
    

    
