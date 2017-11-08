//
//  UIView+BXAddition.h
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/8/23.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BXAddition)

#pragma mark - Origin 轴坐标
@property (assign, nonatomic) CGFloat bx_originX ;
@property (assign, nonatomic) CGFloat bx_originY ;

#pragma mark - Size 尺寸大小
@property (assign, nonatomic) CGFloat bx_sizeW ;
@property (assign, nonatomic) CGFloat bx_sizeH ;

#pragma mark - Center 中心点坐标
@property (assign, nonatomic) CGFloat bx_centerX ;
@property (assign, nonatomic) CGFloat bx_centerY ;

#pragma mark - Bottom 右边、下面坐标

@property (assign, nonatomic) CGPoint bx_bottom ;
@property (assign, nonatomic) CGFloat bx_bottomX ;
@property (assign, nonatomic) CGFloat bx_bottomY ;

@end
