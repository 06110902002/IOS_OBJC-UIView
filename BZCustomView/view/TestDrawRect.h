//
//  TestDrawRect.h
//  BZCustomView
//
//  Created by 刘小兵 on 2017/9/21.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 本类测试在UIView中使用drawRect进行绘图
 
 UIView的显示过程:
 
    当UIView需要显示时，它内部的层会准备好一个CGContextRef(图形上下文)，
 
    然后调用delegate(这里就是UIView)的drawLayer:inContext:方法，
 
    并且传入已经准备好的CGContextRef对象。而UIView在drawLayer:inContext:方法中又会调用自己的drawRect:方法
 
    在drawRect:中通过UIGraphicsGetCurrentContext()获取的就是由层传入的CGContextRef对象，在drawRect:中完成的所有绘图都会填入层的CGContextRef中，然后被拷贝至屏幕
 
 
 */
@interface TestDrawRect : UIView



/**
 直接在drawRect测试画图接口

 @param rect 视图的尺寸
 */
-(void) drawByDrawRect:(CGRect)rect;

@end
