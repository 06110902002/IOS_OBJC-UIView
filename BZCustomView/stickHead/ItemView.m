//
//  ItemView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/4/28.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "ItemView.h"

@interface ItemView ()

@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {

        self.contentView.backgroundColor = [UIColor whiteColor];

        CGFloat spaWidth = frame.size.width;
        CGFloat spaHeight = 40;

        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((spaWidth-spaHeight)/2, 0, spaHeight, spaHeight)];
        _imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imgView];

        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, spaHeight+5, spaWidth, 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_nameLabel];
    }

    return self;
}

@end
