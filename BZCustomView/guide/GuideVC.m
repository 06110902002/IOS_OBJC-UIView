//
//  GuideVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/6/3.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "GuideVC.h"

@interface GuideVC ()
@property(nonatomic,strong) UIView* view1;
@property(nonatomic,strong) UIView* view2;
@property(nonatomic,strong) UIView* view3;

@property(nonatomic,strong)UIImageView* imgView;

@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTestView];
    [self createMaskBgLayer];
    
}

-(void) createTestView{
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 50, 50)];
    self.view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.view1];
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 170, 60, 80)];
    self.view2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.view2];
    
    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(120, 170, 60, 60)];
    self.view3.layer.cornerRadius = 30;
    self.view3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.view3];

}
/**
 创建半透明视图加载在window上,并添加点击手势
 */
-(void) createMaskBgLayer{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView * bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor     = [UIColor blackColor];
    bgView.alpha  = .7f;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sureTapClick:)];
    [bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //获取目标视图在window坐标系的frame
    CGRect rect = [self.view convertRect:self.view3.frame toView:[UIApplication sharedApplication].keyWindow];
    UIEdgeInsets maskInsets = UIEdgeInsetsMake(-8, -8, -8, -8); //创建一个间距
    rect.origin.x += maskInsets.left;
    rect.origin.y += maskInsets.top;
    rect.size.width  -= (maskInsets.left + maskInsets.right);
    rect.size.height -= (maskInsets.top + maskInsets.bottom);
    
    //UIBezierPath 绘制镂空路径
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame ];
    //针对不规则图形，如圆形，遮罩可以使用如下计算：
    
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:30] bezierPathByReversingPath]];
    // bezierPathByReversingPath 的意思就是反转 就是将你设置的路径以外的部分加入到路径中这样 你设置的路径就不在绘制的范围之内。在setMaskLayer的时候 你设置的那部分路径就没有了 就成了镂空的。 clockwise 这个值得意思也是这样。
    
    //渲染路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    [bgView.layer setMask:shapeLayer];
}

- (void)sureTapClick:(UITapGestureRecognizer *)tap{
    UIView * view = tap.view;
    [view removeFromSuperview];
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [view removeGestureRecognizer:tap];
}



@end
