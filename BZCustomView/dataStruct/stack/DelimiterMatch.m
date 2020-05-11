//
//  DelimiterMatch.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/11.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "DelimiterMatch.h"
#import "Stack.h"

@interface DelimiterMatch()
@property(nonatomic,copy) NSString* targetString;
@property(nonatomic,strong) Stack* stack;
@end

@implementation DelimiterMatch

-(instancetype) initWithString:(NSString *)str{
    if (self = [super init]) {
        self.targetString = str;
    }
    return self;
}

-(BOOL)match:(NSString *)str{
    BOOL result = false;
    if (str) {
        if (!self.stack) {
            self.stack = [[Stack alloc] initWithSize:[str length]];
        }
        for(int i = 0;i < [str length]; i++){
           NSString *ch = [str substringWithRange:NSMakeRange(i,1)];
            NSLog(@"34-----------:%@",ch);
            if ([ch isEqualToString:@"["] || [ch isEqualToString:@"("] || [ch isEqualToString:@"{"]) {
                [self.stack push:ch];
                [self.stack test];
            }else if([ch isEqualToString:@"]"] || [ch isEqualToString:@")"] || [ch isEqualToString:@"}"]){
                if(![self.stack isEmpty]){
                    NSString* leftChar = (NSString*)[self.stack pop];
                    if ([ch isEqualToString:@")"] && [leftChar isEqualToString:@"("]) {
                        NSLog(@"41-------()匹配成功进行下一次匹配");
                        result = true;
                        continue;
                    }else if ([ch isEqualToString:@"]"] && [leftChar isEqualToString:@"["]) {
                        NSLog(@"44-------[]匹配成功进行下一次匹配");
                        result = true;
                        continue;
                    }else if ([ch isEqualToString:@"}"] && [leftChar isEqualToString:@"{"]) {
                        NSLog(@"44-------[]匹配成功进行下一次匹配");
                        result = true;
                        continue;
                    }else{
                        result = false;
                        NSLog(@"48-------匹配失败,待匹配的元素情况为：出栈元素：%@,遍历到的元素为:%@",leftChar,ch);
                        [self.stack test];
                    }
                }else{
                    result = false;
                    NSLog(@"55-------匹配失败,多了字符:%@",ch);
                }
            }
        
        }
        if ([self.stack isEmpty] && result) {
            NSLog(@"64-------匹配成功");
        }else{
            NSLog(@"66-------匹配失败");
        }
        
    }
    
    return [self.stack isEmpty] && result;
}

@end
