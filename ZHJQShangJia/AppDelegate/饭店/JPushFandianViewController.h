//
//  JPushFandianViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/12.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "JPushFanDianTaoCanModel.h"

@interface JPushFandianViewController : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *siId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, copy) NSString *goodsType;

@property (nonatomic ,strong) UITableView * myTableView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr_danpin;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr_taocan;

@property (nonatomic ,assign) int type_root;

@end
