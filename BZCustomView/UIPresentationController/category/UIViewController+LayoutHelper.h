//
//  UIViewController+LayoutHelper.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWPanModalPresentationController;

NS_ASSUME_NONNULL_BEGIN

@protocol HWPanModalPresentableLayoutProtocol <NSObject>

@property (nonatomic, assign, readonly) CGFloat topLayoutOffset;

@property (nonatomic, assign, readonly) CGFloat bottomLayoutOffset;

@property (nonatomic, assign, readonly) CGFloat shortFormYPos;

@property (nonatomic, assign, readonly) CGFloat longFormYPos;

@property (nonatomic, assign, readonly) CGFloat bottomYPos;

@end

/**
 * Help presentedViewController/presented View to layout.
 */
@interface UIViewController (LayoutHelper) <HWPanModalPresentableLayoutProtocol>

@property (nullable, nonatomic, strong, readonly) HWPanModalPresentationController *hw_presentedVC;

@end

NS_ASSUME_NONNULL_END
