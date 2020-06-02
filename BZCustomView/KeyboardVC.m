//
//  KeyboardVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/22.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "KeyboardVC.h"
#import "KeyboardView.h"
#import "NSString+Des3.h"

@interface KeyboardVC ()<OnKeyListener>
@property(strong,nonatomic) UITextField* textField;
@property(strong,nonatomic) KeyboardView* keyboardView;

@end

@implementation KeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 200, 50)];
    self.textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textField];
    
    self.keyboardView = [[KeyboardView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 260)];
    
    //self.textField.inputView = self.keyboardView;
    //self.keyboardView.m_textField = self.textField;
    [self.keyboardView setInputMethodKeyboard:Number inputView:self.textField];
    [self.keyboardView setKeyClickListener:self];
    
    [self setUpForDismissKeyboard];

    
}
#pragma OnKeyListener 协议实现方式
- (void)onClick:(NSInteger)Id withText:(NSString *)text view:(UIButton *)btn{
    
}
-(void) onTextWatch:(UIButton*_Nullable) view
         beforeText:(NSString*_Nullable) beforeText
            curText:(NSString*_Nullable) curText
          afterText:(NSString*_Nullable) afterText{
    NSLog(@"37-------before:%@  curtext:%@  afterText:%@",beforeText,curText,afterText);
    self.textField.text = afterText;
   
}
//  end

//除输入框之外 ，点击屏幕其他地方收起键盘
- (void)setUpForDismissKeyboard {
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  UITapGestureRecognizer *singleTapGR =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(tapAnywhereToDismissKeyboard:)];
  NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
  [nc addObserverForName:UIKeyboardWillShowNotification
                  object:nil
                   queue:mainQuene
              usingBlock:^(NSNotification *note){
                [self.view addGestureRecognizer:singleTapGR];
              }];
  [nc addObserverForName:UIKeyboardWillHideNotification
                  object:nil
                   queue:mainQuene
              usingBlock:^(NSNotification *note){
                [self.view removeGestureRecognizer:singleTapGR];
              }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
  [self.view endEditing:YES];
}


@end
