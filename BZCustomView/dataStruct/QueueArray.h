//
//  QueueArray.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/8.
//  Copyright © 2020 刘小兵. All rights reserved.
//  队列数组实现

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QueueArray : NSObject

-(instancetype) initWithSize:(NSInteger)size;

-(void) enqueue:(NSObject*)e;


-(NSObject*) dequeue;

-(BOOL) isFull;
-(BOOL) isEmpty;

-(void) test;

@end

NS_ASSUME_NONNULL_END
