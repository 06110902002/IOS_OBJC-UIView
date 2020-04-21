//
//  HWPanContainerView.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWPanContainerView : UIView

/// the presented view should add to the content view.
@property (nonatomic, strong, readonly) UIView *contentView;

- (instancetype)initWithPresentedView:(UIView *)presentedView frame:(CGRect)frame;

- (void)updateShadow:(UIColor *)shadowColor
        shadowRadius:(CGFloat)shadowRadius
        shadowOffset:(CGSize)shadowOffset
       shadowOpacity:(float)shadowOpacity;

@end

@interface UIView (PanContainer)

@property (nullable, nonatomic, strong, readonly) HWPanContainerView *panContainerView;

@end

NS_ASSUME_NONNULL_END
