//
//  LinkedList.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/7.
//  Copyright © 2020 刘小兵. All rights reserved.
//   单链表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkedList : NSObject

@property(strong,nonatomic,nullable) LinkedList* next;
@property(strong,nonatomic,nullable) NSObject* data;

/**
 初始化链表
 */
-(instancetype) initLinkedList:(NSObject*) data next:(LinkedList*) next;


/**
 在指定结点之后插入结点
 */
-(void) insertAfterNode:(LinkedList*) indexNode;

/**
 头插法建表
 */
-(void) insertHead:(LinkedList*) node;

-(void) deleteNode:(LinkedList*) node;

@end

NS_ASSUME_NONNULL_END
