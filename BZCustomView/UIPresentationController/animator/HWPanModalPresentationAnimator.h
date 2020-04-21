//
//  HWPanModalPresentationAnimator.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HWPanModalPresentationDelegate.h"

typedef NS_ENUM(NSInteger, TransitionStyle) {
    TransitionStylePresentation,
    TransitionStyleDismissal,
};

NS_ASSUME_NONNULL_BEGIN

@interface HWPanModalPresentationAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionStyle:(TransitionStyle)transitionStyle interactiveMode:(PanModalInteractiveMode)mode;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
