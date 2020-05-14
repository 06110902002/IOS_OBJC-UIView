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


/// 弹出栈顶元素，弹出之后在原栈中删除此元素
-(NSObject*) pop;

-(BOOL) isFull;

-(BOOL) isEmpty;

-(NSInteger) count;

-(void) test;


/// 取栈顶元素，但不在原栈中删除
-(NSObject*) top;



@end

NS_ASSUME_NONNULL_END
