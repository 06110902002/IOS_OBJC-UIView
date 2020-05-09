//
//  QueueLinkedList.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/9.
//  Copyright © 2020 刘小兵. All rights reserved.
//  链表实现队列

#import <Foundation/Foundation.h>
@class LinkedList;

NS_ASSUME_NONNULL_BEGIN

@interface QueueLinkedList : NSObject

-(instancetype) initWithSize:(NSInteger)size;

-(void) enqueue:(NSObject*)e;


-(LinkedList*) dequeue;

-(BOOL) isFull;
-(BOOL) isEmpty;

-(void) test;


@end

NS_ASSUME_NONNULL_END
