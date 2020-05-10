//
//  DataStructVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/7.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "DataStructVC.h"
#import "LinkedList.h"
#import "QueueArray.h"
#import "QueueLinkedList.h"
#import "Stack.h"
#import "StackGame.h"

@interface DataStructVC ()
@property(nonatomic,strong)LinkedList* head;
@property(nonatomic,assign) NSInteger i;
@property(nonatomic,strong) QueueArray* queue;
@property(nonatomic,strong) QueueLinkedList* Linkqueue;
@property(nonatomic,strong) Stack* stack;
@property(nonatomic,strong) StackGame* game;

@end

@implementation DataStructVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* linked = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 100, 30)];
    linked.text = @"链表";
    linked.backgroundColor = [UIColor grayColor];
    [self.view addSubview:linked];
    
    UIButton* btnOppo = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 130, 30)];
    btnOppo.backgroundColor = [UIColor grayColor];
    btnOppo.tag = 10;
    [btnOppo setTitle:@"初始化链表" forState:UIControlStateNormal];
    [btnOppo addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOppo];
    
    UIButton* next = [[UIButton alloc] initWithFrame:CGRectMake(170, 100, 130, 30)];
    next.backgroundColor = [UIColor grayColor];
    next.tag = 11;
    [next setTitle:@"下一个结点" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    UIButton* add = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 130, 30)];
    add.backgroundColor = [UIColor grayColor];
    add.tag = 12;
    [add setTitle:@"add结点" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    UIButton* delete = [[UIButton alloc] initWithFrame:CGRectMake(170, 150, 130, 30)];
    delete.backgroundColor = [UIColor grayColor];
    delete.tag = 13;
    [delete setTitle:@"删除结点" forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delete];
    
    UIButton*  reverse = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 130, 30)];
    reverse.backgroundColor = [UIColor grayColor];
    reverse.tag = 14;
    [reverse setTitle:@"就地逆置" forState:UIControlStateNormal];
    [reverse addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reverse];
    
    UILabel* queenLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 240, 100, 30)];
    queenLabel.text = @"队列";
    queenLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:queenLabel];
    
    UIButton*  queenArray = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 130, 30)];
   queenArray.backgroundColor = [UIColor grayColor];
   queenArray.tag = 34;
   [queenArray setTitle:@"队列数组实现" forState:UIControlStateNormal];
   [queenArray addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:queenArray];
    
    UIButton*  queenArrayIn = [[UIButton alloc] initWithFrame:CGRectMake(30, 340, 130, 30)];
    queenArrayIn.backgroundColor = [UIColor grayColor];
    queenArrayIn.tag = 35;
    [queenArrayIn setTitle:@"队列数组in" forState:UIControlStateNormal];
    [queenArrayIn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queenArrayIn];
    
    UIButton*  queenArrayOut = [[UIButton alloc] initWithFrame:CGRectMake(30, 380, 130, 30)];
    queenArrayOut.backgroundColor = [UIColor grayColor];
    queenArrayOut.tag = 36;
    [queenArrayOut setTitle:@"队列数组Out" forState:UIControlStateNormal];
    [queenArrayOut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queenArrayOut];
    
    
  UIButton*  queenLinked = [[UIButton alloc] initWithFrame:CGRectMake(170, 300, 130, 30)];
  queenLinked.backgroundColor = [UIColor grayColor];
  queenLinked.tag = 37;
  [queenLinked setTitle:@"队列链表实现" forState:UIControlStateNormal];
  [queenLinked addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:queenLinked];
    
    
    UIButton*  queenLinkIn = [[UIButton alloc] initWithFrame:CGRectMake(170, 340, 130, 30)];
    queenLinkIn.backgroundColor = [UIColor grayColor];
    queenLinkIn.tag = 38;
    [queenLinkIn setTitle:@"队列链表in" forState:UIControlStateNormal];
    [queenLinkIn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queenLinkIn];
    
    UIButton*  queenLinkOut = [[UIButton alloc] initWithFrame:CGRectMake(170, 380, 130, 30)];
    queenLinkOut.backgroundColor = [UIColor grayColor];
    queenLinkOut.tag = 39;
    [queenLinkOut setTitle:@"队列链表Out" forState:UIControlStateNormal];
    [queenLinkOut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queenLinkOut];
    
    
    UIButton*  stack = [[UIButton alloc] initWithFrame:CGRectMake(170, 430, 130, 30)];
    stack.backgroundColor = [UIColor grayColor];
    stack.tag = 50;
    [stack setTitle:@"栈实现" forState:UIControlStateNormal];
    [stack addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stack];
      
      
      UIButton*  stackIn = [[UIButton alloc] initWithFrame:CGRectMake(170, 470, 130, 30)];
      stackIn.backgroundColor = [UIColor grayColor];
      stackIn.tag = 51;
      [stackIn setTitle:@"入栈" forState:UIControlStateNormal];
      [stackIn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:stackIn];
      
      UIButton*  stackOut = [[UIButton alloc] initWithFrame:CGRectMake(170, 510, 130, 30)];
      stackOut.backgroundColor = [UIColor grayColor];
      stackOut.tag = 52;
      [stackOut setTitle:@"出栈" forState:UIControlStateNormal];
      [stackOut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:stackOut];
    
    UIButton*  stackGamebtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 550, 130, 30)];
    stackGamebtn.backgroundColor = [UIColor grayColor];
    stackGamebtn.tag = 53;
    [stackGamebtn setTitle:@"栈迷宫游戏" forState:UIControlStateNormal];
    [stackGamebtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stackGamebtn];

}
-(void)onClick:(UIButton*) button{
    switch (button.tag) {
            
        case 10:{
            [self initLinkList];
        }
            break;
            
        case 11:{
            
            LinkedList* p = self.head.next;
            while (p.next != nil) {
                
                NSObject* data = p.data;
                LinkedList* next = p.next;
                NSLog(@"47---------cur data :%@ next node:%@",data,next);
                
                p = p.next;
            }
            NSLog(@"47---------cur data :%@ next node:%@",p.data,p.next);
        }
            break;
            
        case 12:{
            self.i ++;
            NSString* data = [NSString stringWithFormat:@"p%ld",self.i];
            LinkedList* node = [self buildNode];
            node.data = data;
            [self.head insertAfterNode:node];
            //[self.head insertHead:node];
            
            //node.next = self.head.next;
            //self.head.next = node;
            
            

        }break;
            
        case 13:{
            LinkedList* node = [self buildNode];
            node.data = @"p0";
            [self.head deleteNode:node];
        }break;
            
        case 14:{
            
            LinkedList* p = [self reverseList:self.head];
            while (p.next != nil) {
                NSObject* data = p.data;
                LinkedList* next = p.next;
                NSLog(@"109---------cur data :%@ next node:%@",data,next);
                p = p.next;
            }
            
        }break;
            
        case 34:{
            [self initQueue];
            
        }break;
            
        case 35:{
            [self arrayIn];
            
        }break;
            
            case 36:{
                [self arrayOut];
                
            }break;
            
            
        case 37:{
            [self initLinkQueue];
               
           }break;
                   
       case 38:{
           [self arrayLinkQueueIn];
           
       }break;
                   
       case 39:{
           [self arrayLinkOut];
           
       }break;
            
        case 50:{
            [self initStack];
        }
            break;
        case 51:{
            [self pushStack];
        }break;
         case 52:{
             [self popStack];
         }break;
            
        case 53:{
            self.game = [[StackGame alloc] init];
            [self.game queryPath];
            
        }break;
            
        default:
            break;
    }
}

