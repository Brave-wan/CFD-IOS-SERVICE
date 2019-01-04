//
//  LPCJDelegaietViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/3.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCJDelegaietViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString  * type;

@end
