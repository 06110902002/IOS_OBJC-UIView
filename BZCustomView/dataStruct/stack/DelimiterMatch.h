//
//  DelimiterMatch.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/11.
//  Copyright © 2020 刘小兵. All rights reserved.
//  使用栈实现符号匹配

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DelimiterMatch : NSObject

-(instancetype) initWithString:(NSString*) str;

-(BOOL) match:(NSString*) str;

@end

NS_ASSUME_NONNULL_END
