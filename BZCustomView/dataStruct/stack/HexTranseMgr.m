//
//  HexTranseMgr.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/11.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "HexTranseMgr.h"
#import "Stack.h"

@interface HexTranseMgr()
@property(strong,nonatomic)Stack* stack;
@end

@implementation HexTranseMgr

-(NSString*) decimal2AnyHex:(NSInteger) number withType:(NSInteger) type{
    if (!self.stack) {
        self.stack = [[Stack alloc] initWithSize:64];
    }
    NSMutableString* result = [[NSMutableString alloc] init];
    NSInteger remainder = number % type;
    NSInteger shang = number / type;
    [self.stack push:[NSString stringWithFormat:@"%ld",remainder]];
    NSLog(@"23--------:%ld  商：%ld",remainder,shang);
    while (shang > 0) {
        remainder = shang % type;
        shang = shang / type;
        [self.stack push:[NSString stringWithFormat:@"%ld",remainder]];
        NSLog(@"29--------:%ld  商：%ld",remainder,shang);
    }
    while (![self.stack isEmpty]) {
        [result appendString:(NSString*)[self.stack pop]];
    }
    NSLog(@"35------十进制：%ld 转换二进制结果：%@",number,result);
    return [result copy];
}

-(NSString*) anyHex2Decimal:(NSString*) anyNumberString withType:(NSInteger) type{
    
    NSInteger result = 0;
    for(NSInteger i = 0;i < [anyNumberString length]; i++){
        NSString *ch = [anyNumberString substringWithRange:NSMakeRange(i,1)];
        result += [ch intValue] * pow(type, [anyNumberString length] - i - 1);
    }
    NSLog(@"47-------%@ 的 %ld 进制转换为十进制为:%ld",anyNumberString,type,result);
    return nil;
}

@end
