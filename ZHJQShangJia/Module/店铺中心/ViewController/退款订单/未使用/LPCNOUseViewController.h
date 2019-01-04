//
//  LPCNOUseViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCnouserxiangqiyeVcViewController.h"

@interface LPCNOUseViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * MyTableView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (nonatomic ,strong) NSString * type;

-(void)rege;

@end
