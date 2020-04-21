//
//  HWShoppingCartPresentingAnimation.m
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import "HWShoppingCartPresentingAnimation.h"

@implementation HWShoppingCartPresentingAnimation

- (void)presentAnimateTransition:(nonnull id <HWPresentingViewControllerContextTransitioning>)context {

    NSTimeInterval duration = [context transitionDuration];
    UIViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat scale = 1 - statusBarHeight * 2 / CGRectGetHeight(fromVC.view.bounds);
    [UIView animateWithDuration:duration * 0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CATransform3D tran = CATransform3DIdentity;
        tran.m34 = -1 / 1000.0f;
        tran = CATransform3DRotate(tran, M_PI / 16, 1, 0, 0);
        tran = CATransform3DTranslate(tran, 0, 0, -100);
        fromVC.view.layer.transform = tran;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:duration * 0.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            fromVC.view.layer.transform = CATransform3DMakeScale(scale, scale, 1);
        } completion:^(BOOL finished) {

        }];
    }];
}

- (void)dismissAnimateTransition:(nonnull id <HWPresentingViewControllerContextTransitioning>)context {
    UIViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.layer.transform = CATransform3DIdentity;
}

@end

