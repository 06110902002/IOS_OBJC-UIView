//
//  TreeNode.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property(nonatomic,assign) NSInteger value;
@property(nonatomic,strong,nullable) TreeNode* leftChild;
@property(nonatomic,strong,nullable) TreeNode* rightChild;

-(instancetype) initWithData:(NSInteger) data;


@end

NS_ASSUME_NONNULL_END
