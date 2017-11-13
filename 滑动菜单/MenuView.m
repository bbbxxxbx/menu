//
//  MenuView.m
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/11/12.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import "MenuView.h"
#import "UIView+BXAddition.h"




const CGFloat Space = 20 ;
const CGFloat Margin = 30 ;
const CGFloat OriginWidth = 120 ;
const CGFloat NormalFont = 12.0 ;
const CGFloat Scale = 0.4 ;

@interface MenuView()

@property (nonatomic, strong) UIScrollView *contentView ;
@property (nonatomic, strong) NSArray *menuItems ;
@property (nonatomic, strong) NSMutableArray *menuViews ;
@property (nonatomic, assign) NSInteger mainIndex ;
@property (nonatomic, assign) CGFloat menuWidth ;

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame] ;
    if(self) {
        _menuItems = [NSArray arrayWithArray:items] ;
        _menuViews = [NSMutableArray array] ;
        
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
        _contentView.showsVerticalScrollIndicator = NO ;
        _contentView.showsHorizontalScrollIndicator = NO ;
        [self addSubview:_contentView] ;
        
        __block CGFloat xLocation = Space ;
        [_menuItems enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            btn.frame = CGRectMake(0, 0, OriginWidth, frame.size.height/2.0) ;
            btn.tag = idx ;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside] ;
            btn.titleLabel.font = [UIFont systemFontOfSize:NormalFont] ;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
            [btn setTitle:item forState:UIControlStateNormal] ;
            [btn sizeToFit] ;
            
            btn.bx_originX = xLocation ;
            btn.bx_centerY = frame.size.height/2.0 ;
            [_menuViews addObject:btn] ;
            [_contentView addSubview:btn] ;
            
            xLocation += btn.bx_sizeW + Margin ;
        }] ;
        _menuWidth = xLocation ;
        [_contentView setContentSize:CGSizeMake(xLocation, frame.size.height)] ;
    }
    return self ;
}

- (void)layoutSubviews {
    [super layoutSubviews] ;
    [_menuViews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx == _mainIndex) {
            btn.transform = CGAffineTransformMakeScale(1+Scale, 1+Scale) ;
        }
        else {
            btn.transform = CGAffineTransformIdentity ;
        }
    }] ;
    [self moveMenuToMiddleWithIndex:_mainIndex] ;
}

- (void)moveMenuToMiddleWithIndex:(NSInteger)index {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width ;
    if(_menuWidth <= screenWidth) {
        return ;
    }
    UIButton *menuView = _menuViews[index] ;
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

- (void)clickBtn:(UIButton *)btn {
    [self clickMenuItemWithIndex:btn.tag] ;
    if(_delegate && [_delegate respondsToSelector:@selector(clickMenuItemAtIndex:)]) {
        [_delegate clickMenuItemAtIndex:btn.tag] ;
    }
}

- (void)clickMenuItemWithIndex:(NSInteger)index {
    _mainIndex = index ;
    [self setNeedsLayout] ;
    [self layoutIfNeeded] ;
}

- (void)changeItemWithIndex:(NSInteger)leftIndex atPercent:(CGFloat)leftPercent index:(NSInteger)rightIndex atPercent:(CGFloat)rightPercent {
    if(rightIndex >= _menuViews.count) {
        return ;
    }
    [_menuViews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx == leftIndex) {
            btn.transform = CGAffineTransformMakeScale(1+Scale*leftPercent, 1+Scale*leftPercent) ;
        }
        else if(idx == rightIndex) {
            btn.transform = CGAffineTransformMakeScale(1+Scale*rightPercent, 1+Scale*rightPercent) ;
        }
        else {
            btn.transform = CGAffineTransformIdentity ;
        }
    }] ;
}

@end
