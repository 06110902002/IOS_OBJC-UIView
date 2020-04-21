//
//  HWBaseViewController.m
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import "protocal/HWPanModalPresentable.h"
#import "HWPanModalHeight.h"
#import "HWBaseViewController.h"

@interface HWBaseViewController () <HWPanModalPresentable>

@end

@implementation HWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.989 blue:0.935 alpha:1.00];
    UILabel* lebal = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 50)];
    lebal.text = @"内容";
    lebal.textColor = [UIColor yellowColor];
    lebal.backgroundColor = [UIColor brownColor];
    [self.view addSubview:lebal];
    
}

#pragma mark - HWPanModalPresentable
/**
   返回内容面板的高度
 */
- (PanModalHeight)shortFormHeight {
    if ([self isLandScape]) {
        return [self longFormHeight];
    }
    return PanModalHeightMake(PanModalHeightTypeContent, 400.00001);
}


// 当转屏且为横屏时，为全屏幕模式。
- (CGFloat)topOffset {
    if ([self isLandScape]) {
        return 0;
    } else {
        return 40;
    }
}

- (BOOL)anchorModalToLongForm {
    return NO;
}

- (HWPanModalShadow)contentShadow {
    return PanModalShadowMake([UIColor yellowColor], 10, CGSizeMake(0, 2), 1);
}

- (UIViewAnimationOptions)transitionAnimationOptions {
    return UIViewAnimationOptionCurveLinear;
}

- (BOOL)isLandScape {
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight ||
        [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    return NO;
}

#ifdef DEBUG

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#endif


@end

