//
//  StickScrollVC.h
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/28.
//  Copyright © 2020 刘小兵. All rights reserved.
//  本例子实现 分组实现滑动时，头部悬停 且 i下方列表滑动时，头部导航栏下方指示条跟随滑动到相应的分组

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StickScrollVC : UIViewController


@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSArray *titles;


@end

NS_ASSUME_NONNULL_END
