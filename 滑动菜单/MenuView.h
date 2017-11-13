//
//  MenuView.h
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/11/12.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView1.h"

@interface MenuView : UIView

@property (nonatomic, weak) id<MenuItemDidChooseDelegate> delegate ;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ;
- (void)changeItemWithIndex:(NSInteger)leftIndex atPercent:(CGFloat)leftPercent index:(NSInteger)rightIndex atPercent:(CGFloat)rightPercent ;
- (void)clickMenuItemWithIndex:(NSInteger)index ;

@end
