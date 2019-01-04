//
//  LPCAlearyUseViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCAlearyUseViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * MyTableView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@end
