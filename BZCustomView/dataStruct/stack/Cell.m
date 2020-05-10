//
//  Cell.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "Cell.h"

@interface Cell()


@end

@implementation Cell

-(instancetype) init:(NSInteger)x y:(NSInteger)y{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

-(BOOL) isEqual:(Cell *)object{
    return self.x == object.x && self.y == object.y;
}

@end
