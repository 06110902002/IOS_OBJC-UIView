//
//  Cell.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cell : NSObject

@property(nonatomic,assign) NSInteger x;
@property(nonatomic,assign) NSInteger y;

-(instancetype) init:(NSInteger)x y:(NSInteger) y;

-(BOOL) isEqual:(Cell*)object;

@end

NS_ASSUME_NONNULL_END
