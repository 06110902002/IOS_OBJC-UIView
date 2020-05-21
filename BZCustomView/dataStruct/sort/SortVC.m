//
//  SortVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/14.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "SortVC.h"
#import "QueueArray.h"
#import "SubStack.h"

@interface SortVC ()

@property(nonatomic,strong) NSMutableArray* array;
@property(nonatomic,strong) QueueArray* queue;

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
            //[self bubbleSort];
           // [self heapSort];
            //[self shellSort];
            [self testQQ];
            [SubStack load];
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


//-----------------堆排序
-(void) heapSort{
    
    printf("\n堆排序之前数组结果为：\n");
     [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            printf(" %d",[obj intValue]);
      }];
   [self buildHeap:self.array.count];
   for(NSInteger i = self.array.count - 1; i > 0;i --){
       NSInteger tmp = [self.array[0] intValue];
       self.array[0] = self.array[i];
       self.array[i] = [NSNumber numberWithInteger:tmp];
       [self adjustHeap:0 size:i];
   }
    
    printf("\n堆排序之后数组结果为：\n");
  [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
         printf(" %d",[obj intValue]);
   }];
}

-(void) buildHeap:(NSInteger) size{
    for(NSInteger i = size / 2; i >= 0; i --){
        [self adjustHeap:i size:size];
    }
}

-(void) adjustHeap:(NSInteger) i size:(NSInteger)size{
    NSInteger leftChild = 2 * i;
    NSInteger rightChild = 2 * i + 1;
    NSInteger tmp = 2 * i;
    if(i < size / 2){
        if(leftChild < size && self.array[leftChild] >= self.array[tmp]){
            tmp = leftChild;
        }
        if(rightChild < size && self.array[rightChild] >= self.array[tmp]){
            tmp = rightChild;
        }
        if(tmp != i){
            NSInteger t = [self.array[tmp] intValue];
            self.array[tmp] = self.array[i];
            self.array[i] = [NSNumber numberWithInteger:t];
            [self adjustHeap:tmp size:size];
        }
    }
}
//-----------f堆排序end-------------
-(void) shellSort{
    
    printf("\n希尔排序之前数组结果为：\n");
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
           printf(" %d",[obj intValue]);
     }];
    NSInteger number = self.array.count / 2;
    NSInteger i,j,tmp;
    while (number >= 1) {
        
        for (i = number; i < self.array.count; i ++) {
           tmp = [self.array[i] intValue];
           j = i - number;
           while (j >= 0 && [self.array[j] intValue] >= tmp) {
               self.array[j + number] = self.array[j];
               j = j - number;
           }
            self.array[j + number] = [NSNumber numberWithInteger:tmp];
        }
        
        number = number / 2;
    }
    printf("\n希尔排序之后数组结果为：\n");
       [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
              printf(" %d",[obj intValue]);
        }];
}


/**
 新学期开始了，小哈是小哼的新同桌(小哈是个小美女哦~)，小哼向小哈询问 QQ 号， 小哈当然不会直接告诉小哼啦，
 原因嘛你懂的。所以小哈给了小哼一串加密过的数字，同时 小哈也告诉了小哼解密规则。规则是这样的:首先将第 1 个数删除，
 紧接着将第 2 个数放到 这串数的末尾，再将第 3 个数删除并将第 4 个数放到这串数的末尾，再将第 5 个数删除...... 直到剩下最后一个数，将最后一个数也删除。按照刚才删除的顺序，把这些删除的数连在一 起就是小哈的 QQ 啦。
 现在你来帮帮小哼吧。小哈给小哼加密过的一串数是“6 3 1 7 5 8 9 2 4”。
 */
-(void) testQQ{
    self.array = [NSMutableArray arrayWithObjects:@"5",@"4",@"6",@"2",@"A",@"B",@"C", nil];
    if (!self.queue) {
        self.queue = [[QueueArray alloc] initWithSize:self.array.count];
    }
     [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
         [self.queue enqueue:obj];
         NSLog(@"249------:%d",[obj intValue]);
        }];
    NSString* cur = nil;
    NSString* next;
    while ([self.queue length] > 1) {
        cur = (NSString*)[self.queue dequeue] ;
        next =  (NSString*)[self.queue dequeue];
        NSLog(@"当前删除的元素为:%@",cur);
        [self.queue enqueue:next];

    }

    NSLog(@"最后剩下的元素为：%@",[self.queue dequeue]);

    
}

@end
