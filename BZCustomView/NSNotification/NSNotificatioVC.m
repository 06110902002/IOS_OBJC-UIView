//
//  NSNotificatioVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/7/22.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "NSNotificatioVC.h"

@interface NSNotificatioVC ()

@end

@implementation NSNotificatioVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton* NSNotificatio = [[UIButton alloc] initWithFrame:CGRectMake(30, 470, 180, 30)];
   NSNotificatio.backgroundColor = [UIColor grayColor];
   NSNotificatio.tag = 55;
   [NSNotificatio setTitle:@"发送" forState:UIControlStateNormal];
   [NSNotificatio addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:NSNotificatio];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionNotification:) name:@"TestNotification" object:@1];
}

-(void)onClick:(UIButton*) button{
    //测试以送通知时 objectp为空时是否能收到通知，
    //需要理解通知的内部数据结构
    //[NSNotificationCenter.defaultCenter postNotificationName:@"TestNotification" object:nil];
    
    NSMutableArray* arr = [[NSMutableArray alloc] initWithObjects:@"a",@"b", nil];
    NSMutableString* s = [[NSMutableString alloc] initWithString:@"123"];
    void (^block)(void) = ^() {
        NSLog(@"age = %@, %@",arr[1],s);
    };

    arr[1] = @"c";
    [s appendFormat:@"%@",@"adc" ];
    block();
    NSLog(@"44--------:%@",block);
    
    
}
- (void) actionNotification: (NSNotification*)notification{
    
    NSString* message = notification.object;
    NSLog(@"36-------%@",message);
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
