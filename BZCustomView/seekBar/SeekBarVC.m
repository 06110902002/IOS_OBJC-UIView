//
//  SeekBarVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/13.
//  Copyright © 2018 刘小兵. All rights reserved.
//

#import "SeekBarVC.h"
#import "SeekBarView.h"

@interface SeekBarVC ()

@end

@implementation SeekBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    self.seekBarView = [[SeekBarView alloc] initWithFrame:CGRectMake(20, 100, 350, 100)];
    self.seekBarView.backgroundColor = [UIColor grayColor];
    [self.seekBarView setProgerssListener:^void(CGFloat proregss){
        NSLog(@"27-----------:%f",proregss);
    }];
    
    [self.view addSubview:self.seekBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
