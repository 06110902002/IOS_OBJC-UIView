//
//  KeyboardBaseView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "KeyboardBaseView.h"

NSInteger const SPACE   = 25;
NSInteger const NUMBER  = 26;
NSInteger const CAPITAL = 27;

@implementation KeyboardBaseView

-(void) createKeyboardView{
    //具体看子类的实现
}

- (void)createKey:(NSString *)title
             posX:(float)posX
             posY:(float)posY
            width:(float)width
           height:(float)height
            forId:(NSInteger)tag{
    
    UIButton *btnKey = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, width, height)];
    [self addSubview:btnKey];
    btnKey.layer.cornerRadius = 5;
    btnKey.tag = tag;
    [btnKey addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
    [btnKey setTitle:title forState:UIControlStateNormal];
    [btnKey setBackgroundColor:[UIColor lightGrayColor]];
    //[btnKey setBackgroundImage:[CommonFunc imageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
}

- (void)createKey:(NSString *)title
         posX:(float)posX
         posY:(float)posY
        width:(float)width
       height:(float)height
        forId:(NSInteger) tag
  bgNormalImg:(nullable NSString* ) normalSrc
    bghighlighted:(nullable NSString*) hilightSrc{
    
    UIButton *btnKey = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, width, height)];
       [self addSubview:btnKey];
    
    if (normalSrc) {
        [btnKey setBackgroundImage:[UIImage imageNamed:normalSrc] forState:UIControlStateNormal];
             
    }
    if (hilightSrc) {
        [btnKey setBackgroundImage:[UIImage imageNamed:hilightSrc] forState:UIControlStateHighlighted];
    }
    
       btnKey.layer.cornerRadius = 5;
       btnKey.tag = tag;
       [btnKey addTarget:self action:@selector(onClickListener:) forControlEvents:UIControlEventTouchUpInside];
       [btnKey setTitle:title forState:UIControlStateNormal];
       [btnKey setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
}

-(void) onClickListener:(UIButton*) button{
    
}

@end
