//
//  CustomViewController.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/17.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "CustomViewController.h"
#import "TestViewController1.h"
#import "TestViewController2.h"
#import "TestViewController3.h"
#import "LKSegmentController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //有时间在搞，思路差不多就是弄个协议，把item view 抛出来让外界去创建
}



@end
