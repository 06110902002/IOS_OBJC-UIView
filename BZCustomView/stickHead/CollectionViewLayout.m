//
//  CollectionViewLayout.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/28.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout ()

@end

@implementation CollectionViewLayout

-(id)init
{
    if (!(self = [super init])) return nil;

    CGSize size = [[UIScreen mainScreen] bounds].size;


//    CGFloat cellSpace = 5.0;
//    CGFloat cellWidth = (size.width - cellSpace * (4 + 1)) / 4;//总宽－5个间隔（4个cell）
    CGFloat cellSpace = 0.0;
    CGFloat cellWidth = size.width / 4.0;

    self.itemSize = CGSizeMake(cellWidth, 70);//Item size(每个item的大小)
    self.sectionInset = UIEdgeInsetsMake(cellSpace, cellSpace, cellSpace, cellSpace);//某个section中cell的边界范围。
    self.headerReferenceSize = CGSizeMake(size.width, 40);//每个section的Header宽高
    self.footerReferenceSize = CGSizeMake(size.width, 20);//每个section的Footer宽高

    self.minimumInteritemSpacing = cellSpace;//Inter cell spacing（每行内部cell item的间距）
    self.minimumLineSpacing = cellSpace;//Line spacing（每行的间距）

    return self;
}

@end
