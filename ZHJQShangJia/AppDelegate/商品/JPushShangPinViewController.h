//
//  JPushShangPinViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/16.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface JPushShangPinViewController : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource,cliclkSecyionDelegate>

@property (nonatomic, copy) NSString *siId;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, copy) NSString *goodsType;

@property (nonatomic ,strong) UITableView * myTableView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr_isPicker;

@property (nonatomic ,assign) int type_root;

@end
