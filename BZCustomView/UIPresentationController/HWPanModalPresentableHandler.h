//
//  HWPanModalPresentableHandler.h
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWPanModalPresentable.h"
#import "HWPanModalPresentationDelegate.h"

typedef NS_ENUM(NSUInteger, HWPanModalPresentableHandlerMode) {
    HWPanModalPresentableHandlerModeViewController, // used for UIViewController
    HWPanModalPresentableHandlerModeView,           // used for view
};

NS_ASSUME_NONNULL_BEGIN

@protocol HWPanModalPresentableHandlerDelegate <NSObject>

/**
 * tell the delegate the presentable is about to update origin y
 */
- (void)adjustPresentableYPos:(CGFloat)yPos;

/**
 * tell the delegate presentable is about to change the form state
 * @param state short, long
 */
- (void)presentableTransitionToState:(PresentationState)state;

/**
 * dismiss Controller/UIView
 * @param isInteractive only for UIViewController, pop view will ignore it.
 * @param mode only for UIViewController, pop view will ignore it.
 */
- (void)dismiss:(BOOL)isInteractive mode:(PanModalInteractiveMode)mode;

@optional
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end

@protocol HWPanModalPresentableHandlerDataSource <NSObject>

- (CGSize)containerSize;
- (BOOL)isBeingDismissed;
- (BOOL)isBeingPresented;
- (BOOL)isFormPositionAnimating;

@optional
- (BOOL)isPresentedViewAnchored;
- (BOOL)isPresentedControllerInteractive;

@end

@interface HWPanModalPresentableHandler : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, assign, readonly) CGFloat shortFormYPosition;
@property (nonatomic, assign, readonly) CGFloat longFormYPosition;
@property (nonatomic, assign, readonly) BOOL extendsPanScrolling;
@property (nonatomic, assign, readonly) BOOL anchorModalToLongForm;
@property (nonatomic, assign, readonly) CGFloat anchoredYPosition;

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGestureRecognizer;
// make controller or view to deal with the gesture action
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *screenEdgeGestureRecognizer;

@property (nonatomic, assign) HWPanModalPresentableHandlerMode mode;
@property (nonatomic, weak) UIView<HWPanModalIndicatorProtocol> *dragIndicatorView;
@property (nonatomic, weak) UIView *presentedView;  // which used to present.

@property(nonatomic, weak) id <HWPanModalPresentableHandlerDelegate> delegate;
@property(nonatomic, weak) id <HWPanModalPresentableHandlerDataSource> dataSource;

- (instancetype)initWithPresentable:(id <HWPanModalPresentable>)presentable;
+ (instancetype)handlerWithPresentable:(id <HWPanModalPresentable>)presentable;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)observeScrollable;

- (void)configureScrollViewInsets;

- (void)setScrollableContentOffset:(CGPoint)offset animated:(BOOL)animated;

- (void)configureViewLayout;

@end

NS_ASSUME_NONNULL_END

