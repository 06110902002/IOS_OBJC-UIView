//
//  QueueArray.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/8.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "QueueArray.h"

@interface QueueArray ()
@property(nonatomic,assign) NSInteger first;
@property(nonatomic,assign) NSInteger last;
@property(nonatomic,assign) NSInteger size;
@property(nonatomic,strong) NSMutableArray* array;

@end

@implementation QueueArray

-(instancetype)initWithSize:(NSInteger)size{
    self = [super init];
    if (self) {
        self.last = -1;
        self.first = -1;
        self.size = size;
        self.array = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)enqueue:(NSObject *)e{
    if (![self isFull]) {
        if (self.last == self.size - 1 || self.last == -1) {
            [self.array addObject:e];
            self.last = 0;
            if (self.first == -1) {
                self.first = 0;
            }
        }else{
            [self.array addObject:e];
            ++self.last;
        }
    }else{
        NSLog(@"44----------队列已满");
    }
}

-(NSObject*)dequeue{
    if ([self isEmpty]) {
       NSAssert(![self isEmpty], @"队列为空，不能再出队");
    }
    NSObject* tmp = [self.array objectAtIndex:0];
    [self.array removeObjectAtIndex:0];
    if(self.first == self.last){
        self.first = -1;
        self.last = -1;
    }else if (self.first == self.size - 1){
        self.first = 0;
    }else{
        self.first ++;
    }
    return tmp;
}

-(BOOL)isFull{
    return (self.first == 0 && self.last == self.size - 1) || self.first == self.last + 1;
}
- (BOOL)isEmpty{
    return self.first == -1;
}

-(void) test{
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSLog(@"68---------队列余下元素:%@  index:%ld",obj,idx);
    }];
    
    
}

@end
