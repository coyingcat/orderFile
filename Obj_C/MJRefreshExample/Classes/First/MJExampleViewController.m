//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJExampleViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExampleViewController.h"
#import "MJTableViewController.h"
#import "MJWebViewViewController.h"
#import "MJCollectionViewController.h"
#import "MJExample.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"
#import "MJHorizontalCollectionViewController.h"
#import "MJRefreshExample-Swift.h"














#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>
#import <dlfcn.h>
#import <libkern/OSAtomic.h>


extern CFAbsoluteTime StartTime;



//定义原子队列
static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

//定义符号结构体
typedef struct{
    void *pc;
    void *next;
} SYNode;






void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint64_t N;  // Counter for the guards.
  if (start == stop || *start) return;  // Initialize only once.
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;
}


void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//  if (!*guard) return;
  //当前函数返回到上一个调用的地址!!
    
    
    
    
    
    
    
    
    
    //  builtin , 当前内部
    
    
    
    //  return， 返回
    
    
    
    
    
    void *PC = __builtin_return_address(0);
    
    
    // 0 的意思是
    
    // PC 是我们的返回地址
    
    // 这一个函数，调用完毕了，
    // 回到，哪个地方去 （ 当前函数，回到，哪个地方去 ）
    
    
    // 这个函数，被别人调用了的，返回地址
    
    
    
    
    
    
    
    // 1 的意思是，
    // 当前函数的调用者的，返回地址
    // （ 上一个函数，回到，哪个地方去 ）
    
    
    
    //  void *PC = __builtin_return_address(1);
    
    
    
    //创建结构体!
   SYNode * node = malloc(sizeof(SYNode));
    *node = (SYNode){PC};
    
    //加入结构!
    
    //  Offsetof requires struct, union, or class type, 'void *' invalid
    OSAtomicEnqueue(&symbolList, node, offsetof(SYNode, next));
}







static NSString *const MJExample00 = @"UITableView + 下拉刷新";
static NSString *const MJExample10 = @"UITableView + 上拉刷新";
static NSString *const MJExample20 = @"UICollectionView";
static NSString *const MJExample30 = @"UIWebView";
static NSString *const MJExample40 = @"WKWebView";

@interface MJExampleViewController()
@property (strong, nonatomic) NSArray *examples;
@end

@implementation MJExampleViewController

- (NSArray *)examples
{
    if (!_examples) {
        MJExample *exam0 = [[MJExample alloc] init];
        exam0.header = MJExample00;
        exam0.vcClass = [MJTableViewController class];
        exam0.titles = @[@"默认", @"动画图片", @"隐藏时间", @"隐藏状态和时间", @"自定义文字", @"自定义刷新控件"];
        exam0.methods = @[@"example01", @"example02", @"example03", @"example04", @"example05", @"example06"];
        
        MJExample *exam1 = [[MJExample alloc] init];
        exam1.header = MJExample10;
        exam1.vcClass = [MJTableViewController class];
        exam1.titles = @[@"默认", @"动画图片", @"隐藏刷新状态的文字", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏", @"自动回弹的上拉01", @"自动回弹的上拉02", @"自定义刷新控件(自动刷新)", @"自定义刷新控件(自动回弹)"];
        exam1.methods = @[@"example11", @"example12", @"example13", @"example14", @"example15", @"example16", @"example17", @"example18", @"example19", @"example20", @"example21"];
        
        MJExample *exam2 = [[MJExample alloc] init];
        exam2.header = MJExample20;
        exam2.vcClass = [MJCollectionViewController class];
        exam2.titles = @[@"上下拉刷新"];
        exam2.methods = @[@"example21"];
        
        MJExample *exam3 = [[MJExample alloc] init];
        exam3.header = MJExample30;
        exam3.vcClass = [MJWebViewViewController class];
        exam3.titles = @[@"下拉刷新"];
        exam3.methods = @[@"example31"];
        
        MJExample *exam4 = [[MJExample alloc] init];
        exam4.header = MJExample40;
        exam4.vcClass = [MJWKWebViewController class];
        exam4.titles = @[@"下拉刷新"];
        exam4.methods = @[@"example41"];
        
        MJExample *exam5 = [[MJExample alloc] init];
        exam5.header = MJExample20;
        exam5.vcClass = [MJHorizontalCollectionViewController class];
        exam5.titles = @[@"左拉刷新"];
        exam5.methods = @[@"example42"];
        
        self.examples = @[exam0, exam1, exam2, exam3, exam4, exam5];
    }
    return _examples;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        });
    }];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    CFAbsoluteTime doneTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"AppLanuch--main after 使用了 --    \n%f  秒 \n",(doneTime - StartTime));
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MJExample *exam = self.examples[section];
    return exam.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"example";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    MJExample *exam = self.examples[indexPath.section];
    cell.textLabel.text = exam.titles[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", exam.vcClass, exam.methods[indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MJExample *exam = self.examples[section];
    return exam.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self doTrigger];
    MJExample *exam = self.examples[indexPath.section];
    UIViewController *vc = [[exam.vcClass alloc] init];
    vc.title = exam.titles[indexPath.row];
    [vc setValue:exam.methods[indexPath.row] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
}






-(void) doTrigger {
    //定义数组
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
    
    while (YES) {//一次循环!也会被HOOK一次!!
       SYNode * node = OSAtomicDequeue(&symbolList, offsetof(SYNode, next));
        
        if (node == NULL) {
            break;
        }
        Dl_info info = {0};
        dladdr(node->pc, &info);
//        printf("%s \n",info.dli_sname);
        NSString * name = @(info.dli_sname);
        free(node);
        
        BOOL isObjc = [name hasPrefix:@"+["]||[name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
        //是否去重??
        [symbolNames addObject:symbolName];
        /*
        if ([name hasPrefix:@"+["]||[name hasPrefix:@"-["]) {
            //如果是OC方法名称直接存!
            [symbolNames addObject:name];
            continue;
        }
        //如果不是OC直接加个_存!
        [symbolNames addObject:[@"_" stringByAppendingString:name]];
         */
    }
    //反向数组
//    symbolNames = (NSMutableArray<NSString *>*)[[symbolNames reverseObjectEnumerator] allObjects];
    NSEnumerator * enumerator = [symbolNames reverseObjectEnumerator];
    
    //创建一个新数组
    NSMutableArray * funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString * name;
    //去重!
    while (name = [enumerator nextObject]) {
        if (![funcs containsObject:name]) {//数组中不包含name
            [funcs addObject:name];
        }
    }
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    //数组转成字符串
    NSString * funcStr = [funcs componentsJoinedByString:@"\n"];
    //字符串写入文件
    
    NSLog(@"__\n\n%@", funcStr);
    /*
    //文件路径
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"fast.order"];
    //文件内容
    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
     */
}








@end
