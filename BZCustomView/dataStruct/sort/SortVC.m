//
//  SortVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/14.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "SortVC.h"

@interface SortVC ()

@property(nonatomic,strong) NSMutableArray* array;

@end

@implementation SortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
       UIButton* tiguiPreTree = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 130, 30)];
       tiguiPreTree.backgroundColor = [UIColor grayColor];
       tiguiPreTree.tag = 80;
       [tiguiPreTree setTitle:@"直接插入排序" forState:UIControlStateNormal];
       [tiguiPreTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:tiguiPreTree];
    
    
          UIButton* quickSort = [[UIButton alloc] initWithFrame:CGRectMake(30, 90, 130, 30)];
          quickSort.backgroundColor = [UIColor grayColor];
          quickSort.tag = 81;
          [quickSort setTitle:@"quickSort排序" forState:UIControlStateNormal];
          [quickSort addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
          [self.view addSubview:quickSort];
}

-(void)onClick:(UIButton*)button{
    self.array = [NSMutableArray arrayWithObjects:@5,@-4,@6,@2,@9,@-4,@7,@8,@-3, nil];
    switch (button.tag) {
        case 80:{
            //[self insertSort];
            //[self selectSort];
            [self bubbleSort];
            
        }
            break;
        case 81:{
            printf("快速排序之前数组结果为：\n");
               [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                         printf(" %d",[obj intValue]);
                   }];
            [self quickSort:self.array lowIndex:0 heightIndex:self.array.count - 1];
             printf("\n快速排序之后数组结果为：\n");
            [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                  printf(" %d",[obj intValue]);
            }];
        }break;
            
        default:
            break;
    }
}

-(void)insertSort{
    printf("直接插入排序之前数组结果为：\n");
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
              printf(" %d",[obj intValue]);
        }];
    for(NSInteger i = 1; i < self.array.count; i ++){
        NSInteger num1 = [self.array[i] intValue];
        for (NSInteger j = 0; j <= i; j ++) {
            NSInteger num2 = [self.array[j] intValue];
            if(num2 > num1){
                NSInteger tmp = [self.array[i] intValue];
                self.array[i] = self.array[j];
                self.array[j] = [NSNumber numberWithInteger:tmp];
            }
        }
    }
    printf("\n直接插入排序之后数组结果为：\n");
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
           printf(" %d",[obj intValue]);
     }];
}

-(void)selectSort{
    printf("直接选择排序之前数组结果为：\n");
   [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
             printf(" %d",[obj intValue]);
       }];
   for(NSInteger i = 0; i < self.array.count - 1; i ++){
       NSInteger min = i;
       for (NSInteger j = i + 1; j < self.array.count; j ++) { //找剩余数组的最小值
           if([self.array[j] intValue] < [self.array[min] intValue]){
               min = j;
           }
       }
       NSInteger tmp = [self.array[i] intValue];
       self.array[i] = self.array[min];
       self.array[min] = [NSNumber numberWithInteger:tmp];
       
   }
   printf("\n直接选择排序之后数组结果为：\n");
   [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
          printf(" %d",[obj intValue]);
    }];
}

-(void)bubbleSort{
    printf("冒泡排序之前数组结果为：\n");
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
              printf(" %d",[obj intValue]);
        }];
    for(NSInteger i = 0; i < self.array.count - 1; i ++){
        for (NSInteger j = i + 1; j < self.array.count; j ++) {
            if([self.array[j] intValue] < [self.array[i] intValue]){
                NSInteger tmp = [self.array[i] intValue];
                self.array[i] = self.array[j];
                self.array[j] = [NSNumber numberWithInteger:tmp];
            }
        }
        
        
    }
    printf("\n冒泡排序之后数组结果为：\n");
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
           printf(" %d",[obj intValue]);
     }];
}

-(void)quickSort:(NSMutableArray*) array lowIndex:(NSInteger) low heightIndex:(NSInteger)height{
   
    NSInteger i = low;
    NSInteger j = height;
    
    while (i < j) {
        if (i < j && ([array[i] intValue] < [array[j] intValue])) {
            i++;
        }
        if (i < j && ([array[i] intValue] >= [array[j] intValue])) {
            NSInteger tmp = [self.array[i] intValue];
            self.array[i] = self.array[j];
            self.array[j] = [NSNumber numberWithInteger:tmp];
            j --;
        }
        [self quickSort:array lowIndex:low heightIndex:i-1];
        [self quickSort:array lowIndex:i + 1 heightIndex:height];
    }
    
   
}

@end
