//
//  KeyboardBaseView.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 刘小兵. All rights reserved.
//  键盘p视图基类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSInteger const SPACE;
extern NSInteger const NUMBER;
extern NSInteger const CAPITAL;

@interface KeyboardBaseView : UIView


/// 创建键盘视图子类具体实现
-(void) createKeyboardView;

- (void)createKey:(NSString *)title
              posX:(float)posX
              posY:(float)posY
             width:(float)width
            height:(float)height
            forId:(NSInteger) tag;

- (void)createKey:(NSString *)title
          posX:(float)posX
          posY:(float)posY
         width:(float)width
        height:(float)height
         forId:(NSInteger) tag
   bgNormalImg:(nullable NSString* ) normalSrc
 bghighlighted:(nullable NSString*) hilightSrc;

@end

NS_ASSUME_NONNULL_END
