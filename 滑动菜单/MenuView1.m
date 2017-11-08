//
//  MenuView1.m
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/9/7.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import "MenuView1.h"
#import "UIView+BXAddition.h"

NSString * const MenuMainIndexKey       = @"MenuMainIndexKey" ;
NSString * const MenuItemSpaceKey       = @"MenuItemSpaceKey" ;
NSString * const MenuNormalFontKey      = @"MenuNormalFontKey" ;
NSString * const MenuSelectedFontKey    = @"MenuSelectedFontKey" ;
NSString * const MenuNormalWidthKey     = @"MenuNormalWidthKey" ;
NSString * const MenuSelectedWidthKey   = @"MenuSelectedWidthKey" ;
NSString * const MenuMarginKey          = @"MenuMarginKey" ;

@interface MenuView1()
{
    CGFloat _menuWidth      ;
    CGFloat _itemSpace      ;
    CGFloat _normalFont     ;
    CGFloat _selectedFont   ;
    CGFloat _normalWidth    ;
    CGFloat _selectedWidth  ;
    CGFloat _margin         ;
    NSInteger _mainIndex    ;
}

@property (nonatomic, strong) UIScrollView *contentView ;
@property (nonatomic, strong) NSMutableArray *menuViews ;
@property (nonatomic, strong) NSArray *menuItems ;

@end

@implementation MenuView1

#pragma mark ----------------------------生命周期----------------------------------------
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items settings:(NSDictionary *)settings {
    self = [super initWithFrame:frame] ;
    if(self) {
        _menuItems = [NSArray arrayWithArray:items] ;
        _menuViews = [NSMutableArray array] ;
        _mainIndex = [[settings objectForKey:MenuMainIndexKey] integerValue] ;
        _margin = [[settings objectForKey:MenuMarginKey] floatValue] ;
        _itemSpace = [[settings objectForKey:MenuItemSpaceKey] floatValue] ;
        _normalFont = [[settings objectForKey:MenuNormalFontKey] floatValue] ;
        _selectedFont = [[settings objectForKey:MenuSelectedFontKey] floatValue] ;
        _normalWidth = [[settings objectForKey:MenuNormalWidthKey] floatValue] ;
        _selectedWidth = [[settings objectForKey:MenuSelectedWidthKey] floatValue] ;
        _normalWidth = [[settings objectForKey:MenuNormalWidthKey] floatValue] ;
        
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
        _contentView.showsVerticalScrollIndicator = NO ;
        _contentView.showsHorizontalScrollIndicator = NO ;
        _menuWidth = _margin*2.0+(_menuItems.count-1)*_normalWidth+_selectedWidth+(_menuItems.count-1)*_itemSpace ;
        [_contentView setContentSize:CGSizeMake(_menuWidth, frame.size.height)] ;
        [self addSubview:_contentView] ;
        
        [_menuItems enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *menuView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)] ;
            menuView.tag = idx ;
            menuView.text = item ;
            menuView.textColor = [UIColor blackColor] ;
            menuView.textAlignment = NSTextAlignmentCenter ;
            menuView.userInteractionEnabled = YES ;
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenuItem:)] ;
            singleTap.numberOfTapsRequired = 1 ;
            [menuView addGestureRecognizer:singleTap] ;
            
            [_contentView addSubview:menuView] ;
            [_menuViews addObject:menuView] ;
        }] ;
    }
    return self ;
}

- (void)layoutSubviews {
    [super layoutSubviews] ;
    __block CGFloat locationX = _margin ;
    [_menuViews enumerateObjectsUsingBlock:^(UILabel *menuView, NSUInteger idx, BOOL * _Nonnull stop) {
        menuView.bx_originX = locationX ;
        if(idx == _mainIndex) {
            menuView.bx_sizeW = _selectedWidth ;
            menuView.font = [UIFont boldSystemFontOfSize:_selectedFont] ;
        }
        else {
            menuView.bx_sizeW = _normalWidth ;
            menuView.font = [UIFont systemFontOfSize:_normalFont] ;
        }
        locationX += menuView.bx_sizeW + _itemSpace ;
    }] ;
    [self moveMenuToMiddleWithIndex:_mainIndex] ;
}

#pragma mark ----------------------------私有方法----------------------------------------
- (void)moveMenuToMiddleWithIndex:(NSInteger)index {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width ;
    if(_menuWidth <= screenWidth) {
        return ;
    }
    UILabel *menuView = _menuViews[index] ;
    if (menuView.bx_centerX > screenWidth / 2) {
        if((_menuWidth - menuView.bx_centerX) > screenWidth / 2) {
            [_contentView setContentOffset:CGPointMake(menuView.bx_centerX - screenWidth/2, _contentView.contentOffset.y) animated:YES] ;
        }
        else {
            [_contentView setContentOffset:CGPointMake(_menuWidth - screenWidth, _contentView.contentOffset.y) animated:YES] ;
        }
    }
    else {
        [_contentView setContentOffset:CGPointMake(0, _contentView.contentOffset.y) animated:YES] ;
    }
}

- (void)clickMenuItem:(UITapGestureRecognizer *)tapGes {
    UILabel *menuView = (UILabel *)tapGes.view ;
    [self clickMenuItemWithIndex:menuView.tag] ;
    if(_delegate && [_delegate respondsToSelector:@selector(clickMenuItemAtIndex:)]) {
        [_delegate clickMenuItemAtIndex:menuView.tag] ;
    }
}
#pragma mark ----------------------------公共方法----------------------------------------
- (void)clickMenuItemWithIndex:(NSInteger)index {
    _mainIndex = index ;
    [self setNeedsLayout] ;
    [self layoutIfNeeded] ;
}

- (void)changeItemWithIndex:(NSInteger)leftIndex atPercent:(CGFloat)leftPercent index:(NSInteger)rightIndex atPercent:(CGFloat)rightPercent {
    if(rightIndex >= _menuViews.count) {
        return ;
    }
    __block CGFloat locationX = _margin ;
    [_menuViews enumerateObjectsUsingBlock:^(UILabel *menuView, NSUInteger index, BOOL * _Nonnull stop) {
        menuView.bx_originX = locationX ;
        if (index == leftIndex) {
            menuView.bx_sizeW = _normalWidth + (_selectedWidth - _normalWidth) * leftPercent ;
            CGFloat font = _normalFont + (_selectedFont - _normalFont) * leftPercent ;
            menuView.font = [UIFont boldSystemFontOfSize:font] ;
        }
        else if (index == rightIndex) {
            menuView.bx_sizeW = _normalWidth + (_selectedWidth - _normalWidth) * rightPercent ;
            CGFloat font = _normalFont + (_selectedFont - _normalFont) * rightPercent ;
            menuView.font = [UIFont boldSystemFontOfSize:font] ;
        }
        else {
            menuView.bx_sizeW = _normalWidth ;
            menuView.font = [UIFont systemFontOfSize:_normalFont] ;
        }
        locationX += menuView.bx_sizeW + _itemSpace ;
    }];
}

@end
