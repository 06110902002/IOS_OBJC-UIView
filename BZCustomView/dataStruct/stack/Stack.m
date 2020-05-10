//
//  Stack.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//  使用数组实现一个栈

#import "Stack.h"

@interface Stack()
@property(nonatomic,strong) NSMutableArray* array;
@property(nonatomic,assign) NSInteger size;
@end

@implementation Stack

-(instancetype) initWithSize:(NSInteger)size{
    self = [super init];
    if (self) {
        self.size = size;
        self.array = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)push:(NSObject *)e{
    if (self.array.count < self.size) {
        [self.array addObject:e];
        //NSLog(@"30------入栈元素：%@",e);
    }else{
        NSAssert([self isFull], @"栈满，不能再入栈");
    }
}
-(NSObject*) pop{
    if(self.array){
        NSObject* lastObj = self.array.lastObject;
        [self.array removeLastObject];
        return lastObj;
    }
    return nil;
}

-(BOOL) isEmpty{
    return !self.array.count;
}

-(BOOL) isFull{
    return self.array.count > self.size;
}

-(NSInteger)count{
    return self.array.count;
}

@end
