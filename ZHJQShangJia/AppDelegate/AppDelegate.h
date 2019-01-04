//
//  AppDelegate.h
//  ZHJQShangJia
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "JPushFandianViewController.h"
#import "JPushFandianViewController.h"

static NSString *appKey = @"aab1889c56949e2bbd072fc0";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  网络指示器
 */
@property (strong, nonatomic) MBProgressHUD * hud;

//切换跟试图
-(void)chageViewController;

//切换跟试图
-(void)changeRootViewController:(NSString *)type;

/**
 *  删除userId  token  和 shopId
 */
-(void)removeUser;

/**
 *  展示hud
 */
- (void)showHud;
/**
 *  隐藏hud
 */
- (void)hideHud;

/**
 *   设置极光的别名
 *
 *  @param tags 别名字段
 */
-(void)jPushtags:(NSString *)tags;

/**
 *  加载到window
 *
 *  @param scrollview 参数
 */
-(void)addView:(UIScrollView *)scrollview;

-(void)addPage:(UIPageControl *)PageControl;

-(void)remoView:(UIScrollView *)scrollview;

-(void)remoPage:(UIPageControl *)PageControl;

@end

