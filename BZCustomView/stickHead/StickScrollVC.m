//
//  StickScrollVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/28.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "StickScrollVC.h"
#import "CollectionViewLayout.h"
#import "ItemView.h"
#import "MicroTool.h"
#import "UIScrollView+LXBScrollView.h"
#import "ScrollNavBar.h"
#import "UIView+LXB.h"

static NSString *ItemIdentifier = @"ItemIdentifier";
static NSString *leaveDetailsHeadID = @"leaveDetailsHeadID";
static NSString *leaveDetailsFooterID = @"leaveDetailsFooterID";

@interface StickScrollVC ()<UICollectionViewDelegate,UICollectionViewDataSource,ScrollNavBarChangeListener>{
    NSMutableArray *listArray;
}

@property (assign, nonatomic) CGFloat headerHeight;
// 我的应用数据源数组
@property (strong, nonatomic) NSMutableArray *myDataArray;
// 最近使用数据源数组
@property (strong, nonatomic) NSMutableArray *latelyDataArray;
// 底下数据源数组
@property (strong, nonatomic) NSMutableArray *dataArray;
// 记录用于滚动选择判断的 contentOffset.y
@property (strong, nonatomic) NSMutableArray *pageSelectYArray;


@property (strong, nonatomic)  UIView *pageSuperView;
@property (strong, nonatomic)  UIView *pageSuperViewSuperView;
@property (strong, nonatomic)  UIView *headerView;

@property (strong, nonatomic)  UICollectionView *collectionViewFour;
@property (strong, nonatomic) ScrollNavBar *fptView;
@property (assign, nonatomic) BOOL isSelectTitle;






@end

@implementation StickScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    self.view.backgroundColor = BgColor;
    listArray = [NSMutableArray arrayWithObjects:@"便民生活",@"财富管理",@"资金往来",@"购物娱乐",@"教育公益",@"第三方服务", nil];
    [self createCollectionView];
    
    
    
    UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(30, 20, 130, 30)];
    back.backgroundColor = [UIColor grayColor];
    back.tag = 10;
    [back setTitle:@"back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    
    [self initData];

}

-(void) initData{

    self.dataArray = [[NSMutableArray alloc] init];
    self.dataArray = @[@{@"便民生活" : @[@"充值中心", @"信用卡还款", @"生活缴费", @"城市服务", @"我的快递", @"医疗健康", @"记账本", @"发票管家", @"车主服务", @"交通出行", @"体育服务", @"安全备忘"]},
    @{@"财富管理" : @[@"余额宝", @"花呗", @"芝麻信用", @"借呗", @"蚂蚁保险", @"汇率换算"]},
    @{@"资金往来" : @[@"转账", @"红包", @"AA收款", @"亲情号", @"商家服务"]},
    @{@"购物娱乐" : @[@"出境", @"彩票", @"奖励金"]},
    @{@"教育公益" : @[@"校园生活", @"蚂蚁森林", @"蚂蚁庄园", @"中小学", @"运动", @"亲子账户"]},
    @{@"第三方服务" : @[@"淘票票电影", @"滴滴出行", @"饿了么外卖", @"天猫", @"淘宝", @"火车票机票", @"飞猪酒店", @"蚂上租租房", @"高德打车", @"哈啰出行"]}].mutableCopy;
    
    
    // 计算需要选中的 contentOffset.y 保存
    self.pageSelectYArray = [[NSMutableArray alloc] init];
    __block CGFloat oldY = 0.0;
    __block CGFloat newY = 0.0;
    [self.dataArray enumerateObjectsUsingBlock:^(NSMutableDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *items = [obj allValues].firstObject;
        NSInteger num = ceilf(items.count / 4.0);
        newY = newY + (idx == 0 ? 10.0 : 50.0) + num * 70.0;
        [self.pageSelectYArray addObject:@[@(oldY), @(newY)]];
        oldY = oldY + (idx == 0 ? 10.0 : 50.0) + num * 70.0;
    }];
    
    [self setHeader];
    
}

#pragma mark - 头部视图配置
- (void)setHeader {
    

    // 设置头高度（可动态适配，我这边只用于示例代码因此是写死的高度）
    self.headerHeight = 454.0 + 10.0;
    // 添加头
    self.headerView = [[UIView alloc] init];
    self.headerView.frame = CGRectMake(0.0, -self.headerHeight, lgf_ScreenWidth, self.headerHeight);
    [self.collectionViewFour addSubview:self.headerView];
    [self.collectionViewFour sendSubviewToBack:self.headerView];
    // 添加 LGFFreePTView 父控件
    self.pageSuperViewSuperView = [[UIView alloc] init];
    self.pageSuperViewSuperView.frame = CGRectMake(0.0, -10.0, lgf_ScreenWidth, 48.0);
    self.pageSuperViewSuperView.backgroundColor = [UIColor greenColor];
    [self.collectionViewFour addSubview:self.pageSuperViewSuperView];
    
    [self setCVContentInset:0.0];
    
    self.fptView = [[ScrollNavBar alloc] initWithFrame:CGRectMake(0, 10, lgf_ScreenWidth, 83)];
    self.fptView.delegate = self;
    [self.fptView iniTitles:listArray];
    [self.pageSuperViewSuperView addSubview:self.fptView];

}

