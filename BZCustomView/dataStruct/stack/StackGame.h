//
//  StackGame.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "Stack.h"

NS_ASSUME_NONNULL_BEGIN

@interface StackGame : NSObject

@property(nonatomic,strong) Cell* curCell;
@property(nonatomic,strong) Cell* enterCell;
@property(nonatomic,strong) Cell* exitCell;
@property(nonatomic,strong) Stack* mazeStack;

-(void) pushUnVisited:(NSInteger)x y:(NSInteger)y;

-(void) queryPath;




-(void) testDigui;

///  不用栈，使用递归实现迷宫
/// @param array 数组
/// @param cell  当前位置
-(BOOL) queryPath:(NSMutableArray*) array curPos:(NSInteger)x curPosY:(NSInteger)y;

@end

NS_ASSUME_NONNULL_END
