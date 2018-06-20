//
//  ViewController.m
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "ViewController.h"
#import "LLLabelScorllView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LLLabelScorllView * view = [LLLabelScorllView ll_initWithFrame:CGRectMake(10, 300, self.view.frame.size.width-20, 20) titlesArray: @[@"京东、天猫等 app 首页常见的广告滚动视图首页常见的广告滚动视图首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理", @"建议在 github 上下载"] imgPathArray:@[@"hot",@"",@""] interFaceStyle:^(LLLabelScorllView *view) {
        view.titleColor = [UIColor blueColor];
        view.horizontalScroll = YES;

    }];
    [self.view addSubview:view];

    LLLabelScorllView * llview = [LLLabelScorllView ll_initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 50) topTitlesArray:@[@"京东、天猫等 app 首页常见的广告滚动视图首页常见的广告滚动视图首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理", @"建议在 github 上下载"] topImgPathArray:@[@"hot",@"hot",@"hot"] bottomTitlesArray:@[@"京东、天猫等 app 首页常见的广告滚动视图首页常见的广告滚动视图首页常见的广告滚动视图", @"采用代理设计模式进行封装, 可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理可进行事件点击处理", @"建议在 github 上下载"] bottomImgPathArray:nil interFaceStyle:^(LLLabelScorllView * view) {
        
    }];
    llview.collectionDidSelectBlock = ^(NSIndexPath *indexPath) {
        NSLog(@"%ld",(long)indexPath.item);
    };
    [self.view addSubview:llview];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
