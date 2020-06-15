//
//  NSString+Des3.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "NSString+Des3.h"

#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define defaultKey            @"jerehjereijerehjerei1234"
#define defaultIv             @"jerhjereijijereh12345678"


@implementation NSString (Des3)

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText Key:(NSString *)key value:(NSString *)value{
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
//    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [value UTF8String];
 
//    fix mem leak by zxy
    
//    ccStatus = CCCrypt(kCCEncrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding,
//                       vkey,
//                       kCCKeySize3DES,
//                       vinitVec,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//
//    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
     CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    free(bufferPtr);
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText Key:(NSString *)key value:(NSString *)value{
    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
//    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [value UTF8String];
   //    fix mem leak by zxy
//    ccStatus = CCCrypt(kCCDecrypt,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding,
//                       vkey,
//                       kCCKeySize3DES,
//                       vinitVec,
////                        nil,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//
//    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
//                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    
 CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       //                        nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
    free(bufferPtr);
    return result;
}


+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    CFStringRef cfString = CFURLCreateStringByAddingPercentEscapes(
    
    NULL, /* allocator */
    
    (__bridge CFStringRef)input,
    
    NULL, /* charactersToLeaveUnescaped */
    
    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
    
    kCFStringEncodingUTF8);
//    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
//
//                                                                             NULL, /* allocator */
//
//                                                                             (__bridge CFStringRef)input,
//
//                                                                             NULL, /* charactersToLeaveUnescaped */
//
//                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//
//                                                                             kCFStringEncodingUTF8);
    
    NSString* outputStr = [NSString stringWithString:(__bridge NSString *)cfString];
    
    CFRelease(cfString); //手动释放防止泄露
    
    return  outputStr;
}

/**
 *  解码
 */
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input

{
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@""
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0,[outputStr length])];
    
    return
    
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

/**
 *  默认加密方法
 */
+ (NSString*)encrypt:(NSString*)plainText
{
    return [NSString encrypt:plainText Key:defaultKey value:defaultIv];
}
/**
 *  默认解密方法
 */
+ (NSString*)decrypt:(NSString*)encryptText
{
    return [NSString decrypt:encryptText Key:defaultKey value:defaultIv];
}

@end
