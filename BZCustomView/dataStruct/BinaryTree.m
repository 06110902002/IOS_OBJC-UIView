//
//  BinaryTree.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "BinaryTree.h"
#import "TreeNode.h"

@implementation BinaryTree

-(TreeNode*) createTree:(NSArray *)data{
    TreeNode* p1 = [[TreeNode alloc] initWithData:1];
    TreeNode* p2 = [[TreeNode alloc] initWithData:2];
    TreeNode* p3 = [[TreeNode alloc] initWithData:3];
    TreeNode* p4 = [[TreeNode alloc] initWithData:4];
    TreeNode* p5 = [[TreeNode alloc] initWithData:5];
    TreeNode* p6 = [[TreeNode alloc] initWithData:6];
    TreeNode* p7 = [[TreeNode alloc] initWithData:7];
    TreeNode* p8 = [[TreeNode alloc] initWithData:8];
    TreeNode* p9 = [[TreeNode alloc] initWithData:9];
//    p1.leftChild = p2;
//    p1.rightChild = p3;
//    p2.leftChild = p4;
//    p2.rightChild = p5;
//    p3.leftChild = p6;
//    p3.rightChild = p7;
//    p4.leftChild = p8;
//    p4.rightChild = p9;
//    self.root = p1;
    
    
    p5.leftChild = p2;
    p5.rightChild = p9;
    p2.leftChild = p1;
    p2.rightChild = p4;
    p4.leftChild = p3;
    p9.leftChild = p6;
    p6.rightChild = p8;
    p8.leftChild = p7;
    self.root = p5;
    return p1;
}

-(void) preOrder:(TreeNode *)root{
    if (!root) {
        return;
    }
    [self visitedNode:root];
    if(root.leftChild){
        [self preOrder:root.leftChild];
    }
    if(root.rightChild){
        [self preOrder:root.rightChild];
    }
}

-(void) inOrder:(TreeNode *)root{
    if (!root) {
        return;
    }
    if(root.leftChild){
        [self inOrder:root.leftChild];
    }
    [self visitedNode:root];
    if(root.rightChild){
        [self inOrder:root.rightChild];
    }
}

-(void) postOrder:(TreeNode *)root{
    if (!root) {
        return;
    }
    if(root.leftChild){
        [self postOrder:root.leftChild];
    }
    if(root.rightChild){
        [self postOrder:root.rightChild];
    }
    [self visitedNode:root];
}




/// 非递归实现前序遍历
/// @param root 根结点
-(void) iterativePreOrder:(TreeNode*) root{
    
    if (!self.stack) {
        self.stack = [[Stack alloc] initWithSize:100];
    }
    TreeNode* p = root;
    if(p){
        printf(" \n前序非递归遍历的结果为:\n ");
        [self.stack push:p];
        while (![self.stack isEmpty]) {
            p = (TreeNode*)[self.stack pop];
            [self visitedNode:p];
            
            if(p.rightChild){
                [self.stack push:p.rightChild];
            }
            if(p.leftChild){
                [self.stack push:p.leftChild];
            }
            
        }
    }
}

/// 非递归实现中序遍历
/// @param root 根结点
-(void) iterativeInOrder:(TreeNode*) root{
    if (!self.stack) {
        self.stack = [[Stack alloc] initWithSize:100];
    }
    printf(" \n中序非递归遍历的结果为:\n ");
    TreeNode* p = root;
    while (p || ![self.stack isEmpty]) {
        
        while (p) {
            [self.stack push:p];
            p = p.leftChild;
        }
        if (![self.stack isEmpty]) {
            p = (TreeNode*)[self.stack pop];
            [self visitedNode:p];
            p = p.rightChild;
        }
    }
}

