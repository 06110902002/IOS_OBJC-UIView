//
//  KeyboardView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/22.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "KeyboardView.h"
#import "AbcKeyBoardView.h"
#import <Foundation/Foundation.h>
#import "NSString+Des3.h"

#define FIT_X          [UIScreen mainScreen].bounds.size.width/320.000
#define iPhone4        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

const NSInteger ABC     = 23;
const NSInteger DELETE  = 24;

@interface KeyboardView(){
    UIButton *pressButtonCapital;
}
@property(strong,nonatomic) UIView* logoBgView;
@property(copy,nonatomic) NSString* beforeInputContent; //注意此处的修饰符，before为临时m赋值，用copy
@property(strong,nonatomic) NSMutableArray* randomNumArray;
@property(strong,nonatomic) AbcKeyBoardView* abcKeyboardView;

// 不能使用copy 因为可变对象的拷贝之后变成了为不可变对象，不能再进行内容追加
@property(strong,nonatomic) NSMutableString* afterInputContent;

@end

@implementation KeyboardView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void) initConfig{
    self.rowSpace = 5;
    self.colSpace = 5;
    self.containerView = [UIView new];
    self.containerView.frame = self.frame;
    [self addSubview:self.containerView];
    self.afterInputContent = [[NSMutableString alloc] init];
    self.randomNumArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0;  i < 10; i ++) {
        [self.randomNumArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
}

/// 设置输入法键盘
/// @param type 类型
/// @param inputView 输入视图
-(void) setInputMethodKeyboard:(KeyboardType) type inputView:(UITextField*) inputView{
    if (!inputView) {
        return;
    }
    self.type = type;
    inputView.inputView = self;
    self.tmpTextField = inputView;
    switch (type) {
        case Default:
            [self createDefaultKeyvoardView];
            break;
        case Number:{
            [self createLogoView];
            [self createNumberKeyboardView];
            
        }
            break;
            
        case NumberAndRandom:
            [self createLogoView];
            break;
            
        default:
            break;
    }
}

- (void)createLogoView{
    self.logoBgView = [UIView new];
    [self setBackgroundColor:[UIColor darkGrayColor]];
    [self.containerView addSubview:self.logoBgView];
    self.logoBgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44);

    UILabel *logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.logoBgView.frame), CGRectGetHeight(self.logoBgView.frame))];
    [self.logoBgView addSubview:logoLabel];
    [logoLabel setText:@"硬汉安全键盘"];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [logoLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [logoLabel setNumberOfLines:0];
    [logoLabel setFont:[UIFont systemFontOfSize:14]];
    [logoLabel setTextColor:[UIColor whiteColor]];

    UIButton *btnFinish = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.logoBgView.frame) / 4 * 3, 0, CGRectGetWidth(self.logoBgView.frame) / 4 , CGRectGetHeight(self.logoBgView.frame))];
    [self.logoBgView addSubview:btnFinish];
    [btnFinish setTitle:@"完成" forState:UIControlStateNormal];
    [btnFinish setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnFinish addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
}

-(void) createNumberKeyboardView{
    CGFloat width = (CGRectGetWidth(self.frame) - self.colSpace * 4) / 3;
    CGFloat height = (CGRectGetHeight(self.frame) - self.rowSpace * 4 - self.logoBgView.frame.size.height) / 4 ;
    for(NSInteger i = 1; i < 10; i ++){
        [self createKey:[NSString stringWithFormat:@"%ld",i]
                   posX:(self.colSpace + self.colSpace * ((i - 1) % 3) +  width * ((i - 1) % 3))
                   posY:(44 + self.rowSpace * ((i - 1) / 3) + height * ((i - 1)/3))
                  width:width
                 height:height
                  forId:i];
    }
    //创建最底部一排的功能键
    [self createKey:[NSString stringWithFormat:@"%@",@"ABC"]
               posX:(self.colSpace)
               posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
              width:width
             height:height
              forId:23];

    [self createKey:[NSString stringWithFormat:@"%@",@"0"]
                  posX:(self.colSpace * 2 +  width)
                  posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
                 width:width
                height:height
                 forId:0];

    [self createKey:[NSString stringWithFormat:@"%@",@"X"]
               posX:(self.colSpace * 3 +  width * 2)
               posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
              width:width
             height:height
              forId:24];
    
}


