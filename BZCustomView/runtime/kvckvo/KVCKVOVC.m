//
//  KVCKVOVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/7/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "KVCKVOVC.h"
#import "Man.h"

@interface KVCKVOVC ()
@property(nullable,strong) NSTimer* timer;

@end

@implementation KVCKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* kvc = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 130, 30)];
   kvc.backgroundColor = [UIColor grayColor];
   kvc.tag = 10;
   [kvc setTitle:@"KVC" forState:UIControlStateNormal];
   [kvc addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:kvc];

   UIButton* kvo = [[UIButton alloc] initWithFrame:CGRectMake(180, 100, 180, 30)];
   kvo.backgroundColor = [UIColor grayColor];
   kvo.tag = 11;
   [kvo setTitle:@"测试KVO" forState:UIControlStateNormal];
   [kvo addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:kvo];
    
    UIButton* timer = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 130, 30)];
      timer.backgroundColor = [UIColor grayColor];
      timer.tag = 12;
      [timer setTitle:@"测试Timer" forState:UIControlStateNormal];
      [timer addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:timer];
    
    UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(180, 150, 180, 30)];
         back.backgroundColor = [UIColor grayColor];
         back.tag = 13;
         [back setTitle:@"返回" forState:UIControlStateNormal];
         [back addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
         [self.view addSubview:back];
}

-(void) onClick:(UIButton*) button{
    switch (button.tag) {
        case 10:
            [self testKVC];
            break;
            
        default:
            
        case 12:
            [self testTimer];
            break;
            
        case 13:
            [self.navigationController popViewControllerAnimated:false];
            break;
    }
}

-(void) testKVC{
    
    //使用kvc 实现字典 转模型
    Man *obj = [[Man alloc] init];
    [obj setValue:@"xiaoming" forKey:@"country"];
    NSLog(@"51-------:%@",[obj valueForKey:@"country"]);
}

-(void) kvcModel2Dict{
    
    //模型转字典
   Man* add = [Man new];
   add.country = @"China";
   add.province = @"Guang Dong";
   add.city = @"Shen Zhen";
   add.district = @"Nan Shan";
   NSArray* arr = @[@"country",@"province",@"city",@"district"];
   NSDictionary* dict = [add dictionaryWithValuesForKeys:arr]; //把对应key所有的属性全部取出来
   NSLog(@"%@",dict);
    
    //字典转模型
    NSDictionary* modifyDict = @{@"country":@"USA",@"province":@"california",@"city":@"Los angle"};
    [add setValuesForKeysWithDictionary:modifyDict];            //用key Value来修改Model的属性
    NSLog(@"country:%@  province:%@ city:%@",add.country,add.province,add.city);
}

-(void) testKVO{
    
   
}

-(void)testTimer{
    
    __weak typeof(self) weakSelf = self;
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(fire) userInfo:nil repeats:YES];

       [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)fire{
    NSLog(@"88--------");
}

- (void)viewWillDisappear:(BOOL)animated{
//    if(self.timer){
//           [self.timer invalidate];
//           self.timer = nil;
//       }
}

-(void) dealloc{
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
    NSLog(@"119------------dealloc");
}




@end