/// 非递归实现后序遍历
/// @param root 根结点
-(void) iterativePostOrder:(TreeNode*) root{
    if (!self.stack) {
           self.stack = [[Stack alloc] initWithSize:100];
     }
    [self.stack push:root];
    TreeNode* cur;
    TreeNode* pre;
    printf(" \n后序非递归遍历的结果为:\n ");
    while(![self.stack isEmpty]){
        cur = (TreeNode*)[self.stack top];
        
        //没有孩子结点
        BOOL noChild = !cur.leftChild && !cur.rightChild;
        //通过判断上一个结点是否为其中的一个孩子结点时，来判断孩子结点是否都已经被访问过
        //如果当前结点存在左右孩子那么必须等它左右孩子都必需访问之后才能访问它
        BOOL lastVisitedNode = pre && ([pre isEqual:cur.leftChild] || [pre isEqual: cur.rightChild]);
        if (noChild || lastVisitedNode) {
            [self visitedNode:cur];
            [self.stack pop];
            pre = cur;
        }else{
            if(cur.rightChild){
                [self.stack push:cur.rightChild];
            }
            if(cur.leftChild){
                [self.stack push:cur.leftChild];
            }
        }
    }
}

///  广度遍历树，注意前序，中序，后序都是DFS的一种
///  借助队列实现
/// @param root 树
-(void) bfsTraceSearch:(TreeNode*) root{
    if (!root) {
        return;
    }
    if (!self.queue) {
        self.queue = [[QueueArray alloc] initWithSize:100];
    }
    [self.queue enqueue:root];
    printf("\n 树的广度优先遍历为结果为:\n");
    while (![self.queue isEmpty]) {
        TreeNode* head = (TreeNode*)[self.queue dequeue];
        [self visitedNode:head];
        if(head.leftChild){
            [self.queue enqueue:head.leftChild];
        }
        if (head.rightChild) {
            [self.queue enqueue:head.rightChild];
        }
    }
}

///  习题演练
/// 给定一个二叉树，找出其最大/最小深度。
/// @param root 树根结点
-(NSInteger) getMaxDepth:(TreeNode*) root{
    if (!root) {
        return 0;
    }
    NSInteger leftDepth = [self getMaxDepth:root.leftChild] + 1;
    NSInteger rightDepth = [self getMaxDepth:root.rightChild] + 1;
    return MAX(leftDepth, rightDepth);
}

/// 找出最小深度
/// @param root 树根结点
-(NSInteger) getMinDepth:(TreeNode*) root{
    if (!root) {
           return 0;
       }
   NSInteger leftDepth = [self getMinDepth:root.leftChild] + 1;
   NSInteger rightDepth = [self getMinDepth:root.rightChild] + 1;
   return MIN(leftDepth, rightDepth);
}

/// 逐层遍历
/*       3
        / \
        9  20
        /  \
        15   7
   遍历的结果为：
    [
      [3],
      [9,20],
      [15,7]
    ]
 */
/// @param root 树根结点
-(void) searchWithLevel:(TreeNode*) root{
   if (!root) {
       return;
    }
   if (!self.queue) {
       self.queue = [[QueueArray alloc] initWithSize:100];
   }
   [self.queue enqueue:root];
   NSMutableArray* resultArray = [[NSMutableArray alloc] init];
   printf("\n树的逐层遍历为结果为:\n");
   while (![self.queue isEmpty]) {
       
       NSMutableArray* levelArray = [[NSMutableArray alloc] init];
       NSInteger levelNum = [self.queue length];
       for (NSInteger i = 0; i < levelNum; i ++) {
          TreeNode* head = (TreeNode*)[self.queue dequeue];
           if(head.leftChild){
               [self.queue enqueue:head.leftChild];
           }
           if (head.rightChild) {
               [self.queue enqueue:head.rightChild];
           }
           [levelArray addObject:head];
       }
       [resultArray addObject:levelArray];
   }
    
     [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
         NSArray* array = (NSArray*)obj;
         printf("\n第%ld层 结点个数：%ld,分别为:\n",idx,[array count]);
         [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
             [self visitedNode:(TreeNode*)obj];
         }];
         
     }];
}


