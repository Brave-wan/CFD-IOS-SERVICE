//
//  LPCOffViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "shangpinjinriModel.h"
#import "LPCgoodsfahuoVC.h"

@interface LPCOffViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * Tableview;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (nonatomic ,strong) NSMutableArray * dataArr;

//  headView 点击标示
@property (nonatomic ,strong) NSString * type;

// 酒店  饭店 商户 的标示
@property (nonatomic ,strong) NSString * Mark;

@end
