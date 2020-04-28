//
//  ArcIndicatorVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/26.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ArcIndicatorVC.h"
#import "RectangleIndicatorView.h"
#import "CircleIndicatorView.h"

@interface ArcIndicatorVC ()
@property (strong, nonatomic)  CircleIndicatorView *circleIndicatorView;
@property (strong, nonatomic)  RectangleIndicatorView *rectangleIndicatorView;

@end

@implementation ArcIndicatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circleIndicatorView = [[CircleIndicatorView alloc] initWithFrame:CGRectMake(10, 100, 300, 400)];
    self.circleIndicatorView.maxValue = 80;
   self.circleIndicatorView.innerAnnulusValueToShowArray = @[@40, @50, @60, @70, @80];
   self.circleIndicatorView.indicatorValue = 60;
    __weak typeof(self) weakSelf = self;
    self.circleIndicatorView.minusBlock = ^{
       NSLog(@"点击了 -");
       weakSelf.circleIndicatorView.indicatorValue -= 1;
   };
   self.circleIndicatorView.addBlock = ^{
       NSLog(@"点击了 +");
       weakSelf.circleIndicatorView.indicatorValue += 1;
   };

    [self.view addSubview:self.circleIndicatorView];
}



@end
