//
//  LKSegmentBar.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/16.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "LKSegmentBar.h"
#import "UIView+LKSegmentBar.h"
#define kMinMargin 30

@interface LKSegmentBar ()

@property (nonatomic,strong) UIButton *lastSelectBtn;

@property (nonatomic,weak) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray <UIButton *> *itemBtns;

@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic,strong) LKSegmentBarStyle *barStyle;

@end

@implementation LKSegmentBar


+ (instancetype)segmentBarWithFrame:(CGRect)frame{

    LKSegmentBar *segment = [[LKSegmentBar alloc]initWithFrame:frame];

    return segment;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.barStyle.backgroundColor;
    }
    return self;
}

- (void)segmentBarStyle:(void (^)(LKSegmentBarStyle *))barStyle{

    if (barStyle) {
        barStyle(self.barStyle);
    }
    
    //set style
    self.backgroundColor = self.barStyle.backgroundColor;
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.barStyle.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.barStyle.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.barStyle.itemFont;
    }
    self.indicatorView.backgroundColor = self.barStyle.indicatorColor;
    
    //update view
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - set method
-(void)setSelectIndex:(NSInteger)selectIndex{

    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

//当前选中的按钮
-(NSInteger)currentIndex{

    return self.lastSelectBtn.tag;
}

//创建item
-(void)setItems:(NSArray<NSString *> *)items{

    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.barStyle.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.barStyle.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.barStyle.itemFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - private method
//选中按钮事件
- (void)btnClick: (UIButton *)currentButton {
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:currentButton.tag fromIndex:self.lastSelectBtn.tag];
    }
    
    _selectIndex = currentButton.tag;
    
    self.lastSelectBtn.selected = NO;
    currentButton.selected = YES;
    self.lastSelectBtn = currentButton;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.lk_width = currentButton.lk_width + self.barStyle.indicatorExtraW * 2;
        self.indicatorView.lk_centerX = currentButton.lk_centerX;
    }];
    
    //button 滑动到中间
    CGFloat scrollX = currentButton.lk_centerX - self.contentView.lk_width * 0.5;
    
    if (scrollX < 0 || self.contentView.lk_width == 0){
        scrollX = 0;
    }
    
    if (scrollX > self.contentView.contentSize.width - self.contentView.lk_width) {
        scrollX = self.contentView.contentSize.width - self.contentView.lk_width;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

// 调整布局
- (void)adjustLayout{

    self.contentView.frame = self.bounds;
    // button
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.lk_width;
    }
    
    //没有超出宽度情况
    CGFloat caculateMargin = (self.lk_width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    

    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        
        [btn sizeToFit];
        btn.lk_y = 0;
        btn.lk_x = lastX;
        lastX += btn.lk_width + caculateMargin;
    }
    
    // contentView
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    if (self.itemBtns.count == 0) {
        return;
    }
    
    // indicatorView
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.lk_width = btn.lk_width + self.barStyle.indicatorExtraW * 2;
    self.indicatorView.lk_centerX = btn.lk_centerX;
    self.indicatorView.lk_height = self.barStyle.indicatorHeight;
    self.indicatorView.lk_y = self.lk_height - self.indicatorView.lk_height;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self adjustLayout];

}


#pragma mark - lazy

- (NSMutableArray<UIButton *> *)itemBtns{

    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

-(UIView *)indicatorView{

    if (_indicatorView == nil) {
        CGFloat indicatorH = self.barStyle.indicatorHeight;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.lk_height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = self.barStyle.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

-(UIScrollView *)contentView{

    if (_contentView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}

-(LKSegmentBarStyle *)barStyle{

    if (_barStyle == nil) {
        _barStyle = [LKSegmentBarStyle defaultBarStyle];
    }
    return _barStyle;
}

@end


@implementation LKSegmentBarStyle

+ (instancetype)defaultBarStyle{
    
    LKSegmentBarStyle *config = [[LKSegmentBarStyle alloc] init];
    config.backgroundColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 10;
    
    return config;
}

@end
