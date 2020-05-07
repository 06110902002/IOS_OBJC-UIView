//
//  LinkedList.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/7.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "LinkedList.h"

@implementation LinkedList

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data = nil;
        self.next = nil;
    }
    return self;
}

-(instancetype) initLinkedList:(NSObject*) data next:(LinkedList*) node{
    self = [super init];
    if (self) {
        self.data = data;
        self.next = node;
    }
    return self;
}

-(void) insertAfterNode:(LinkedList*) indexNode{
    
    LinkedList *head = self;
    while (head.next != nil) {
        head = head.next;
    }
    head.next = indexNode;
    indexNode.next = nil;

}

- (void)insertHead:(LinkedList *)node{
    LinkedList *head = self;
    node.next = head.next;
    head.next = node;
}

-(void)deleteNode:(LinkedList *)node{
    LinkedList *p = self.next;
    while (p.next != nil) {
        if ([p.next.data isEqual: node.data]) {
            node.next = p.next.next;
            p.next = node.next;
            break;
        }else{
            p = p.next;
        }
    }
}

@end
