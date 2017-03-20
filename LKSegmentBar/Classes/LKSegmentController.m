//
//  LKSegmentController.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/16.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "LKSegmentController.h"
#import "UIView+LKSegmentBar.h"


@interface LKSegmentController ()<LKSegmentBarDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation LKSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    
    if (self.segmentBar.superview == self.view) {
        
        // bar Frame
        CGRect barFrame = CGRectMake(CGRectGetMinX(_contentViewFrame), CGRectGetMinY(_segmentBarFrame),
                                     CGRectGetWidth(_segmentBarFrame), CGRectGetHeight(_segmentBarFrame));
        self.segmentBar.frame = barFrame;
        
        // contentview frame
        CGFloat contentViewY =  CGRectGetMinY(_segmentBarFrame) + CGRectGetHeight(_segmentBarFrame);
        CGFloat contentViewH =  CGRectGetHeight(_contentViewFrame) - contentViewY;
        
        self.contentView.frame = CGRectMake(CGRectGetMinX(_contentViewFrame), contentViewY, CGRectGetWidth(_contentViewFrame), contentViewH);
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * CGRectGetWidth(_contentViewFrame), 0);
        
        return;
    }
    
    CGRect contentFrame = CGRectMake(0, 0,CGRectGetWidth(_contentViewFrame),CGRectGetHeight(_contentViewFrame));
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * CGRectGetWidth(_contentViewFrame), 0);

    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
}


-(void)setUpWithItems:(NSArray<NSString *> *)items childViewControllers:(NSArray<UIViewController *> *)childViewControllers{

    self.segmentBar.items = items;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    for (UIViewController *vc in childViewControllers) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize =  CGSizeMake(items.count * self.view.lk_width, 0);
    self.segmentBar.selectIndex = 0;
}

- (void)showChildVCViewsAtIndex: (NSInteger)index {
    
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.lk_width, 0, self.contentView.lk_width, self.contentView.lk_height);
    [self.contentView addSubview:vc.view];

    [self.contentView setContentOffset:CGPointMake(index * self.contentView.lk_width, 0) animated:YES];
    
}

#pragma mark - set method
-(CGRect)segmentBarFrame {

    if (CGRectEqualToRect(CGRectZero, _segmentBarFrame)) {

        return CGRectMake(0, 0, self.view.lk_width, 35);
    }
    return _segmentBarFrame;
}

-(void)setContentViewFrame:(CGRect)contentViewFrame{
    _contentViewFrame = contentViewFrame;
    self.view.frame = contentViewFrame;
}


#pragma mark - LKSegmentBarDelegate

-(void)segmentBar:(LKSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{

     [self showChildVCViewsAtIndex:toIndex];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = self.contentView.contentOffset.x / self.contentView.lk_width;
    self.segmentBar.selectIndex = index;
}



#pragma mark - lazy
-(LKSegmentBar *)segmentBar{

    if (_segmentBar == nil) {
        LKSegmentBar *segmentBar = [LKSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}

-(UIScrollView *)contentView{

    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

@end
