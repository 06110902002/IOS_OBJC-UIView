//
//  UIScrollView+Helper.m
//  UIKit
//
//  Created by Liu Xiaobing on 2020/4/9.
//  Copyright © 2020 Liu HuLai. All rights reserved.
//

#import "UIScrollView+Helper.h"

@implementation UIScrollView (Helper)

- (BOOL)isScrolling {
    return (self.isDragging && !self.isDecelerating) || self.isTracking;
}

@end
