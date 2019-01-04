//
//  LPCNewsViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCNEWSmodels.h"


@interface LPCNewsViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * Tableview;

@property (nonatomic ,strong) NSMutableArray  * dataSourceArr;

@property (nonatomic ,assign) NSInteger   indexPath;

@end
