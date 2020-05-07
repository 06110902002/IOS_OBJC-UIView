//
//  RunloopVC.m
//  BZCustomView
//
//  Created by Liu Xiaobing on 2020/5/6.
//  Copyright © 2020 刘小兵. All rights reserved.
//

#import "RunloopVC.h"

@interface RunloopVC ()
@property(nonatomic,strong) NSThread* thread;
@property(nonatomic,assign) BOOL isLoopRunning;

@end

@implementation RunloopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* runloop = [[UIButton alloc] initWithFrame:CGRectMake(230, 70, 180, 30)];
    runloop.backgroundColor = [UIColor grayColor];
    runloop.tag = 19;
    [runloop setTitle:@"启动runloop" forState:UIControlStateNormal];
    [runloop addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runloop];
    
    UIButton* addrunloop = [[UIButton alloc] initWithFrame:CGRectMake(30, 70, 180, 30)];
    addrunloop.backgroundColor = [UIColor grayColor];
    addrunloop.tag = 20;
    [addrunloop setTitle:@"往runloop添加事件" forState:UIControlStateNormal];
    [addrunloop addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addrunloop];
    
    UIButton* exitrunloop = [[UIButton alloc] initWithFrame:CGRectMake(30, 120, 180, 30)];
    exitrunloop.backgroundColor = [UIColor grayColor];
    exitrunloop.tag = 21;
    [exitrunloop setTitle:@"退出runloop" forState:UIControlStateNormal];
    [exitrunloop addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitrunloop];
}

-(void)onClick:(UIButton*) button{
    switch (button.tag) {
        case 19:{
            self.isLoopRunning = YES; // global
            // 创建线程，并调用run1方法执行任务
            self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run1) object:nil];
            // 开启线程
            [self.thread start];
        }
            break;
            
            case 20:
                 [self performSelector:@selector(addEventIntoRunloop) onThread:self.thread withObject:nil waitUntilDone:NO];
            break;
            
        case 21:{
            [self quitLoop];
        }
            break;
            
        default:
            break;
    }
}

- (void)run1{
    // 这里写任务
    NSLog(@"----run1-----");

    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
   // [[NSRunLoop currentRunLoop] run];  这种方式runloop永远不退出
    while (self.isLoopRunning && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

    // 测试是否开启了RunLoop，如果开启RunLoop，则来不了这里，因为RunLoop开启了循环。
    NSLog(@"RunLoop已经退出了");
}

- (void)addEventIntoRunloop{
    // 这里写任务
    NSLog(@"----这里执行添加到rubloop的事件-----");
}

/**
 第一种启动方式的退出方法

 文档说，如果想退出runloop，不应该使用第一种启动方式来启动runloop。

 如果runloop没有input sources或者附加的timer，runloop就会退出。
 虽然这样可以将runloop退出，但是苹果并不建议我们这么做，因为系统内部有可能会在当前线程的runloop中添加一些输入源，所以通过手动移除input source或者timer这种方式，并不能保证runloop一定会退出。

 第二种启动方式runUntilDate:

 可以通过设置超时时间来退出runloop。

 第三种启动方式runMode:beforeDate:

 通过这种方式启动，runloop会运行一次，当超时时间到达或者第一个输入源被处理，runloop就会退出。

 如果我们想控制runloop的退出时机，而不是在处理完一个输入源事件之后就退出，那么就要重复调用runMode:beforeDate:，
 
 - (void)run;

 - (void)runUntilDate:(NSDate *)limitDate；

 - (void)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;
 
 
 NSRunLoop *myLoop  = [NSRunLoop currentRunLoop];
  NSPort* myPort = (NSMachPort *)[NSMachPort port];
  [myLoop addPort:myPort forMode:NSDefaultRunLoopMode];

 self.isLoopRunning = YES; // global

 while (self.isLoopRunning && [myLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
 */

//退出runloop的地方
- (void)quitLoop{
    
    self.isLoopRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
