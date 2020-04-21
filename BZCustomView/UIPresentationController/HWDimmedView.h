//
//  HWDimmedView.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DimState) {
    DimStateMax,
    DimStateOff,
    DimStatePercent,
};

typedef void(^didTap)(UITapGestureRecognizer *recognizer);

@interface HWDimmedView : UIView

@property (nonatomic, assign) DimState dimState;
@property (nonatomic, assign) CGFloat percent;
@property (nullable, nonatomic, copy) didTap tapBlock;
@property (nullable, nonatomic, strong) UIColor *blurTintColor;

/**
 * init with the max dim alpha & max blur radius.
 */
- (instancetype)initWithDimAlpha:(CGFloat)dimAlpha blurRadius:(CGFloat)blurRadius;

@end

NS_ASSUME_NONNULL_END

