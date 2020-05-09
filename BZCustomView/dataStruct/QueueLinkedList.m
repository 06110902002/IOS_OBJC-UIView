//
//  QueueLinkedList.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/9.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "QueueLinkedList.h"
#import "LinkedList.h"

@interface QueueLinkedList ()
@property(nonatomic,assign) NSInteger first;
@property(nonatomic,assign) NSInteger last;
@property(nonatomic,assign) NSInteger size;
@property(nonatomic,strong) LinkedList* linkList;

@end

@implementation QueueLinkedList

-(instancetype)initWithSize:(NSInteger)size{
    self = [super init];
    if (self) {
        self.last = -1;
        self.first = -1;
        self.size = size;
        self.linkList = [[LinkedList alloc] init]; //创建一个链表，此处为一个头结点
        self.linkList.data = @"head";
    }
    return self;
}

-(void)enqueue:(NSObject *)e{
    if (![self isFull]) {
        LinkedList* node = [[LinkedList alloc] init];
        node.data = e;
        if (self.last == self.size - 1 || self.last == -1) {
            [self.linkList insertAfterNode:node];
            self.last = 0;
            if (self.first == -1) {
                self.first = 0;
            }
        }else{
            [self.linkList insertAfterNode:node];
            ++self.last;
        }
        NSLog(@"48---------链表b队列实现方式入队元素:%@",e);
    }else{
        NSLog(@"44----------队列已满");
    }
}

-(LinkedList*)dequeue{
    if ([self isEmpty]) {
       NSAssert(![self isEmpty], @"队列为空，不能再出队");
    }
    LinkedList* tmp = self.linkList.next;
    [self.linkList deleteNode:tmp];
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
-(void)test{
    LinkedList* p = self.linkList.next;
   while (p.next != nil) {
       
       NSObject* data = p.data;
       LinkedList* next = p.next;
       NSLog(@"65---------cur data :%@ next node:%@",data,next);
       
       p = p.next;
   }
   NSLog(@"69---------cur data :%@ next node:%@",p.data,p.next);
}


@end
