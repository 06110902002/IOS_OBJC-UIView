//
//  AddLargeNumber.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/11.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "AddLargeNumber.h"
#import "Stack.h"

@interface AddLargeNumber()
@property(nonatomic,strong) Stack* operatorStack1;
@property(nonatomic,strong) Stack* operatorStack2;
@property(nonatomic,strong) Stack* resultStack;

@end

@implementation AddLargeNumber


-(NSString*) addLargeNumber:(NSString*) number1 number2:(NSString*) number2{
    NSMutableString* result = [[NSMutableString alloc] init];
    if (!self.operatorStack1) {
        self.operatorStack1 = [[Stack alloc] initWithSize:[number1 length]];
    }
    if (!self.operatorStack2) {
        self.operatorStack2 = [[Stack alloc] initWithSize:[number2 length]];
    }
    
    if (!self.resultStack) {
        self.resultStack = [[Stack alloc] initWithSize:[number1 length] + [number2 length]];
    }
    
    for(int i = 0;i < [number1 length]; i++){
        NSString *ch = [number1 substringWithRange:NSMakeRange(i,1)];
        [self.operatorStack1 push:ch];
    }
    
    for(int i = 0;i < [number2 length]; i++){
        NSString *ch = [number2 substringWithRange:NSMakeRange(i,1)];
        [self.operatorStack2 push:ch];
    }
    [self.operatorStack1 test];
    [self.operatorStack2 test];
    NSInteger carry = 0;
    while(![self.operatorStack1 isEmpty] || ![self.operatorStack2 isEmpty]){
        NSInteger opt1 = 0;
        NSInteger opt2 = 0;
        if(![self.operatorStack1 isEmpty]){
            opt1 = [(NSString*)[self.operatorStack1 pop] intValue] ;
        }
        if(![self.operatorStack2 isEmpty]){
            opt2 = [(NSString*)[self.operatorStack2 pop] intValue] ;
        }
        NSInteger tmpResult = opt1 + opt2 + carry;
        if (tmpResult > 9) {  //发生进位
            carry = 1;
            NSInteger geWei = tmpResult - 10;
            [self.resultStack push:[NSString stringWithFormat:@"%ld",geWei]];
        }else{
            carry = 0;
            [self.resultStack push:[NSString stringWithFormat:@"%ld",tmpResult]];
        }
        [self.resultStack test];
    }

    while (![self.resultStack isEmpty]) {
        NSString* tmp = (NSString*)[self.resultStack pop];
        [result appendString:tmp];
    }
    return [result copy];
    
}

@end
