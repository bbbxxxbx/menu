//
//  UIView+BXAddition.m
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/8/23.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import "UIView+BXAddition.h"

@implementation UIView (BXAddition)

- (void)setBx_originX:(CGFloat)bx_originX {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(bx_originX, frame.origin.y, frame.size.width, frame.size.height) ;
}

- (CGFloat)bx_originX {
    return self.frame.origin.x ;
}

- (void)setBx_originY:(CGFloat)bx_originY {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(frame.origin.x, bx_originY, frame.size.width, frame.size.height) ;
}

- (CGFloat)bx_originY {
    return self.frame.origin.y ;
}

- (void)setBx_sizeW:(CGFloat)bp_sizeW {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, bp_sizeW, frame.size.height) ;
}

- (CGFloat)bx_sizeW {
    return self.frame.size.width ;
}

- (void)setBx_sizeH:(CGFloat)bx_sizeH {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, bx_sizeH) ;
}

- (CGFloat)bx_sizeH {
    return self.frame.size.height ;
}

- (void)setBx_centerX:(CGFloat)bx_centerX {
    CGPoint center = self.center ;
    center.x = bx_centerX ;
    self.center = center ;
}

- (CGFloat)bx_centerX {
    return self.center.x ;
}

- (void)setBx_centerY:(CGFloat)bx_centerY {
    CGPoint center = self.center ;
    center.y = bx_centerY ;
    self.center = center ;
}

- (CGFloat)bx_centerY {
    return self.center.y ;
}

- (void)setBx_bottom:(CGPoint)bx_bottom {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(bx_bottom.x - frame.size.width, bx_bottom.y - frame.size.height, frame.size.width, frame.size.height) ;
}

- (CGPoint)bx_bottom {
    CGFloat x = CGRectGetMaxX(self.frame) ;
    CGFloat y = CGRectGetMaxY(self.frame) ;
    return CGPointMake(x, y) ;
}

- (void)setBx_bottomX:(CGFloat)bx_bottomX {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(bx_bottomX - frame.size.width, frame.origin.y, frame.size.width, frame.size.height) ;
}

- (CGFloat)bx_bottomX {
    return CGRectGetMaxX(self.frame) ;
}

- (void)setBx_bottomY:(CGFloat)bx_bottomY {
    CGRect frame = self.frame ;
    self.frame = CGRectMake(frame.origin.x, bx_bottomY - frame.origin.y, frame.size.width, frame.size.height) ;
}

- (CGFloat)bx_bottomY {
    return CGRectGetMaxY(self.frame) ;
}
@end
