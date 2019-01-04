//
//  ZHJQHHotelViewController.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCJiudianliebiaoModel.h"



@interface ZHJQHHotelViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,typededategele>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString  * type;

@property (nonatomic ,strong) LPCCustomTextFild * searchBar;

// 未使用
@property (nonatomic ,strong) NSMutableArray * data_scoureArr;

// 已使用
@property (nonatomic ,strong) NSMutableArray * data_shiyong_scoureArr;

// 已过期
@property (nonatomic ,strong) NSMutableArray * data_guoqi_scoureArr;

@property (nonatomic ,strong) MJChiBaoZiFooter * Footer;

@property (nonatomic ,assign) NSInteger indexPage;

@end
