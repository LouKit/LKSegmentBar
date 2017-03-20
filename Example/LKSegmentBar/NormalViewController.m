//
//  NormalViewController.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/17.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "NormalViewController.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "TestViewController3.h"
#import "LKSegmentController.h"

@interface NormalViewController ()

@property (nonatomic,strong) LKSegmentController *segmentBarVc1;
@property (nonatomic,strong) LKSegmentController *segmentBarVc2;

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"普通分段模式";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self test1];
    [self test2];
    
    
}

-(void)test1{

    LKSegmentController *segmentBarVc = [[LKSegmentController alloc] init];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVc1 = segmentBarVc;
    
    self.segmentBarVc1.contentViewFrame = CGRectMake(0, 64, self.view.frame.size.width, 300);
    self.segmentBarVc1.segmentBarFrame = CGRectMake(0, 0, self.view.frame.size.width, 35);
    //滚动的实际范围为 contentView - segmentBar高度跟偏移量

    [self.view addSubview:self.segmentBarVc1.view];
    
    
    TestViewController1 *vc1 = [[TestViewController1 alloc] init];
    TestViewController2 *vc2 = [[TestViewController2 alloc] init];
    TestViewController3 *vc3 = [[TestViewController3 alloc] init];

    [self.segmentBarVc1 setUpWithItems:@[@"item1", @"item2", @"item3item3"] childViewControllers:@[vc1, vc2, vc3]];
    [self.segmentBarVc1.segmentBar segmentBarStyle:^(LKSegmentBarStyle *barStyle) {
        barStyle.backgroundColor = [UIColor yellowColor];
        barStyle.indicatorExtraW = 2;
        barStyle.indicatorHeight = 2;
    }];
    
}

-(void)test2{

    LKSegmentController *segmentBarVc = [[LKSegmentController alloc] init];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVc2 = segmentBarVc;
    
    self.segmentBarVc2.segmentBarFrame = CGRectMake(0, 0, self.view.frame.size.width, 35);
    self.segmentBarVc2.contentViewFrame = CGRectMake(0, CGRectGetMaxY(self.segmentBarVc1.view.frame) + 10, self.view.frame.size.width, 235);
    [self.view addSubview:self.segmentBarVc2.view];
    
    
    TestViewController1 *vc1 = [[TestViewController1 alloc] init];
    TestViewController2 *vc2 = [[TestViewController2 alloc] init];
    TestViewController3 *vc3 = [[TestViewController3 alloc] init];
    TestViewController1 *vc4 = [[TestViewController1 alloc] init];
    TestViewController1 *vc5 = [[TestViewController1 alloc] init];
    TestViewController2 *vc6 = [[TestViewController2 alloc] init];
    TestViewController3 *vc7 = [[TestViewController3 alloc] init];
    TestViewController1 *vc8 = [[TestViewController1 alloc] init];
    
    
    [self.segmentBarVc2 setUpWithItems:@[@"item1", @"item2", @"item3item3",@"文字1",@"文字2", @"文字3文字3", @"123456",@"123"] childViewControllers:@[vc1, vc2, vc3,vc4,vc5, vc6, vc7,vc8]];
    
    
    [self.segmentBarVc2.segmentBar segmentBarStyle:^(LKSegmentBarStyle *barStyle) {
        barStyle.backgroundColor = [UIColor cyanColor];
        barStyle.indicatorExtraW = 2;
        barStyle.indicatorHeight = 2;
        barStyle.itemFont = [UIFont fontWithName:@"Zapfino" size:10];
    }];
}


@end
