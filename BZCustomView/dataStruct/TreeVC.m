//
//  TreeVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "TreeVC.h"
#import "BinaryTree.h"
#import "TreeNode.h"


typedef NS_OPTIONS(NSUInteger, OPT_TYPE) {
    TIGUI_PRE =   1,
    TIGUI_IN =    2,
    TIGUI_POST =  3,
    NO_TIGUI_PRE =   4,
    NO_TIGUI_IN =    5,
    NO_TIGUI_POST =  6,
    BFS =7,
    MAX_DEPTH = 8,
    MIN_DEPTH = 9,
    SEARCH_LEVEL = 10,
    INSERT = 11,
    DELETE = 12,
};

@interface TreeVC ()
@property(nonatomic,strong) BinaryTree* tree;
@property(nonatomic,assign) NSInteger i;
@property(nonatomic,strong) TreeNode* testRoot;

@end

@implementation TreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* tiguiPreTree = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 130, 30)];
    tiguiPreTree.backgroundColor = [UIColor grayColor];
    tiguiPreTree.tag = 70;
    [tiguiPreTree setTitle:@"递归前序" forState:UIControlStateNormal];
    [tiguiPreTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiguiPreTree];
    
    UIButton* tiguiInTree = [[UIButton alloc] initWithFrame:CGRectMake(30, 90, 130, 30)];
    tiguiInTree.backgroundColor = [UIColor grayColor];
    tiguiInTree.tag = 71;
    [tiguiInTree setTitle:@"递归中序" forState:UIControlStateNormal];
    [tiguiInTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiguiInTree];
    
    UIButton* tiguiPostTree = [[UIButton alloc] initWithFrame:CGRectMake(30, 130, 130, 30)];
    tiguiPostTree.backgroundColor = [UIColor grayColor];
    tiguiPostTree.tag = 72;
    [tiguiPostTree setTitle:@"递归后序" forState:UIControlStateNormal];
    [tiguiPostTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiguiPostTree];
    
    
    UIButton* NOtiguiPreTree = [[UIButton alloc] initWithFrame:CGRectMake(170, 50, 130, 30)];
    NOtiguiPreTree.backgroundColor = [UIColor grayColor];
    NOtiguiPreTree.tag = 73;
    [NOtiguiPreTree setTitle:@"非递归前序" forState:UIControlStateNormal];
    [NOtiguiPreTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NOtiguiPreTree];
    
    UIButton* NOtiguiInTree = [[UIButton alloc] initWithFrame:CGRectMake(170, 90, 130, 30)];
    NOtiguiInTree.backgroundColor = [UIColor grayColor];
    NOtiguiInTree.tag = 74;
    [NOtiguiInTree setTitle:@"非递归中序" forState:UIControlStateNormal];
    [NOtiguiInTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NOtiguiInTree];
    
    UIButton* NOtiguiPostTree = [[UIButton alloc] initWithFrame:CGRectMake(170, 130, 130, 30)];
    NOtiguiPostTree.backgroundColor = [UIColor grayColor];
    NOtiguiPostTree.tag = 75;
    [NOtiguiPostTree setTitle:@"非递归后序" forState:UIControlStateNormal];
    [NOtiguiPostTree addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:NOtiguiPostTree];
    
    UIButton* bfs = [[UIButton alloc] initWithFrame:CGRectMake(30, 170, 130, 30)];
   bfs.backgroundColor = [UIColor grayColor];
   bfs.tag = 76;
   [bfs setTitle:@"广度优先遍历" forState:UIControlStateNormal];
   [bfs addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:bfs];
    
    UIButton* maxDepth = [[UIButton alloc] initWithFrame:CGRectMake(30, 210, 130, 30)];
    maxDepth.backgroundColor = [UIColor grayColor];
    maxDepth.tag = 77;
    [maxDepth setTitle:@"树最大深度" forState:UIControlStateNormal];
    [maxDepth addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maxDepth];
    
    UIButton* minDepth = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, 130, 30)];
    minDepth.backgroundColor = [UIColor grayColor];
    minDepth.tag = 78;
    [minDepth setTitle:@"树最小深度" forState:UIControlStateNormal];
    [minDepth addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:minDepth];
    
    UIButton* searchLevel = [[UIButton alloc] initWithFrame:CGRectMake(30, 290, 130, 30)];
    searchLevel.backgroundColor = [UIColor grayColor];
    searchLevel.tag = 79;
    [searchLevel setTitle:@"树逐层访问" forState:UIControlStateNormal];
    [searchLevel addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchLevel];
    
    UIButton* insertNode = [[UIButton alloc] initWithFrame:CGRectMake(170, 170, 130, 30)];
    insertNode.backgroundColor = [UIColor grayColor];
    insertNode.tag = 80;
    [insertNode setTitle:@"树插入结点" forState:UIControlStateNormal];
    [insertNode addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insertNode];
    
    UIButton* deleteNode = [[UIButton alloc] initWithFrame:CGRectMake(170, 210, 130, 30)];
       deleteNode.backgroundColor = [UIColor grayColor];
       deleteNode.tag = 81;
       [deleteNode setTitle:@"树删除结点" forState:UIControlStateNormal];
       [deleteNode addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:deleteNode];
    
    
}
-(void) onClick:(UIButton*) button{
    switch (button.tag) {
        case 70:
            [self printTree:TIGUI_PRE];
            break;
            
        case 71:
             [self printTree:TIGUI_IN];
            break;
            
        case 72:
            [self printTree:TIGUI_POST];
        break;
            
        case 73:
            [self printTree:NO_TIGUI_PRE];
            break;
            
        case 74:
             [self printTree:NO_TIGUI_IN];
            break;
            
        case 75:
            [self printTree:NO_TIGUI_POST];
        break;
            
        case 76:
            [self printTree:BFS];
            break;
        
        case 77:
            [self printTree:MAX_DEPTH];
            break;
        case 78:
           [self printTree:MIN_DEPTH];
           break;
            
        case 79:
            [self printTree:SEARCH_LEVEL];
        break;
            
        case 80:
            [self printTree:INSERT];
        break;
        case 81:
           [self printTree:DELETE];
        break;
                       
        default:
            break;
    }
}
-(void) printTree:(OPT_TYPE) type{
    if(!self.tree){
        self.tree = [[BinaryTree alloc] init];
    }
    if(!self.testRoot){
        self.testRoot = [[TreeNode alloc] initWithData:1];
    }
    [self.tree createTree:nil];
    switch (type) {
        case TIGUI_PRE:
            printf(" \n前序递归遍历的结果为:\n ");
            [self.tree preOrder:self.tree.root];
            break;
            
        case TIGUI_IN:
            printf(" \n中序递归遍历的结果为:\n ");
            [self.tree inOrder:self.tree.root];
        break;
            
        case TIGUI_POST:
            printf(" \n后序递归遍历的结果为:\n ");
           [self.tree postOrder:self.tree.root];
        break;
        
        case NO_TIGUI_PRE:
            [self.tree iterativePreOrder:self.tree.root];
        break;
            
        case NO_TIGUI_IN:
            [self.tree iterativeInOrder:self.tree.root];
        break;
            
        case NO_TIGUI_POST:
             [self.tree iterativePostOrder:self.tree.root];
        break;
            
        case BFS:
            [self.tree bfsTraceSearch:self.tree.root];
        break;
          
        case MAX_DEPTH:
            NSLog(@"178----最大深度,树高：%ld",[self.tree getMaxDepth:self.tree.root]);
        break;
        
        case MIN_DEPTH:
            NSLog(@"182----最小深度：%ld",[self.tree getMinDepth:self.tree.root]);
        break;
            
        case SEARCH_LEVEL:{
            TreeNode* prev = [[TreeNode alloc] initWithData:10];
            [self.tree insert:self.tree.root node:prev];
            [self.tree searchWithLevel:self.tree.root];
        }
            
        break;
            
        case INSERT:{
             TreeNode* prev = [[TreeNode alloc] initWithData:10];
            [self.tree insert:self.tree.root node:prev];
            [self.tree preOrder:self.tree.root];
        }
            
        case DELETE:{
            TreeNode* prev = [[TreeNode alloc] initWithData:2];
            [self.tree deleteNode:self.tree.root node:prev];
            printf("删除之后前序遍历为:\n");
            [self.tree preOrder:self.tree.root];
        }
            
            break;
            
        break;
            
        default:
            break;
    }
    
}




@end