/// 创建随机数字键盘，即0-9数字在键盘的位置随机出现
-(void) createNumberAndRandom{
    //随机打乱
    for(NSInteger i = self.randomNumArray.count;i > 0; i --){
        NSInteger random = arc4random() % i;
        NSInteger tmp = [self.randomNumArray[random] intValue];
        self.randomNumArray[random] = self.randomNumArray[i - 1];
        self.randomNumArray[i - 1] = [NSNumber numberWithInteger:tmp];
    }
    CGFloat width = (CGRectGetWidth(self.frame) - self.colSpace * 4) / 3;
    CGFloat height = (CGRectGetHeight(self.frame) - self.rowSpace * 4 - self.logoBgView.frame.size.height) / 4 ;
    
    [self.randomNumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSString* value = [NSString stringWithFormat:@"%@",obj];
        if(idx == 0){
            [self createKey:value
                      posX:(self.colSpace * 2 +  width)
                      posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
                     width:width
                    height:height
                     forId:[value intValue]];
        }else{
            [self createKey:value
                      posX:(self.colSpace + self.colSpace * ((idx) % 3) +  width * ((idx) % 3))
                      posY:(self.logoBgView.frame.size.height + self.rowSpace * ((idx - 1) / 3) + height * ((idx - 1)/3))
                     width:width
                    height:height
                     forId:[value intValue]];
        }
    }];
    [self createKey:[NSString stringWithFormat:@"%@",@"ABC"]
              posX:(self.colSpace)
              posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
             width:width
            height:height
             forId:ABC];
    
    [self createKey:[NSString stringWithFormat:@"%@",@"X"]
              posX:(self.colSpace * 3 +  width * 2)
              posY:(self.logoBgView.frame.size.height + self.rowSpace * 3 + height * 3)
             width:width
            height:height
             forId:DELETE];
    
}


/// 创建英文字母键盘，默认的类型为本键盘
-(void) createDefaultKeyvoardView{
    self.abcKeyboardView = [[AbcKeyBoardView alloc] initWithFrame:self.frame];
    [self.abcKeyboardView createKeyboardView];
    [self addSubview:self.abcKeyboardView];
    
}

-(void) removeAllSubViews:(UIView*) parentView{
    if (parentView) {
        for(UIView *view in [parentView subviews]){
            [view removeFromSuperview];
        }
    }
}

- (void)createKey:(NSString *)title
             posX:(float)posX
             posY:(float)posY
            width:(float)width
           height:(float)height
            forId:(NSInteger) tag{
    UIButton *btnKey = [[UIButton alloc]initWithFrame:CGRectMake(posX, posY, width, height)];
    [self.containerView addSubview:btnKey];
    btnKey.layer.cornerRadius = 5;
    btnKey.tag = tag;
    [btnKey addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnKey setTitle:title forState:UIControlStateNormal];
    [btnKey setBackgroundColor:[UIColor lightGrayColor]];
    //[btnKey setBackgroundImage:[CommonFunc imageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
}

- (void)buttonDidClicked:(UIButton*)sender{
    self.tmpTextField.text = sender.titleLabel.text;
    
    switch (sender.tag) {
            
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 0:
            [self.afterInputContent appendString:sender.titleLabel.text];
        break;
            
        case ABC:
            
            break;
            
        case DELETE:{
            if(self.afterInputContent.length > 0){
                NSString* minusStr = [self.afterInputContent substringToIndex:self.afterInputContent.length - 1];
                [self.afterInputContent setString:minusStr] ;
            }
        }
            
            break;
            
        default:
            break;
    }
   
    if ([self.keyClickListener respondsToSelector:@selector(onClick:withText:view:)]) {
           [self.keyClickListener onClick:sender.tag withText:sender.titleLabel.text view:sender];
       }
    if ([self.keyClickListener respondsToSelector:@selector(onTextWatch:beforeText:curText:afterText:)]) {
        
        [self.keyClickListener onTextWatch:sender beforeText:self.beforeInputContent curText:sender.titleLabel.text afterText:self.afterInputContent];
        self.beforeInputContent = self.afterInputContent;
    }
       
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (self.type == NumberAndRandom) {
        [self createNumberAndRandom];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];

}

- (void)hideKeyboard{
    [self.tmpTextField endEditing:YES];
    //[self.tmpTextField resignFirstResponder];
}

-(void) releaseRes{
    self.beforeInputContent = nil;
    self.afterInputContent = nil;
}

@end
