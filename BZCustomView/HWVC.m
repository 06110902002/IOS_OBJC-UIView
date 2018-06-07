//
//  HWVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/7.
//  Copyright © 2018 刘小兵. All rights reserved.
//

#import "HWVC.h"
#import "HWCircleProgressView.h"

@interface HWVC (){
    HWCircleProgressView* progressView;
}

@end

@implementation HWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    progressView = [[HWCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    progressView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:progressView];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 460, 150, 40)];
    [btn setTitle:@"更新刻度" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void) onClick:(UIButton*) sender{
    
    [progressView updateStopAngle:240.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