- (void)setCVContentInset:(CGFloat)top {
    CGFloat lastY = lgf_ScreenHeight - IPhoneX_NAVIGATION_BAR_HEIGHT - 40 - ([[[self.pageSelectYArray lastObject] lastObject] floatValue] - [[[self.pageSelectYArray lastObject] firstObject] floatValue] + top);
    [self.collectionViewFour setContentInset:UIEdgeInsetsMake(self.headerHeight, 0.0, lastY, 0.0)];
    [self.collectionViewFour lgf_ScrollToTopAnimated:NO];
}

-(void)onClick:(UIButton*) view{
    [self.navigationController popViewControllerAnimated:false];
}

-(void)createCollectionView{

    CGRect size = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 64);
    CollectionViewLayout *mcvl=[[CollectionViewLayout alloc] init];
    self.collectionViewFour = [[UICollectionView alloc] initWithFrame:size collectionViewLayout:mcvl];

    [self.collectionViewFour registerClass:[ItemView class] forCellWithReuseIdentifier:ItemIdentifier];

    self.collectionViewFour.showsHorizontalScrollIndicator=NO;
    self.collectionViewFour.showsVerticalScrollIndicator=NO;
    self.collectionViewFour.backgroundColor=[UIColor whiteColor];
    self.collectionViewFour.delegate = self;
    self.collectionViewFour.dataSource = self;
    //一定要注册headview
    [self.collectionViewFour registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:leaveDetailsHeadID];
    //一定要注册footerview
    [self.collectionViewFour registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:leaveDetailsFooterID];
    [self.view addSubview:self.collectionViewFour];

}


//有多少个sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return listArray.count;

}
//每个section 中有多少个items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSArray *items = [self.dataArray[section] allValues].firstObject;
    return items.count;

}
//section X item X位置处应该显示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemView *cell=nil;
    if (cell==nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];

    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    if (indexPath.row/2 == 0) {
        cell.imgView.backgroundColor = [UIColor redColor];
    }else{
        cell.imgView.backgroundColor = [UIColor greenColor];
    }
    cell.nameLabel.text = [self.dataArray[indexPath.section] allValues].firstObject[indexPath.item];
    return cell;
}
//cell的header与footer的显示内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *reusableHeaderView = nil;
        if (reusableHeaderView==nil) {
            reusableHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                   withReuseIdentifier:leaveDetailsHeadID
                                                                         forIndexPath:indexPath];
            reusableHeaderView.backgroundColor = [UIColor whiteColor];
            UILabel *label = (UILabel *)[reusableHeaderView viewWithTag:100];
            if (!label) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 40)];
                label.tag = 100;
                [reusableHeaderView addSubview:label];
            }
            label.text = listArray[indexPath.section];

        }
        if (indexPath.section == 0) {
            reusableHeaderView.lgf_height = 0.0;
        } else {
            reusableHeaderView.lgf_height = 40.0;
        }
        return reusableHeaderView;

    }else if (kind == UICollectionElementKindSectionFooter){

        UICollectionReusableView *reusableFooterView = nil;
        if (reusableFooterView == nil) {

            reusableFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:leaveDetailsFooterID forIndexPath:indexPath];
            reusableFooterView.backgroundColor = BgColor;
        }

        return reusableFooterView;
    }
    return nil;
    
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionViewFour) {
        // 这一句用于设置 pageSuperViewSuperView 顶端悬停效果
        self.pageSuperViewSuperView.lgf_y = MAX(-18.0, (scrollView.contentOffset.y - 8.0));
        if (!self.isSelectTitle){
            [self.pageSelectYArray enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat realY = scrollView.contentOffset.y;
                if (realY > [obj.firstObject floatValue] && realY < [obj.lastObject floatValue]) {
                    [self.fptView startLineMoveAnimFromValue:idx];
                }
            }];
        }
    }
}

//滑动条的滚动接口
- (void)onChangeListener:(NSInteger)index{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(configIsSelectTitle) object:nil];
    self.isSelectTitle = YES;
     [self.collectionViewFour setContentOffset:CGPointMake(0, [[self.pageSelectYArray[index] firstObject] floatValue] ) animated:YES];
    [self performSelector:@selector(configIsSelectTitle) withObject:nil afterDelay:0.3];

}

- (void)configIsSelectTitle {
    self.isSelectTitle = NO;
}

@end
