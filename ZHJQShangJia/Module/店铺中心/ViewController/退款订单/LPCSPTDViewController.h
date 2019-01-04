//
//  LPCSPTDViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "UIView+XMGExtension.h"
#import "XMGTitleButton.h"
#import "shangpintuikuaidingdanmodel.h"

@interface LPCSPTDViewController : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) LPCCustomTextFild * searchBar;

@property (nonatomic ,strong) UITableView       * MyTabelView;

/**
 *  酒店数据源
 */
@property (nonatomic ,strong) NSMutableArray * dataSoureArr;

/**
 *  饭店的数据
 */
@property (nonatomic ,strong) NSMutableArray * fandianDataSourceArr;

/**
 *  商品的数据
 */
@property (nonatomic ,strong) NSMutableArray * shangpinDataSourceArr;

@property (nonatomic ,strong) NSString * jiudiantype;

@property (nonatomic ,strong) NSString * fandiantype;

@property (nonatomic ,strong) NSString * shangpintype;

@property (nonatomic ,strong) LPCSegemView  * segment;

@property (nonatomic , strong)  NSMutableArray  * bageNum_Arr;

@end