-(void) initLinkList{
    self.head = [self buildNode]; //创建一个头结点
    LinkedList* tmpNode = [self buildNode];
    tmpNode.data = @"p0";
    self.head.next = tmpNode;
    self.head.data = @"head";
}

-(LinkedList*) buildNode{
    return [[LinkedList alloc] init];
}

-(LinkedList*)reverseList:(LinkedList*) listNode{
    LinkedList* resultList = [self buildNode];
    resultList.next = listNode;
    LinkedList* p = listNode;
    LinkedList* pNext = p.next;
    while (pNext != nil){
        p.next = pNext.next;
        pNext.next = resultList.next;
        resultList.next = pNext;
        pNext = p.next;
    }
    return resultList.next;
}



//-----------队列数组实现相关
-(void) initQueue{
    self.queue = [[QueueArray alloc] initWithSize:5];
}
-(void) arrayIn{
    if (!self.queue) {
        return;
    }
    [self.queue enqueue:[NSString stringWithFormat:@"A_%ld",self.i++]];
}
-(void) arrayOut{
    if (!self.queue) {
           return;
       }
    @try {
        NSObject* obj = [self.queue dequeue];
           NSLog(@"215----------出队元素:%@",obj);
           [self.queue test];
    } @catch (NSException *exception) {
        NSLog(@"223------%@",exception);
    } @finally {
        
    }
   
}


//队列链表实现
-(void) initLinkQueue{
    self.Linkqueue = [[QueueLinkedList alloc] initWithSize:5];
}

-(void) arrayLinkQueueIn{
    if (!self.Linkqueue) {
        return;
    }
    [self.Linkqueue enqueue:[NSString stringWithFormat:@"A_%ld",self.i++]];
}

-(void) arrayLinkOut{
    if (!self.Linkqueue) {
           return;
       }
    @try {
        LinkedList* obj = [self.Linkqueue dequeue];
           NSLog(@"266----------链表出队元素:%@",obj.data);
           [self.Linkqueue test];
    } @catch (NSException *exception) {
        NSLog(@"269------%@",exception);
    } @finally {
        
    }
   
}

/**---------------栈------------*/
-(void) initStack{
    if (!self.stack) {
        self.stack = [[Stack alloc] initWithSize:5];
    }
}

-(void) pushStack{
    if (self.stack) {
        @try {
           [self.stack push:[NSString stringWithFormat:@"A_%ld",self.i++]];

        } @catch (NSException *exception) {
            NSLog(@"341------:%@",exception);
        } @finally {
            
        }
    }
}

-(void) popStack{
    if (self.stack) {
        NSObject* e = [self.stack pop];
        NSLog(@"344-----------出栈元素：%@  栈空：%d  栈长度L:%ld",e,[self.stack isEmpty],[self.stack count]);
    
    }
}



@end
