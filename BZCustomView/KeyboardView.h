//
//  KeyboardView.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/22.
//  Copyright © 2020 刘小兵. All rights reserved.
//  自定义键盘视图

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KeyboardType) {
    DecimalNumber       = 0, //带小数点的数据键盘 九宫格布局
    NumberAndRandom     = 1, //随机出现数字键盘  九宫格布局
    Number              = 3, //纯数字键盘
    Default             = 4, //默认的英文键盘 26键布局
  
};


/// 键盘点击协议
@protocol OnKeyListener <NSObject>


@optional

/// 按键点击事件
/// @param Id 按键id
/// @param text 当前的文本
/// @param btn 按键对象
- (void)onClick:(NSInteger)Id withText:(NSString *_Nullable)text view:(UIButton*_Nullable) btn;

@optional
/// 文本输入监听协议接口
/// @param view 按键本身
/// @param beforeText 上一次输入的文本
/// @param curText 当前输入的文本
/// @param afterText 输入之后的文本
-(void) onTextWatch:(UIButton*_Nullable) view
         beforeText:(NSString*_Nullable) beforeText
            curText:(NSString*_Nullable)curText
          afterText:(NSString*_Nullable)afterText;

@end



NS_ASSUME_NONNULL_BEGIN

@interface KeyboardView : UIView
@property(assign,nonatomic) NSUInteger colSpace;
@property(assign,nonatomic) NSUInteger rowSpace;
@property(strong,nonatomic) UIView* containerView;
@property(strong, nonatomic) UITextField *tmpTextField;
@property(weak,nonatomic) id<OnKeyListener> keyClickListener;
@property(nonatomic,assign) KeyboardType type;


///  设置输入法键盘
/// @param type 类型
/// @param inputView 输入视图
-(void) setInputMethodKeyboard:(KeyboardType) type inputView:(UITextField*) inputView;

-(void) releaseRes;

@end

NS_ASSUME_NONNULL_END
