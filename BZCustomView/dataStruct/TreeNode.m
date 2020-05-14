//
//  TreeNode.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/12.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

-(instancetype)init{
    if (self = [super init]) {
        self.value = 0;
        self.leftChild = nil;
        self.rightChild = nil;
    }
    return self;
}

-(instancetype) initWithData:(NSInteger)data{
    if (self = [super init]) {
        self.value = data;
        self.leftChild = nil;
        self.rightChild = nil;
    }
    return self;
}

@end
