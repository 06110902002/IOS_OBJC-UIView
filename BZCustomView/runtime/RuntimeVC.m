//
//  RuntimeVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/7/4.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "RuntimeVC.h"
#import "NSArray+CrashHandle.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Son+Swizzle.h"
#import "Father.h"

@interface RuntimeVC ()

@property(nonatomic,strong) NSArray* array;

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   UIButton* swizzMethod = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 180, 30)];
   swizzMethod.backgroundColor = [UIColor grayColor];
   swizzMethod.tag = 14;
   [swizzMethod setTitle:@"使用Runtime方法交换" forState:UIControlStateNormal];
   [swizzMethod addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:swizzMethod];
    
    UIButton* msgSend = [[UIButton alloc] initWithFrame:CGRectMake(220, 50, 180, 30)];
    msgSend.backgroundColor = [UIColor grayColor];
    msgSend.tag = 15;
    [msgSend setTitle:@"消息转换发" forState:UIControlStateNormal];
    [msgSend addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msgSend];
    
    
    UIButton* qut = [[UIButton alloc] initWithFrame:CGRectMake(30, 90, 180, 30)];
       qut.backgroundColor = [UIColor grayColor];
       qut.tag = 16;
       [qut setTitle:@"方法交换的问题" forState:UIControlStateNormal];
       [qut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:qut];
}

-(void) onClick:(UIButton*) button{
    
    switch (button.tag) {
        case 14:
            [self testArray];
            break;
            
        case 15:
            [self testMsgSend];
            break;
            
        case 16:
            [self testSwitchMethodQuestion];
            break;
            
        default:
            break;
    }
}



/**
  使用方法交换之后处理数组越界，防止越界导致crash，并异常信息打印出来
 */
-(void) testArray{
    if(!self.array){
        self.array = @[@"a",@"c"];
    }
    NSLog(@"47-------:%@",[self.array objectAtIndex:2]);
}



/// 测试消息转发过程
-(void) testMsgSend{
    [self performSelector:@selector(myTestPrint:) withObject:@"，你好 ！"];
}


void myMethod(id self, SEL _cmd,NSString *nub) {
NSLog(@"ifelseboyxx%@",nub);
}

//第一次v进行
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(myTestPrint:)) {
    #pragma clang diagnostic pop
    class_addMethod([self class],sel,(IMP)myMethod,"v@:@");
        return YES;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}
// 第二次
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wundeclared-selector"
//    if (aSelector == @selector(myTestPrint:)) {
//    #pragma clang diagnostic pop
//        return [Person new];
//    }else{
//        return [super forwardingTargetForSelector:aSelector];
//    }
//}



// 第三次  如果第三次还未找到对应的方法实现则crash

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wundeclared-selector"
//    if (aSelector == @selector(myTestPrint:)) {
//    #pragma clang diagnostic pop
//    return [NSMethodSignature  signatureWithObjCTypes:"v@:@"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    Person *person = [Person new];
//    Animal *animal = [Animal new];
//    if ([person respondsToSelector:anInvocation.selector]) {
//    [anInvocation invokeWithTarget:person];
//    }
//    if ([animal respondsToSelector:anInvocation.selector]) {
//    [anInvocation invokeWithTarget:animal];
//    }
//}

- (void)dealloc
{
    //[super dealloc];
}

//测试方法交换的问题
-(void) testSwitchMethodQuestion{
//    Son *son = [Son new];
//    [son cry];
    
     Father *aFather = [Father new];
    [aFather work];
}


@end
