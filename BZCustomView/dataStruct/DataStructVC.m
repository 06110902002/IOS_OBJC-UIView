//
//  DataStructVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/7.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "DataStructVC.h"
#import "LinkedList.h"

@interface DataStructVC ()
@property(nonatomic,strong)LinkedList* head;
@property(nonatomic,assign) NSInteger i;

@end

@implementation DataStructVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    UIButton*  reverse = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, 130, 30)];
    reverse.backgroundColor = [UIColor grayColor];
    reverse.tag = 14;
    [reverse setTitle:@"就地逆置" forState:UIControlStateNormal];
    [reverse addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reverse];

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
            //[self.head insertAfterNode:node];
            [self.head insertHead:node];
            
            //node.next = self.head.next;
            //self.head.next = node;
            
            

        }break;
            
        case 13:{
            LinkedList* node = [self buildNode];
            node.data = @"p2";
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



@end
