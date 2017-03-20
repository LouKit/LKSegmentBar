//
//  NavBarViewController.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/17.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "NavBarViewController.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "TestViewController3.h"
#import "LKSegmentController.h"

@interface NavBarViewController ()

@property (nonatomic,strong) LKSegmentController *segmentBarVC;

@end

@implementation NavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;
    

    LKSegmentController *segmentBarVc = [[LKSegmentController alloc] init];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVC = segmentBarVc;
    
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, 250, 35);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    self.segmentBarVC.contentViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.segmentBarVC.view];
    
    
    TestViewController1 *vc1 = [[TestViewController1 alloc] init];
    TestViewController2 *vc2 = [[TestViewController2 alloc] init];
    TestViewController3 *vc3 = [[TestViewController3 alloc] init];
    TestViewController1 *vc4 = [[TestViewController1 alloc] init];
    TestViewController1 *vc5 = [[TestViewController1 alloc] init];
    TestViewController2 *vc6 = [[TestViewController2 alloc] init];
    
    
    [self.segmentBarVC setUpWithItems:@[@"第一阶段", @"中间", @"第三阶段",@"第四阶段",@"来个长点文字", @"短"] childViewControllers:@[vc1, vc2, vc3,vc4,vc5, vc6]];
    
    
    [self.segmentBarVC.segmentBar segmentBarStyle:^(LKSegmentBarStyle *barStyle) {
        barStyle.backgroundColor = [UIColor clearColor];
        barStyle.indicatorExtraW = 2;
        barStyle.indicatorHeight = 2;

    }];
    
    
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    tag.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tag];
}


- (void)back{

    [self.navigationController popViewControllerAnimated:YES];
}



@end
