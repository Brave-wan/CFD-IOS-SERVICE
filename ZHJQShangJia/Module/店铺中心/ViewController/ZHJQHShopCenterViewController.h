//
//  ZHJQHShopCenterViewController.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCShopCeneterModel.h"

@interface ZHJQHShopCenterViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据载体
 */
@property (nonatomic ,strong) UITableView    * Tableview;

/**
 *  数据源
 */
@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

/**
 *  店铺的名称
 */
@property (nonatomic ,strong) UILabel        * nameLabel;

@end
