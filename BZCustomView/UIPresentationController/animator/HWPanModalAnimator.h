//
//  HWPanModalAnimator.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWPanModalPresentable.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AnimationBlockType)(void);
typedef void(^AnimationCompletionType)(BOOL completion);

static NSTimeInterval kTransitionDuration = 0.5;

@interface HWPanModalAnimator : NSObject

+ (void)animate:(AnimationBlockType)animations config:(nullable id <HWPanModalPresentable>)config completion:(nullable AnimationCompletionType)completion;

+ (void)dismissAnimate:(AnimationBlockType)animations config:(nullable id <HWPanModalPresentable>)config completion:(AnimationCompletionType)completion;

+ (void)smoothAnimate:(AnimationBlockType)animations duration:(NSTimeInterval)duration completion:(nullable AnimationCompletionType)completion;
@end

NS_ASSUME_NONNULL_END
