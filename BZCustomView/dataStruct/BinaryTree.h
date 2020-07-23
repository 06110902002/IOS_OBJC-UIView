//
//  BinaryTree.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//  二叉树

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "QueueArray.h"
@class TreeNode;


NS_ASSUME_NONNULL_BEGIN

@interface BinaryTree : NSObject

@property(nonatomic,strong) TreeNode* root;
@property(nonatomic,strong) Stack* stack;
@property(nonatomic,strong) QueueArray* queue;

-(TreeNode*) createTree:(nullable NSArray*) data;


///  递归实现前序遍历
/// @param root 根结点
-(void) preOrder:(TreeNode*) root;

/// 递归实现中序遍历
/// @param root 根结点
-(void) inOrder:(TreeNode*) root;

/// 递归实现后序遍历
/// @param root 根结点
-(void) postOrder:(TreeNode*) root;


/// 非递归实现前序遍历
/// @param root 根结点
-(void) iterativePreOrder:(TreeNode*) root;

/// 非递归实现中序遍历
/// @param root 根结点
-(void) iterativeInOrder:(TreeNode*) root;

/// 非递归实现后序遍历
/// @param root 根结点
-(void) iterativePostOrder:(TreeNode*) root;


///  广度遍历树，注意前序，中序，后序都是DFS的一种
///  借助队列实现
/// @param root 树
-(void) bfsTraceSearch:(TreeNode*) root;



///  习题演练
/// 给定一个二叉树，找出其最大/最小深度。
/// @param root 树根结点
-(NSInteger) getMaxDepth:(TreeNode*) root;


/// 找出最小深度
/// @param root 树根结点
-(NSInteger) getMinDepth:(TreeNode*) root;


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
-(void) searchWithLevel:(TreeNode*) root;


/// 插入结点
/// @param root 树
/// @param node t待插入的结点
-(void) insert:(TreeNode*) root node:(TreeNode*) node;

/// 删除指定结点
/// @param root 待删除的树
/// @param node 待删除的指定结点
-(void) deleteNode:(TreeNode*) root node:(TreeNode*)node;

/// 找待删除结点的中序后继结点，如果是一颗有序的二叉树的话，
/// 那么这个后继结点就是右子树当中值最小的一个
/// @param node 待删除的结点
-(TreeNode*) getDirctInPostNode:(TreeNode*) node;

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong)TreeNode* node;

/// 查找二叉排序树第k大的结点
/// @param node 树根结点
/// @param kvalue 第k大
-(TreeNode*) searchKthNode:(TreeNode*)node k:(NSInteger)kvalue;


-(void) create:(NSArray*) array;


/// 求两个结点的最近公共w父结点
/// @param root 根结点
/// @param p 其中一个结点
/// @param q 另一个结点
-(TreeNode*) lastPublicParentNode:(TreeNode*) root node1:(TreeNode*)p node2:(TreeNode*)q;



@end

NS_ASSUME_NONNULL_END
