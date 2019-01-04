//
//  LPCgoodsfahuoVC.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/25.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@protocol cliclkSecyionDelegate <NSObject>

- (void)chooseclick:(NSInteger )type_section;

@end

@interface LPCgoodsfahuoVC : ZHJQHRootViewController

@property (nonatomic, strong) id delegate;

/**
 *  订单号
 */
@property(nonatomic ,strong) NSString * idstring;

/**
 *  订单状态
 */
@property (nonatomic ,strong) NSString * ord_type;

/**
 *  点击的第几个section
 */
@property(nonatomic ,assign) NSInteger  section;

@end
