//
//  MoveLabelVC.m
//  BZCustomView
//
//  Created by 刘小兵 on 2017/10/11.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "MoveLabelVC.h"

@interface MoveLabelVC ()
@property(nonatomic,strong) UILabel* topLabel;
@property(nonatomic,strong) UILabel* label;
@property(nonatomic,strong) UILabel* bottomLabel;

@property(nonatomic,strong) UIView* textView;
@property(nonatomic,strong) NSArray* texts;

@end

@implementation MoveLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

-(void) initView{

    self.view.backgroundColor = [UIColor whiteColor];
    self.texts = [NSArray arrayWithObjects:@"九阴真经",@"降龙十八掌",@"哈蟆功", nil];
    
    
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
    self.textView = [[UIView alloc] initWithFrame:CGRectMake(30, 200, 240, 80)];
    self.textView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textView];
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, 180, 40)];
    self.topLabel.text = @"九阴真经";
    self.topLabel.hidden = true;
    self.topLabel.backgroundColor = [UIColor greenColor];
    [self.textView addSubview:self.topLabel];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 180, 40)];
    self.label.text = @"这是一行垂直的文本";
    self.label.backgroundColor = [UIColor cyanColor];
    [self.textView addSubview:self.label];
    
    
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 180, 40)];
    self.bottomLabel.text = @"哈蟆功";
    self.bottomLabel.hidden = true;
    self.bottomLabel.backgroundColor = [UIColor brownColor];
    [self.textView addSubview:self.bottomLabel];
}

-(void) onClick:(UIButton*) button{

    switch (button.tag) {
            
        case 12:{
        
            [self playAnim];
            
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

    int x = arc4random() % 3;
    self.label.text = self.texts[x];
    
    
    
    for(UIView* tmpView in self.textView.subviews){
        
        if(tmpView.frame.origin.y == -40){
            
            tmpView.hidden = false;
            [self playMoveAnimWith:tmpView toYpos:20 duration:0.7f animName:@"topAnim"];
            
        }else if (tmpView.frame.origin.y == 20){
            
            tmpView.hidden = true;
            [self playMoveAnimWith:tmpView toYpos:80 duration:0.7f animName:@"middleAnim"];
            
        }else if (tmpView.frame.origin.y == 80){
            
            tmpView.hidden = true;
            [self playMoveAnimWith:tmpView toYpos:-40 duration:0.7f animName:@"bottomAnim"];
        }
        
    }
    
}






/**
 播放标签移动动画

 @param label 待移动的视图
 @param yPos 移动到的目标位置
 @param duration 持久度
 @param name 动画名
 */
-(void) playMoveAnimWith:(UIView*) label toYpos: (CGFloat)yPos duration:(NSTimeInterval)duration animName:(NSString*) name{

    
    CGRect frame = label.frame;

    [UIView beginAnimations:name context:NULL];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onEndAnim:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //    [UIView setAnimationRepeatAutoreverses:NO];
    //    [UIView setAnimationRepeatCount:MAXFLOAT];
    
    
    frame.origin.y = yPos;
    label.frame = frame;
    
    [UIView commitAnimations];
    
}


-(void)onEndAnim:(NSString*) animId{
    
    if ([animId  isEqual: @"topAnim"]){
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
