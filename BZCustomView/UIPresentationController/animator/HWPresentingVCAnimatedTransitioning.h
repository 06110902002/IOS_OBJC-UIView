//
//  HWPresentingVCAnimatedTransitioning.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#ifndef HWCustomPresentingVCAnimatedTransitioning_h
#define HWCustomPresentingVCAnimatedTransitioning_h
#import <UIKit/UIKit.h>

NS_SWIFT_NAME(PanModalPresentingViewControllerContextTransitioning)
@protocol HWPresentingViewControllerContextTransitioning <NSObject>

/**
 * Returns a view controller involved in the transition.
 * @return The view controller object for the specified key or nil if the view controller could not be found.
 */
- (__kindof  UIViewController * _Nullable )viewControllerForKey:(nonnull UITransitionContextViewControllerKey)key;

/**
 * The Animation duration gets from ViewController which conforms HWPanModalPresentable
 * - (NSTimeInterval)transitionDuration;
 */
- (NSTimeInterval)transitionDuration;

/**
 * Transition container, from UIViewControllerContextTransitioning protocol
 */
@property(nonnull, nonatomic, readonly) UIView *containerView;

@end

NS_SWIFT_NAME(PanModalPresentingViewControllerAnimatedTransitioning)
@protocol HWPresentingViewControllerAnimatedTransitioning <NSObject>

/**
 * Write you custom animation when present.
 */
- (void)presentAnimateTransition:(nonnull id<HWPresentingViewControllerContextTransitioning>)context NS_SWIFT_NAME(presentTransition(context:));
/**
 * Write you custom animation when dismiss.
 */
- (void)dismissAnimateTransition:(nonnull id<HWPresentingViewControllerContextTransitioning>)context NS_SWIFT_NAME(dismissTransition(context:));

@end


#endif /* HWCustomPresentingVCAnimatedTransitioning_h */




