//
//  LPCSetingViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCCustomAlertView.h"


@interface LPCSetingViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据源
 */
@property (nonatomic ,strong) NSMutableArray * dataSourecArr;

@property (nonatomic ,strong) UITableView * TableView;

@end