/// 插入结点,可以使用插入法创建一颗树
///要插入键值为e的新节点，必须找到树中一个终端结点，并将新结点与该结点的值进行比较，
///如果e小于该结点，就测试当前结点的左子结点，否则测试当前结点的右子结点
///如果要测试的p的子结点为空，就停止扫描，新结点做为p的子结点。
/// @param root 树
/// @param node 待插入的结点
-(void) insert:(TreeNode*) root node:(TreeNode*) node{
    
    TreeNode* p = root;
    TreeNode* prev = root;
    while (p) {
        prev = p;
        if (node.value < p.value) {
            p = p.leftChild;
        }else{
            p = p.rightChild;
        }
    }
    if (!root) {
        root = node;
    }else if (node.value < prev.value){
        prev.leftChild = node;
    }else{
        prev.rightChild = node;
    }
    
}

/// 删除指定结点
/// @param root 待删除的树
/// @param node 待删除的指定结点
-(void) deleteNode:(TreeNode*) root node:(TreeNode*)node{
    if (!root) {
        return;
    }
    TreeNode* currentNode = root;
    TreeNode* parentNode = root;
    BOOL isLeftChild = true;
    
    //查找删除的结点在树中的位置
    while (currentNode && currentNode.value != node.value) {
        parentNode = currentNode;
        if (node.value < currentNode.value) {
            currentNode = currentNode.leftChild;
            isLeftChild = true;
        }else{
            currentNode = currentNode.rightChild;
            isLeftChild = false;
        }
    }
    if (!currentNode) {
        return;
    }
    //无孩子结点,即删除的结点为叶子结点情况
    if(!currentNode.leftChild && !currentNode.rightChild){
        if(currentNode == root){
            root = nil;
        }else if (isLeftChild){
            parentNode.leftChild = nil;
        }else{
            parentNode.rightChild = nil;
        }
    }
    //删除的结点只有一个孩子结点
    else if(currentNode.rightChild == nil){//要删除的节点只有左孩子
        if(currentNode == root){
            root = currentNode.leftChild;
        }else if (isLeftChild){ //删除有结点有左孩子，将左孩子挂到当前结点的父结点的作为左孩子
            parentNode.leftChild = currentNode.leftChild;
        }else{
            parentNode.rightChild = currentNode.leftChild;
        }
    }else if(currentNode.leftChild == nil){//要删除的节点只有右孩子
        if(currentNode == root){
            root = currentNode.rightChild;
        }else if (isLeftChild){ //删除有结点有左孩子，将左孩子挂到当前结点的父结点的作为左孩子
            parentNode.leftChild = currentNode.rightChild;
        }else{
            parentNode.rightChild = currentNode.rightChild;
        }
    }
    //删除的结点既有左孩子又有右孩子
    else{
        TreeNode* dirctInPostNode = [self getDirctInPostNode:currentNode];
        currentNode.value = dirctInPostNode.value;
        dirctInPostNode = nil;
    }
}


/// 找待删除结点的中序后继结点，如果是一颗有序的二叉树的话，那么这个后继结点就是右子树当中最少的一个
/// 注意这种情况是获取当前结左右子树均存在的情况
/// @param node 待删除的结点
-(TreeNode*) getDirctInPostNode:(TreeNode*) node{
    TreeNode* parentNode = node;
    TreeNode* direInPostNode = node;
    TreeNode* currentNode = node.rightChild;
    while (currentNode) { //找当前待删除 按中序遍历的后继结点
        parentNode = direInPostNode;
        direInPostNode = currentNode;
        currentNode = currentNode.leftChild;
    }
    if(direInPostNode != node.rightChild){
        parentNode.leftChild = direInPostNode.rightChild;
        direInPostNode.rightChild = nil;
    }
    return direInPostNode;
}


-(void) create:(NSArray*) array{
    if (!array) {
        return ;
    }
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        TreeNode* node = [[TreeNode alloc] initWithData:[obj intValue]];
        [self insert:self.root node:node];
    }];
    
}




-(void) visitedNode:(TreeNode*)node{
    if (node) {
        printf(" %ld ",node.value);
    }
}


@end
