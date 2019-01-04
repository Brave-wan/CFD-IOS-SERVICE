//
//  ZHJQHGoodsViewController.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface ZHJQHGoodsViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate,ClickReusetDelegate>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString  * type;

@property (nonatomic ,strong) LPCCustomTextFild * searchBar;

// 待发货
@property (nonatomic ,strong) NSMutableArray * Hang_dataScureArr;

// 已完成
@property (nonatomic ,strong) NSMutableArray * been_dataSoureArr;

// 已发货
@property (nonatomic ,strong) NSMutableArray * Already_dataSourceArr;

// 角标集合
@property (nonatomic ,strong) NSMutableArray * bageNum_Arr;

@property (nonatomic ,strong) MJChiBaoZiFooter  * Footer;

@property (nonatomic ,assign) NSUInteger  page;

@end
