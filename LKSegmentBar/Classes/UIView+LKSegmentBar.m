//
//  UIView+LKSegmentBar.m
//  SegmentDemo
//
//  Created by LouKit on 2017/3/16.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "UIView+LKSegmentBar.h"

@implementation UIView (LKSegmentBar)

-(CGFloat)lk_width{
    
    return self.frame.size.width;
}

-(void)setLk_width:(CGFloat)lk_width{
    
    CGRect frame = self.frame;
    frame.size.width = lk_width;
    self.frame = frame;
}


-(CGFloat)lk_height{
    
    return self.frame.size.height;
}

-(void)setLk_height:(CGFloat)lk_height{
    
    CGRect frame = self.frame;
    frame.size.height = lk_height;
    self.frame = frame;
}

-(CGFloat)lk_x{
    
    return self.frame.origin.x;
}

-(void)setLk_x:(CGFloat)lk_x{
    
    CGRect frame = self.frame;
    frame.origin.x = lk_x;
    self.frame = frame;
}

-(CGFloat)lk_y{
    
    return self.frame.origin.y;
}

-(void)setLk_y:(CGFloat)lk_y{
    CGRect frame = self.frame;
    frame.origin.y = lk_y;
    self.frame = frame;
}

-(CGFloat)lk_centerX{
    
    return self.center.x;
}

-(void)setLk_centerX:(CGFloat)lk_centerX{
    CGPoint center = self.center;
    center.x = lk_centerX;
    self.center = center;
}


-(CGFloat)lk_centerY{
    
    return self.center.y;
}

-(void)setLk_centerY:(CGFloat)lk_centerY{
    
    CGPoint center = self.center;
    center.y = lk_centerY;
    self.center = center;
}

-(CGSize)lk_size{
    
    return self.frame.size;
}

-(void)setLk_size:(CGSize)lk_size{
    
    CGRect frame = self.frame;
    frame.size = lk_size;
    self.frame = frame;
}

-(CGFloat)lk_right{
    
    return CGRectGetMaxX(self.frame);
}

-(void)setLk_right:(CGFloat)lk_right{
    self.lk_x = lk_right - self.lk_width;
    
}

-(CGFloat)lk_bottom{
    
    return CGRectGetMaxY(self.frame);
}

-(void)setLk_bottom:(CGFloat)lk_bottom{
    
    self.lk_y = lk_bottom - self.lk_height;
}

@end
