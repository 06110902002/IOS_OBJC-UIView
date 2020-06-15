//
//  CopyVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/6/2.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "CopyVC.h"

@interface CopyVC ()

@end

@implementation CopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton* noMutable = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 180, 30)];
    noMutable.backgroundColor = [UIColor grayColor];
    noMutable.tag = 15;
    [noMutable setTitle:@"不可变对象拷贝" forState:UIControlStateNormal];
    [noMutable addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noMutable];
    
    UIButton* Mutable = [[UIButton alloc] initWithFrame:CGRectMake(195, 50, 180, 30)];
    Mutable.backgroundColor = [UIColor grayColor];
    Mutable.tag = 16;
    [Mutable setTitle:@"可变对象拷贝" forState:UIControlStateNormal];
    [Mutable addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Mutable];
    
    
    UIButton* setCopy = [[UIButton alloc] initWithFrame:CGRectMake(195, 90, 180, 30)];
   setCopy.backgroundColor = [UIColor grayColor];
   setCopy.tag = 17;
   [setCopy setTitle:@"集合对象拷贝" forState:UIControlStateNormal];
   [setCopy addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:setCopy];
}

-(void)onClick:(UIButton*)button{
    switch (button.tag) {
        case 15:
            [self noMutableNSStringTest];
            break;
            
        case 16:
           [self mutable];
           break;
            
        case 17:
            [self noMutabArray];
            break;
            
        default:
            break;
    }
}


/**
 1、非集合对象的copy与mutableCopy
 1.1 不可变对象NSString
   
  str1、str2地址相同并且与str3地址不同，NSString的copy是浅拷贝，且copy返回的对象是不可变对象；
  mutableCopy是深拷贝。
 */
- (void) noMutableNSStringTest{
    NSString *str1 = @"test001";
    
    NSMutableString *str2 = [str1 copy];
    //copy返回的是不可变对象，str2不能被修改，因此会发生崩溃
    //[str2 appendString:@"test"];
    NSMutableString *str3 = [str1 mutableCopy];
    [str3 appendString:@"modify"];
    
    NSLog(@"str1:%p - %@ \r\n",str1,str1);
    NSLog(@"str2:%p - %@ \r\n",str2,str2);
    NSLog(@"str3:%p - %@ \r\n",str3,str3);
}

/**
 mstr1、mstr2、mstr3 地址都不同，NSMutableString对象copy与mutableCopy都是深拷贝，且copy返回的对象是不可变对象。
 */
-(void) mutable{
    
    NSMutableString *mstr1 = [NSMutableString stringWithString:@"test002"];
    
    NSMutableString *mstr2 = [mstr1 copy];
    //copy返回的是不可变对象，mstr2不能被修改，因此会发生崩溃
    //[str2 appendString:@"test"];
    
    NSMutableString *mstr3 = [mstr1 mutableCopy];
    [mstr3 appendString:@"modify"];
    
    NSLog(@"mstr1:%p - %@ \r\n",mstr1,mstr1);
    NSLog(@"mstr2:%p - %@ \r\n",mstr2,mstr2);
    NSLog(@"mstr3:%p - %@ \r\n",mstr3,mstr3);
    
}

/**
 test 不可变对象NSArray:
 arry1、arry2 地址一样，arr3 地址不一样，NSArray的copy是浅拷贝，且copy返回的对象是不可变对象；
 mutableCopy是深拷贝。
 */
-(void) noMutabArray{
    
    NSArray *arry1 = [[NSArray alloc] initWithObjects:@"value1", @"value2",nil];
       
       NSArray *arry2 = [arry1 copy];
       NSArray *arry3 = [arry1 mutableCopy];
       
       NSLog(@"arry1:%p - %@ \r\n",arry1,arry1);
       NSLog(@"arry2:%p - %@ \r\n",arry2,arry2);
       NSLog(@"arry3:%p - %@ \r\n",arry3,arry3);
}

/**
 可变对象NSMutableArray
 marry1、marry2、marr3 地址都不一样，NSMutableArray对象copy与mutableCopy都是深拷贝，且copy返回的对象是不可变对象。
 */
- (void) NSMutableArrayTest{
    NSMutableArray *marry1 = [[NSMutableArray alloc] initWithObjects:@"value1", @"value2",nil];
    
    NSMutableArray *marry2 = [marry1 copy];
    
    //copy返回的是不可变对象，marry2不能被修改，因此会崩溃
    //[marry2 addObject:@"value3"];
    
    NSMutableArray *marry3 = [marry1 mutableCopy];
    
    NSLog(@"marry1:%p - %@ \r\n",marry1,marry1);
    NSLog(@"marry2:%p - %@ \r\n",marry2,marry2);
    NSLog(@"marry3:%p - %@ \r\n",marry3,marry3);
}



@end
