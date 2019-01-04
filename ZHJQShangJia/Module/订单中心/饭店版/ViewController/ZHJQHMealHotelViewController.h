//
//  ZHJQHMealHotelViewController.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface ZHJQHMealHotelViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString  * type;

@property (nonatomic ,strong) LPCCustomTextFild * searchBar;

@property (nonatomic ,strong) NSString * oneOrtwo;

@property (nonatomic ,strong) NSMutableArray * danpinArr_weishiyong;

@property (nonatomic ,strong) NSMutableArray * danpinArr_yishiyong;

@property (nonatomic ,strong) NSMutableArray * danpinArr_yiguoqi;

@property (nonatomic ,strong) NSMutableArray * taocanArr_weishiyong;

@property (nonatomic ,strong) NSMutableArray * taocanArr_yishiyong;

@property (nonatomic ,strong) NSMutableArray * taocanArr_yiguoqi;

@property (nonatomic ,strong) MJChiBaoZiFooter * Footer;

@property (nonatomic ,assign) NSInteger  indextPage;

@end
