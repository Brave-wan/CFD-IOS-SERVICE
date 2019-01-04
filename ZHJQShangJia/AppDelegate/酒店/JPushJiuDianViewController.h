//
//  JPushJiuDianViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/16.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "JPushJiuDianModel.h"

@interface JPushJiuDianViewController : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSString *siId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, copy) NSString *goodsType;

@property (nonatomic ,assign) int type_root;

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,assign) CGRect hegith;

@end
