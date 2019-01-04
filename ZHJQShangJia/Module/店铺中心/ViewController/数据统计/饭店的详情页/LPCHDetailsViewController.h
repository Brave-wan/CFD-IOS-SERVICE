//
//  LPCHDetailsViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/3.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCHDetailsViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据载体
 */
@property (nonatomic ,strong) UITableView * TableView;

/**
 *  上一页面的数据
 */
@property (nonatomic ,strong) NSDictionary * dict;

/**
 *  判断订单的使用情况
 */
@property (nonatomic ,strong) NSString * type;

@property (nonatomic ,strong) NSString  *  oneOrtwo;

@end
