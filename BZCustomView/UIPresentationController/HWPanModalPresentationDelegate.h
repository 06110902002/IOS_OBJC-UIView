//
//  HWPanModalPresentationDelegate.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HWPanModalInteractiveAnimator;

typedef NS_ENUM(NSInteger, PanModalInteractiveMode) {
    PanModalInteractiveModeNone,
    PanModalInteractiveModeSideslip,    // 侧滑返回
    PanModalInteractiveModeDragDown,    // 向下拖拽返回
};

NS_ASSUME_NONNULL_BEGIN

@interface HWPanModalPresentationDelegate : NSObject <UIViewControllerTransitioningDelegate, UIAdaptivePresentationControllerDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, assign) PanModalInteractiveMode interactiveMode;
@property (nonnull, nonatomic, strong, readonly) HWPanModalInteractiveAnimator *interactiveDismissalAnimator;

@end

NS_ASSUME_NONNULL_END
