//
//  NSString+Des3.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Des3)

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText Key:(NSString *)key value:(NSString *)value;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText Key:(NSString *)key value:(NSString *)value;

/**
 *  encode
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

/**
 *  解码
 */
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

/**
 *  默认加密方法
 */
+ (NSString*)encrypt:(NSString*)plainText;

/**
 *  默认解密方法
 */
+ (NSString*)decrypt:(NSString*)encryptText;

@end

NS_ASSUME_NONNULL_END
