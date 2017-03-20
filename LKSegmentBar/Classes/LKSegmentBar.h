//
//  LKSegmentBar.h
//  SegmentDemo
//
//  Created by LouKit on 2017/3/16.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LKSegmentBar,LKSegmentBarStyle;

@protocol LKSegmentBarDelegate <NSObject>

- (void)segmentBar: (LKSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end

@interface LKSegmentBar : UIView

+ (instancetype)segmentBarWithFrame: (CGRect)frame;

- (void)segmentBarStyle: (void(^) (LKSegmentBarStyle *barStyle)) barStyle;

@property (nonatomic,weak) id<LKSegmentBarDelegate> delegate;

@property (nonatomic, strong) NSArray<NSString *> *items;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic,assign,readonly) NSInteger currentIndex;

@end



@interface LKSegmentBarStyle : NSObject

+ (instancetype)defaultBarStyle;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraW;

@end
