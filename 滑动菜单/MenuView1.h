//
//  MenuView1.h
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/9/7.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MenuMainIndexKey ;
extern NSString * const MenuItemSpaceKey ;
extern NSString * const MenuNormalFontKey ;
extern NSString * const MenuSelectedFontKey ;
extern NSString * const MenuNormalWidthKey ;
extern NSString * const MenuSelectedWidthKey ;
extern NSString * const MenuMarginKey ;

@protocol MenuItemDidChooseDelegate <NSObject>

- (void)clickMenuItemAtIndex:(NSInteger)index;

@end

@interface MenuView1 : UIView

@property (nonatomic, weak) id<MenuItemDidChooseDelegate> delegate ;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items settings:(NSDictionary *)settings ;
- (void)changeItemWithIndex:(NSInteger)leftIndex atPercent:(CGFloat)leftPercent index:(NSInteger)rightIndex atPercent:(CGFloat)rightPercent ;
- (void)clickMenuItemWithIndex:(NSInteger)index ;
@end
