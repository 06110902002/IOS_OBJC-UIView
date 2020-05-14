//
//  HexTranseMgr.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/11.
//  Copyright © 2020 刘小兵. All rights reserved.
//  本工具实现 10进制与2-9 之间的进制互相转换

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HexTranseMgr : NSObject


/// 十进制转换为2-9进制
/// @param number 待转换的十进制数
/// @param type     转换类型 
-(NSString*) decimal2AnyHex:(NSInteger) number withType:(NSInteger) type;


/// 2- 9 进制转换为十进制
/// @param anyNumberString  待转换的数字字符串
/// @param type     转换类型
-(NSString*) anyHex2Decimal:(NSString*) anyNumberString withType:(NSInteger) type;

@end

NS_ASSUME_NONNULL_END
