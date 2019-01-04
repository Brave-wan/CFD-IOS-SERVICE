//
//  LPCNumViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCNumViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView  * TabelView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (nonatomic ,strong) NSString  * type;

@end
