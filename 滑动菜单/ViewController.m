//
//  ViewController.m
//  滑动菜单
//
//  Created by yfzx-sh-baoxu on 2017/8/22.
//  Copyright © 2017年 鲍旭. All rights reserved.
//

#import "ViewController.h"
#import "UIView+BXAddition.h"
#import "MenuView.h"

#define _StatusBarHeight_   ([UIApplication sharedApplication].statusBarFrame.size.height)
#define _ScreenWidth_       ([UIScreen mainScreen].bounds.size.width)
#define _ScreenHeight_      ([UIScreen mainScreen].bounds.size.height)
#define _TabBarHeight_      (49.0f)

@interface ViewController ()<MenuItemDidChooseDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MenuView *menuView ;
@property (nonatomic, strong) UIScrollView *contentScrollView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawUI] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawUI {
    NSArray *items = @[@"温柔", @"突然好想你", @"星空", @"三个傻瓜", @"你不是真正的快乐", @"我不愿让你一个人", @"拥抱"] ;
    NSArray *backgroundColors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor blackColor], [UIColor orangeColor], [UIColor greenColor], [UIColor purpleColor]] ;
    
    _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, _StatusBarHeight_, _ScreenWidth_, 40) items:items] ;
    _menuView.delegate = self ;
    [self.view addSubview:_menuView] ;
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _menuView.bx_bottomY, _ScreenWidth_, _ScreenHeight_ - _menuView.bx_bottomY - _TabBarHeight_)] ;
    [_contentScrollView setContentSize:CGSizeMake(items.count*_ScreenWidth_, _contentScrollView.bx_sizeH)] ;
    _contentScrollView.delegate = self ;
    _contentScrollView.pagingEnabled = YES ;
    _contentScrollView.bounces = NO ;
    _contentScrollView.showsVerticalScrollIndicator = NO ;
    _contentScrollView.showsHorizontalScrollIndicator = NO ;
    _contentScrollView.backgroundColor = [UIColor clearColor] ;
    [self.view addSubview:_contentScrollView] ;
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[UIViewController alloc] init] ;
        vc.view.backgroundColor = backgroundColors[idx] ;
        [self addChildViewController:vc] ;
        [_contentScrollView addSubview:vc.view] ;
        vc.view.bx_originX = idx * _ScreenWidth_ ;
    }] ;
}

- (void)clickMenuItemAtIndex:(NSInteger)index {
    CGRect newRect = CGRectMake(_ScreenWidth_ * index, 0, _contentScrollView.bx_sizeW, _contentScrollView.bx_sizeH) ;
    [_contentScrollView scrollRectToVisible:newRect animated:NO] ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView != _contentScrollView) {
        return ;
    }
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width ;
    [_menuView clickMenuItemWithIndex:currentPage] ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView != _contentScrollView) {
        return ;
    }
    [self changeItem:scrollView] ;
}

- (void)changeItem:(UIScrollView *)scrollView {
    NSInteger leftIndex = scrollView.contentOffset.x/scrollView.bx_sizeW ;
    CGFloat percentOfLeftIndex = 1.0 - (scrollView.contentOffset.x - leftIndex * scrollView.bx_sizeW)/_ScreenWidth_ ;
    if(percentOfLeftIndex == 1) {
        return; //防止点击Menu跳转后由scroll滑动引起的二次跳转
    }
    NSInteger rightIndex = leftIndex + 1 ;
    CGFloat percentOfRightIndex = 1.0 - percentOfLeftIndex ;
    [_menuView changeItemWithIndex:leftIndex atPercent:percentOfLeftIndex index:rightIndex atPercent:percentOfRightIndex] ;
}


@end
