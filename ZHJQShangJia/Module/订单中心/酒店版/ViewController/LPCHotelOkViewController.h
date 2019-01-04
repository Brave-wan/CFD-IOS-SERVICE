//
//  LPCHotelOkViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCHotelOkViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString * idString;


@property (nonatomic ,strong) NSDictionary  * data_dic;

@end
