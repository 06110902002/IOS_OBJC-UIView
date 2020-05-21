//
//  ScrollLabel.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/21.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ScrollLabel.h"
#import "UIView+Resize.h"

@interface  ScrollLabel()
@property(nonatomic,strong)NSMutableArray* titleArray;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger index;

@end

@implementation ScrollLabel

-(instancetype) init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void) setTargetView:(UIView*) parentView withTitleArray:(NSMutableArray*)array{
    if (!parentView || !array || array.count == 0) {
        return;
    }
    self.titleArray = array;
    self.parentView = parentView;
    self.index = 0;
    
    self.upLabel = [[UIButton alloc] init];
    self.upLabel.backgroundColor = [UIColor greenColor];
    self.upLabel.tag = 21;
    [self.upLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.upLabel setTitle:[array objectAtIndex:self.index] forState:UIControlStateNormal];
    self.upLabel.frame = CGRectMake(0, 0, parentView.frame.size.width,parentView.frame.size.height);
    self.index ++;
    
    self.bottomLabel = [[UIButton alloc] init];
    self.bottomLabel.tag = 22;
    [self.bottomLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    self.bottomLabel.frame = CGRectMake(0, self.upLabel.frame.size.height, parentView.frame.size.width,parentView.frame.size.height);
    [self.bottomLabel setTitle:[array objectAtIndex:self.index] forState:UIControlStateNormal];
    self.bottomLabel.backgroundColor = [UIColor brownColor];
    
    [self.parentView addSubview:self.upLabel];
    [self.parentView addSubview:self.bottomLabel];
    
}

-(void) onClick:(UIButton*) button{
    switch (button.tag) {
        case 21:
        case 22:
            if (self.listener) {
                self.listener(button.titleLabel.text);
            }
            break;
            
        default:
            break;
    }
}
-(void) setOnClickListener:(OnClickListener)listener{
    self.listener = listener;
}


-(void) start{
    if(self.titleArray.count == 1){
        return;
    }
    
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
   
}
-(void) timerAction{
    [UIView transitionWithView:self.upLabel duration:2 * 0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.upLabel.tx_bottom = 0;
        [UIView transitionWithView:self.upLabel duration:2 * 0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bottomLabel.tx_y = 0;
        } completion:^(BOOL finished) {
            self.upLabel.tx_y = self.parentView.tx_height;
            UIButton *tempLabel = self.upLabel;
            self.upLabel = self.bottomLabel;
            self.bottomLabel = tempLabel;
            self.index ++;
            NSString* title = [self.titleArray objectAtIndex:self.index % self.titleArray.count];
            [tempLabel setTitle:title forState:UIControlStateNormal];
        }];
    } completion:^(BOOL finished){
    }];
    
}

-(void) stop{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
