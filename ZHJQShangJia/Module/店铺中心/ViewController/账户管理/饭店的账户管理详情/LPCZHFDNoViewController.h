//
//  LPCZHFDNoViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCZHFDNoViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据载体
 */
@property (nonatomic ,strong) UITableView * TableView;

/**
 *  单品和套餐 标示
 */
@property (nonatomic ,strong) NSString * oneTwo;

/**
 *  订单号
 */
@property (nonatomic, strong) NSString * idString;

/**
 *  数据源
 */
@property (nonatomic ,strong) NSMutableArray * data_Arr;



@property (nonatomic ,strong) NSString * imageUrl;

/**
 *  数据源
 */
@property (nonatomic ,strong) NSDictionary * data_DIc;
/**
 *  数据源
 */
@property (nonatomic ,strong) NSMutableArray * data_Arr_shop;

@property (nonatomic ,strong) NSString * string_paye;


@end
