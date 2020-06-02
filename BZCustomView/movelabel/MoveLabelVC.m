//
//  MoveLabelVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/10/11.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "MoveLabelVC.h"
#import "UIView+Resize.h"
#import "ScrollLabel.h"

@interface MoveLabelVC ()
@property(nonatomic,strong) UILabel* topLabel;
@property(nonatomic,strong) UILabel* label;
@property(nonatomic,strong) UILabel* bottomLabel;

@property(nonatomic,strong) UIView* textView;
@property(nonatomic,strong) UIView* textView2;
@property(nonatomic,strong) NSArray* texts;
@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) ScrollLabel* scrollLabel;

@end

@implementation MoveLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    [self initView];
}

-(void) initView{

    self.view.backgroundColor = [UIColor whiteColor];
    self.texts = [NSArray arrayWithObjects:@"香辣肉丝",@"听你讲个故事",@"听你唱首歌",
                  @"高考",@"大学",@"工作",@"生活",nil];
    
    
    UIButton* btnLabel = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, 80, 30)];
    btnLabel.backgroundColor = [UIColor grayColor];
    btnLabel.tag = 12;
    [btnLabel setTitle:@"播放" forState:UIControlStateNormal];
    [btnLabel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLabel];
    
    UIButton* btnBack = [[UIButton alloc] initWithFrame:CGRectMake(130, 40, 180, 30)];
    btnBack.backgroundColor = [UIColor grayColor];
    btnBack.tag = 13;
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    
    //跑马灯容器
    self.textView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 240, 40)];
    self.textView.backgroundColor = [UIColor grayColor];
    self.textView.clipsToBounds = true;
    [self.view addSubview:self.textView];
    
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, 180, 40)];
    self.topLabel.text = @"九阴真经";
    self.topLabel.hidden = true;
    self.topLabel.backgroundColor = [UIColor greenColor];
    //[self.textView addSubview:self.topLabel];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 40)];
    self.label.text = @"这是一行垂直的文本";
    self.label.backgroundColor = [UIColor cyanColor];
    [self.textView addSubview:self.label];
    
    
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 180, 40)];
    self.bottomLabel.text = @"哈蟆功";
    self.bottomLabel.backgroundColor = [UIColor brownColor];
    [self.textView addSubview:self.bottomLabel];
    
    //测试二
    self.textView2 = [[UIView alloc] initWithFrame:CGRectMake(30, 160, 240, 40)];
    self.textView2.backgroundColor = [UIColor grayColor];
    self.textView2.clipsToBounds = true;
    [self.view addSubview:self.textView2];
    
    self.scrollLabel = [[ScrollLabel alloc] init];
    NSMutableArray* array = [NSMutableArray arrayWithArray:self.texts];
    [self.scrollLabel setTargetView:self.textView2 withTitleArray:array];
    [self.scrollLabel setOnClickListener:^(NSString* title){
        NSLog(@"91--------:%@",title);
    }];
    
}

-(void) onClick:(UIButton*) button{

    switch (button.tag) {
            
        case 12:{
        
            [self playAnim];
            [self.scrollLabel start];
            
        }
            break;
            
        case 13:{
        
            [self dismissViewControllerAnimated:true completion:^{
        
            }];
            
        }break;
            
        default:
            break;
    }
}

-(void) playAnim{

    
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //[timer invalidate]; 取消定时器
    

}

-(void) timerAction{
    self.index ++;
    [UIView transitionWithView:self.label duration:2 * 0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.label.tx_bottom = 0;
        [UIView transitionWithView:self.label duration:2 * 0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bottomLabel.tx_y = 0;
        } completion:^(BOOL finished) {
            self.label.tx_y = self.textView.tx_height;
            UILabel *tempLabel = self.label;
            self.label = self.bottomLabel;
            self.bottomLabel = tempLabel;
        }];
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
