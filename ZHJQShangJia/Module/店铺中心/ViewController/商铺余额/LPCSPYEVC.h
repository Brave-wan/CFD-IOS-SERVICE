//
//  LPCSPYEVC.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCMerchantBalanceModel.h"
#import "LPCTXViewController.h"

@interface LPCSPYEVC : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource,tixianelegate>

@property (nonatomic ,strong) UITableView    * TableView;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (nonatomic ,strong) UILabel        * numLabel;


@end
