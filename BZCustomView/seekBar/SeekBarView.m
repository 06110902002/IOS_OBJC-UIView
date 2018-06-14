//
//  SeekBarView.m
//  BZCustomView
//
//  Created by 刘小兵 on 2018/6/13.
//  Copyright © 2018 刘小兵. All rights reserved.
//

#import "SeekBarView.h"

#define PI 3.1415926
@implementation SeekBarView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.viewFrame = self.frame;
    self.posX = 50;
    self.posY = 65;
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawCornerRadius:context];
    [self drawIndexBar:context];
    [self drawIndexText:context];
    [self drawIndexTriangle:context];
}

-(void) drawCornerRadius:(CGContextRef) context{
    
    CGRect drawRect = {30,60,300,10};
    CGContextSetLineWidth(context, 1.5);
    CGContextSetRGBFillColor(context, 0.52f, 0.26f, 0.17f, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:10];
    [bezierPath fill];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextStrokePath(context);
}

-(void) drawIndexBar:(CGContextRef) ctx{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.posX, self.posY) radius:10.0 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [path setLineWidth:1.0];
    
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    // 描边和填充
    [path stroke];
    [path fill];
    
}

-(void) drawIndexText:(CGContextRef) context{
    
    CGRect drawRect = {self.posX - 25,self.posY - 50,50,30};
    CGContextSetLineWidth(context, 1.5);
    CGContextSetRGBFillColor(context, 0.52f, 0.26f, 0.17f, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:5];
    [bezierPath fill];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextStrokePath(context);
    
   
    //画文本
    NSString* str1 = [NSString stringWithFormat:@"%.2f",(self.posX - 30) / 300];
    CGRect rect1 = CGRectMake(self.posX - 25,self.posY - 50, 50, 30);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor (context, 0.01, 0.01, 0.01, 1);
    
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
    UIFont  *font = [UIFont boldSystemFontOfSize:14.0];
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle};
    CGSize strSize = [str1 sizeWithAttributes:attributes];
    
    CGFloat marginTop = (rect1.size.height - strSize.height)/2;
    CGRect r = CGRectMake(rect1.origin.x, rect1.origin.y + marginTop,rect1.size.width, strSize.height);
    [str1 drawInRect:r withAttributes:attributes];
    
}

-(void) drawIndexTriangle:(CGContextRef) context{
    
    CGPoint PointA = CGPointMake(self.posX, self.posY - 10);
    CGPoint PointB = CGPointMake(self.posX - 25 / 2, self.posY - 30 / 2 - 10 / 2);
    CGPoint PointC = CGPointMake(self.posX + 25 / 2, self.posY - 30 / 2 - 10 / 2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:PointA];
    [path addLineToPoint:PointB];
    [path addLineToPoint:PointC];
    
    [path closePath];
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor colorWithRed:0.52f green:0.76f blue:0.07f alpha:1.00f];
    [fillColor set];
    [path fill];
    
    
    // 根据我们设置的各个点连线
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    BOOL b = CGRectContainsPoint(CGRectMake(self.posX - 10 , self.posY - 10, 20, 20),point);
    if(b && (point.x <= 330 && point.x >= 30)){
        self.firstTouchInCircle = true;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    if((point.x <= 330 && point.x >= 30) && self.firstTouchInCircle){
        self.posX = point.x;
        [self setNeedsDisplay];
        
        if(self.progerssListener){
           self.progerssListener((self.posX - 30) / 300);
            
        }
        
        
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.firstTouchInCircle = false;
}

@end
