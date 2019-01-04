//
//  MJChiBaoZiFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiFooter.h"

@implementation MJChiBaoZiFooter
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<2; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=7; i++) {
        
        
    }
    [refreshingImages addObject:[UIImage imageNamed:@"1"]];
    [refreshingImages addObject:[UIImage imageNamed:@"2"]];
    [refreshingImages addObject:[UIImage imageNamed:@"3"]];
    [refreshingImages addObject:[UIImage imageNamed:@"4"]];
    [refreshingImages addObject:[UIImage imageNamed:@"5"]];
    [refreshingImages addObject:[UIImage imageNamed:@"6"]];
    [refreshingImages addObject:[UIImage imageNamed:@"7"]];
    [refreshingImages addObject:[UIImage imageNamed:@"8"]];
    [refreshingImages addObject:[UIImage imageNamed:@"9"]];
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}
@end
