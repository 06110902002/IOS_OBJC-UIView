//
//  StackGame.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/10.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "StackGame.h"

@interface StackGame()
@property(nonatomic,strong) NSArray* mazeArray;
@property(nonatomic,strong) NSMutableArray* storeArray;  //用来存放访问过的数组
@property(nonatomic,assign) NSInteger row,col;
@property(nonatomic,assign) NSInteger visited; //代表访问过的标签
@property(nonatomic,assign) NSInteger wall;
@property(nonatomic,assign) NSInteger pass;
@property(nonatomic,assign) NSInteger exit;

@end


@implementation StackGame
-(instancetype) init{
    self = [super init];
    if(self){
        [self initData];
    }
    return self;
}

-(void)initData{
    
    self.visited = 4;
    self.wall = 1;
    self.pass = 0;
    self.exit = 2;
    
    NSArray* firstRow = @[@"1",@"1",@"1",@"1",@"1",@"1"];
    NSArray* secRow =   @[@"1",@"1",@"1",@"0",@"0",@"1"];
    NSArray* thirdRow = @[@"1",@"0",@"0",@"0",@"2",@"1"];
    NSArray* fourRow =  @[@"1",@"0",@"0",@"s",@"1",@"1"];
    NSArray* fiveRow =  @[@"1",@"1",@"1",@"1",@"1",@"1"];
    
    self.mazeArray = [[NSArray alloc] initWithObjects:firstRow,secRow,thirdRow,fourRow,fiveRow,nil];
    self.mazeStack = [[Stack alloc] initWithSize:30];
    self.curCell =   [[Cell alloc] init:3 y:3];
    self.enterCell = [[Cell alloc] init:3 y:3];
    self.exitCell =  [[Cell alloc] init:2 y:4];
    self.storeArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < 5; i ++) {
        [self.storeArray addObject:[[NSMutableArray alloc] init]];
    }
    
    for (int i = 0; i < 5; i ++) {
        for (int j = 0 ; j < 6; j ++) {
            
            NSString* tmp = [[self.mazeArray objectAtIndex:i] objectAtIndex:j];
            if([tmp isEqualToString:@"0"] || [tmp isEqualToString:@"2"] || [tmp isEqualToString:@"s"]){
                [[self.storeArray objectAtIndex:i] addObject:tmp];
                //self.storeArray[i][j] = tmp;
            }else{
                 [[self.storeArray objectAtIndex:i] addObject:@"1"];
                //self.storeArray[i][j] = @"1"; 也可以使用下标的方式访问
            }
            
        }
    }
}

-(void) pushUnVisited:(NSInteger)x y:(NSInteger)y{
    Cell* cell = [[Cell alloc] init:x y:y];
    NSString* tmp = [[self.storeArray objectAtIndex:x] objectAtIndex:y];
    if ([tmp isEqualToString:@"0"] || [tmp isEqualToString:@"2"]) {
        [self.mazeStack push:cell];
        NSLog(@"78------:入栈x：%ld  y:%ld",x,y);
    }
    
}

-(void) queryPath{
    NSInteger row = 0;
    NSInteger col = 0;
    while (!([self.curCell isEqual:self.exitCell])) {
        row = self.curCell.x;
        col = self.curCell.y;
        NSLog(@"53--------经过的路径结点坐标 x:%ld y:%ld",row,col);
        if(![self.curCell isEqual:self.enterCell]){
            
            NSMutableArray* rowarray = [self.storeArray objectAtIndex:row];
            //代表访问过了
            [rowarray replaceObjectAtIndex:col withObject:@"."];
        }
        
        [self pushUnVisited:row - 1 y:col];
        [self pushUnVisited:row + 1 y:col];
        [self pushUnVisited:row  y:col - 1];
        [self pushUnVisited:row  y:col + 1];

        if([self.mazeStack isEmpty]){
            NSLog(@"83--------  无出路 寻找失败：node x:%ld y:%ld",row,col);
            return;
        }else{
            self.curCell =(Cell*)[self.mazeStack pop];
            NSLog(@"105-------出栈x：%ld y :%ld  栈大小:%ld",self.curCell.x,self.curCell.y,[self.mazeStack count]);
        }
    }
    
    printf("90-------寻找成功 x:%ld y:%ld:\n",self.curCell.x,self.curCell.y);
    NSMutableArray* rowarray = [self.storeArray objectAtIndex:self.curCell.x]; //将最后一个结点置为走过，真实的路径可以不需要此步
    [rowarray replaceObjectAtIndex:self.curCell.y withObject:@"."];
    [self printPath];
}

-(void) printPath{
    for (int i = 0; i < 5; i ++) {
        for (int j = 0 ; j < 6; j ++){
            NSString* tmp = [[self.storeArray objectAtIndex:i] objectAtIndex:j];
            printf(" %s ",[tmp UTF8String]);
        }
        printf("\n");
    }
}



@end
