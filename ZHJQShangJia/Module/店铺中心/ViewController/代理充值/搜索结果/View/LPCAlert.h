//
//  LPCAlert.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPCAlert : UIView

/**
 *  初始化
 *
 *  @param frame 位置大小
 *  @param place 占位符
 *  @param color 颜色
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame
             place:(NSString *)place
             color:(UIColor *)color viu:(UIView *)view ;

@property (nonatomic ,strong) UIColor  * color;

@property (nonatomic ,strong)  UIView  * backView;

/**
 *  展示view
 */
- (void)alertShow;

/**
 *  中间层view
 */
@property (nonatomic,strong) UIView *coverView;

/**
 *  block 回调
 */
@property (nonatomic, copy) void (^Showstring)(NSString * indexString);

@end
