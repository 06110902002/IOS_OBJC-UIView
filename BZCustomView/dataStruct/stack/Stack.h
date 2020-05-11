//
//  Stack.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//  使用数组实现一个栈

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 定义一个用作遍历栈的输出
 */
typedef void(^StackBlock)(id obj);

@interface Stack : NSObject

-(instancetype) initWithSize:(NSInteger)size;

-(void) push:(NSObject*) e;

-(NSObject*) pop;

-(BOOL) isFull;

-(BOOL) isEmpty;

-(NSInteger) count;


-(void) test;



@end

NS_ASSUME_NONNULL_END
