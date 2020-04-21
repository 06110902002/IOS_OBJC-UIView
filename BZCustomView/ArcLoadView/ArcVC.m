//
//  ArcVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ArcVC.h"
#import "ArcLoadView.h"

@interface ArcVC ()


@end

@implementation ArcVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    ArcLoadView* loadView = [[ArcLoadView alloc] initWithFrame:CGRectMake(00, 100, 400, 400)];
    loadView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:loadView];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));

    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [loadView startAnim];
    });
    
    
    
    UIButton* btnAnim = [[UIButton alloc] initWithFrame:CGRectMake(180, 540, 180, 30)];
       btnAnim.backgroundColor = [UIColor grayColor];
       btnAnim.tag = 13;
       [btnAnim setTitle:@"播放动画" forState:UIControlStateNormal];
       [btnAnim addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:btnAnim];
    

}
-(void) onClick:(UIButton*) button{
    
}

@end
