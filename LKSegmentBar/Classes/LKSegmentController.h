//
//  LKSegmentController.h
//  SegmentDemo
//
//  Created by LouKit on 2017/3/16.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKSegmentBar.h"

@interface LKSegmentController : UIViewController

/**
 * 导航栏
 */
@property (nonatomic,weak) LKSegmentBar *segmentBar;

/**
 * 导航栏 bar frame
 */
@property (nonatomic,assign) CGRect segmentBarFrame;

/**
 * 内容view 的frame 包含着着导航栏bar 与滚动视图view
 */
@property (nonatomic,assign) CGRect contentViewFrame;


/**
 * items 导航栏标题数组
 * childViewControllers 自控制器数组
 */
- (void)setUpWithItems: (NSArray <NSString *>*)items childViewControllers: (NSArray <UIViewController *>*)childViewControllers;

@end
