//
//  AbcKeyBoardView.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/25.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "AbcKeyBoardView.h"

#define FIT_X          [UIScreen mainScreen].bounds.size.width/320.000
#define iPhone4        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface AbcKeyBoardView(){
    UIButton *pressButtonCapital;
    UIImageView *bacDaXieImage;
    NSMutableArray* abcArray;
}
@end

@implementation AbcKeyBoardView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        abcArray = [[NSMutableArray alloc] initWithObjects:
                    @"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",
                    @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",
                    @"z",@"x",@"c",@"v",@"b",@"n",@"m", nil];
        
    }
    return self;
}


#pragma override
-(void) createKeyboardView{
    self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgs.png"]];
        //第一排
        for (int i = 0; i < 10; i++){
            [self createKey:abcArray[i]
                       posX:1 + i * 32 * FIT_X
                       posY:5 * FIT_X
                      width:34 * FIT_X
                     height:48 * FIT_X
                      forId:i + 100
                bgNormalImg:@"tu1 (2).png"
              bghighlighted:@"tu1 2.png"];
        }
        
        //第二排
        for (int i = 0; i< 9; i++){
           [self createKey:abcArray[i + 10]
                    posX:16*FIT_X+i*32*FIT_X
                    posY:53*FIT_X
                   width:34 * FIT_X
                  height:48 * FIT_X
                   forId:i + 110
             bgNormalImg:@"tu1 (2).png"
           bghighlighted:@"tu1 2.png"];
            
        }
        
        //第三排
        for (int i = 0; i < 7; i++){
            [self createKey:abcArray[i + 19]
                     posX:46*FIT_X+i*32*FIT_X
                     posY:103*FIT_X
                    width:34 * FIT_X
                   height:48 * FIT_X
                    forId:i + 119
              bgNormalImg:@"tu1 (2).png"
            bghighlighted:@"tu1 2.png"];
        }
        
        //删除
        UIButton *pressButtondelete =[UIButton buttonWithType:UIButtonTypeCustom];
        pressButtondelete.frame =CGRectMake(272*FIT_X, 103*FIT_X, 43*FIT_X, 49*FIT_X);
        [pressButtondelete setBackgroundImage:[UIImage imageNamed:@"tu2 2.png"] forState:UIControlStateNormal];
        [pressButtondelete setBackgroundImage:[UIImage imageNamed:@"tu2 (2).png"] forState:UIControlStateHighlighted];
        [pressButtondelete addTarget:self action:@selector(deleteTextField) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pressButtondelete];
        
        UIImageView *backGrodImage =[[UIImageView alloc]initWithFrame:CGRectMake(277*FIT_X, 113*FIT_X, 32*FIT_X, 28*FIT_X)];
        backGrodImage.image =[UIImage imageNamed:@"tu2 (3).png"];
        [self addSubview:backGrodImage];
        
        //大写
        pressButtonCapital =[UIButton buttonWithType:UIButtonTypeCustom];
        pressButtonCapital.frame =CGRectMake(1, 103*FIT_X, 43*FIT_X, 49*FIT_X);
        [pressButtonCapital setBackgroundImage:[UIImage imageNamed:@"tu2 2.png"] forState:UIControlStateNormal];
        [pressButtonCapital setBackgroundImage:[UIImage imageNamed:@"tu2 (2).png"] forState:UIControlStateHighlighted];
        [pressButtonCapital setBackgroundImage:[UIImage imageNamed:@"tu2 (2).png"] forState:UIControlStateSelected];
        [pressButtonCapital addTarget:self action:@selector(pressCapitalAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pressButtonCapital];
        
        bacDaXieImage =[[UIImageView alloc]initWithFrame:CGRectMake(7*FIT_X, 113*FIT_X, 31*FIT_X, 27*FIT_X)];
        bacDaXieImage.image =[UIImage imageNamed:@"da_.png"];
        [self addSubview:bacDaXieImage];
        
        //123
        UIButton *pressButtonReturn =[UIButton buttonWithType:UIButtonTypeCustom];
        pressButtonReturn.frame =CGRectMake(0, 152*FIT_X, 80*FIT_X, 49*FIT_X);
        [pressButtonReturn setBackgroundImage:[UIImage imageNamed:@"tu3-4"] forState:UIControlStateNormal];
        [pressButtonReturn setBackgroundImage:[UIImage imageNamed:@"tu3-04 (2).png"] forState:UIControlStateHighlighted];
        [pressButtonReturn addTarget:self action:@selector(changeNumberKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pressButtonReturn];
        
        UILabel *pressButtonReturnLabel =[[UILabel alloc] init];
        pressButtonReturnLabel.frame =pressButtonReturn.frame;
        pressButtonReturnLabel.backgroundColor =[UIColor clearColor];
        pressButtonReturnLabel.textColor =[UIColor whiteColor];
        pressButtonReturnLabel.textAlignment =NSTextAlignmentCenter;
        pressButtonReturnLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:18*FIT_X];
        pressButtonReturnLabel.text =@"1 2 3";
        [self addSubview:pressButtonReturnLabel];
        
        //空格
        UIButton *pressButtonZeroTwo =[UIButton buttonWithType:UIButtonTypeCustom];
        pressButtonZeroTwo.frame =CGRectMake(80*FIT_X, 152*FIT_X, 160*FIT_X, 49*FIT_X);
        [pressButtonZeroTwo setBackgroundImage:[UIImage imageNamed:@"tu4 (2).png"] forState:UIControlStateNormal];
        [pressButtonZeroTwo setBackgroundImage:[UIImage imageNamed:@"tu4 2.png"] forState:UIControlStateHighlighted];
        pressButtonZeroTwo.tag =24;
        [pressButtonZeroTwo addTarget:self action:@selector(addSpaceAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pressButtonZeroTwo];
        
        UILabel *pressButtonZeroTwoLabel =[[UILabel alloc] init];
        pressButtonZeroTwoLabel.frame =pressButtonZeroTwo.frame;
        pressButtonZeroTwoLabel.backgroundColor =[UIColor clearColor];
        pressButtonZeroTwoLabel.textAlignment =NSTextAlignmentCenter;
        pressButtonZeroTwoLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:18*FIT_X];
        pressButtonZeroTwoLabel.text =@"空格";
        [self addSubview:pressButtonZeroTwoLabel];
        
        //搜索
        UIButton *pressButtonSearch =[UIButton buttonWithType:UIButtonTypeCustom];
        pressButtonSearch.frame =CGRectMake(240*FIT_X, 152*FIT_X, 80*FIT_X, 49*FIT_X);
        [pressButtonSearch setBackgroundImage:[UIImage imageNamed:@"tu3-4"] forState:UIControlStateNormal];
        [pressButtonSearch setBackgroundImage:[UIImage imageNamed:@"tu3-04 (2).png"] forState:UIControlStateHighlighted];
        [pressButtonSearch addTarget:self action:@selector(searchAllTextField) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pressButtonSearch];
        
        UILabel *pressButtonSearchLabel =[[UILabel alloc] init];
        pressButtonSearchLabel.frame =pressButtonSearch.frame;
        pressButtonSearchLabel.backgroundColor =[UIColor clearColor];
        pressButtonSearchLabel.textColor =[UIColor whiteColor];
        pressButtonSearchLabel.textAlignment =NSTextAlignmentCenter;
        pressButtonSearchLabel.font =[UIFont fontWithName:@"STHeitiSC-Light" size:18*FIT_X];
        pressButtonSearchLabel.text =@"搜索";
        [self addSubview:pressButtonSearchLabel];
    
}

//删除一位
-(void)deleteTextField{
    
    
    
}

//清除
-(void)clearAllTextField
{
    
}

//搜索
-(void)searchAllTextField
{
   
}

//隐藏
-(void)goReturn
{
    [self resignFirstResponder];
}

-(CGRect)frameForSettingButtonUnderImage:(NSInteger)index
{
    CGFloat x;
    CGFloat y;
    int indexHeight;
    int height;
    indexHeight =60*FIT_X;
    height =5*FIT_X;
    
    if(index%3==0)
    {
        x =68*FIT_X;
        y =height +index/3 *indexHeight;
    }
    else if (index%3==1)
    {
        x =131*FIT_X;
        y =height +index/3 *indexHeight;
    }
    else
    {
        x =194*FIT_X;
        y =height +index/3*indexHeight;
    }
    
    if (index==9)
    {
        return CGRectMake(131*FIT_X, 185*FIT_X, 58*FIT_X, 55*FIT_X);
    }
    return CGRectMake(x,y,58*FIT_X,55*FIT_X);
}


-(void)goPressSecondKeyButtons:(UIButton *)btn
{
    
    NSString *addString=@"";
    switch (btn.tag)
    {
        case 100:
            addString =@"q";
            break;
        case 101:
            addString =@"w";
            break;
        case 102:
            addString =@"e";
            break;
        case 103:
            addString =@"r";
            break;
        case 104:
            addString =@"t";
            break;
        case 105:
            addString =@"y";
            break;
        case 106:
            addString =@"u";
            break;
        case 107:
            addString =@"i";
            break;
        case 108:
            addString =@"o";
            break;
        case 109:
            addString =@"p";
            break;
        case 110:
            addString =@"a";
            break;
        case 111:
            addString =@"s";
            break;
        case 112:
            addString =@"d";
            break;
        case 113:
            addString =@"f";
            break;
        case 114:
            addString =@"g";
            break;
        case 115:
            addString =@"h";
            break;
        case 116:
            addString =@"j";
            break;
        case 117:
            addString =@"k";
            break;
        case 118:
            addString =@"l";
            break;
        case 120:
            addString =@"z";
            break;
        case 121:
            addString =@"x";
            break;
        case 122:
            addString =@"c";
            break;
        case 123:
            addString =@"v";
            break;
        case 124:
            addString =@"b";
            break;
        case 125:
            addString =@"n";
            break;
        case 126:
            addString =@"m";
            break;
        default:
            break;
    }
    
    if (pressButtonCapital.selected)
    {
        addString =[addString uppercaseString];
    }
   
}

//切换到123键盘
-(void)changeNumberKeyBoard
{
   
}

//空格
-(void)addSpaceAction{
   
}

//大小写切换
-(void)pressCapitalAction:(UIButton *)button{
    
    if (button.selected){
        button.selected = NO;
        bacDaXieImage.image =[UIImage imageNamed:@"da_.png"];
        [abcArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSString* tmp = obj;
            abcArray[idx] = [tmp lowercaseString];
            UIButton* key = (UIButton*)[self viewWithTag:100 + idx];
            [key setTitle:abcArray[idx] forState:UIControlStateNormal];
        }];
    }
    else{
        button.selected = YES;
        bacDaXieImage.image =[UIImage imageNamed:@"da.png"];
        [abcArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSString* tmp = obj;
            abcArray[idx] = [tmp uppercaseString];
            UIButton* key = (UIButton*)[self viewWithTag:100 + idx];
            [key setTitle:abcArray[idx] forState:UIControlStateNormal];
            
        }];
    }

    
   
}

@end
