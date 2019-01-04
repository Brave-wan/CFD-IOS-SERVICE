//
//  LPCCustomAlertView.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPCCustomAlertView : UIView

/**
 *  初始化
 *
 *  @param frame   位置大小
 *  @param message message
 *  @param title   标题
 *  @param color   颜色
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame
           message:(NSString *)message
             title:(NSString *)title
             color:(UIColor *)color ;

/**
 *  初始化
 *
 *  @param frame 位置大小
 *  @param place 占位符
 *  @param title 内容
 *  @param color 颜色
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame
           place:(NSString *)place
             title:(NSString *)title
             color:(UIColor *)color
            string:(NSString *)string
              view:(UIView *)view;

@property (nonatomic ,strong) UIView * selfview;

@property (nonatomic ,strong) UIColor  * color;

/**
 *  展示view
 */
- (void)alertShow;

- (void)alertViewShow;

/**
 *  中间层view
 */
@property (nonatomic,strong) UIView *coverView;

/**
 *  block 回调
 */
@property (nonatomic, copy) void (^Showstring)(NSString * indexString);

/**
 *  block 回调
 */
@property (nonatomic, copy) void (^ShowNum)(NSString * indexString,NSString * numstring);

@property (nonatomic ,strong)  UITextField  * messtextfild;

@property (nonatomic ,strong)  NSString * string;

-(void)removeView;

@end
