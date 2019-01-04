//
//  LPCSearcherjiudianViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/10.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

#import "LPCkeyBoardView.h"

@interface LPCSearcherjiudianViewController : ZHJQHRootViewController<UITableViewDelegate,UITableViewDataSource,sendbuttonclick,jiudiandeshenhe,typededategele>

@property (nonatomic ,strong) LPCCustomTextFild * searchBar;

@property (nonatomic ,strong) UITableView       * MytableView;

@property (nonatomic ,strong) NSMutableArray    * dataSouceArr;

@property (nonatomic ,strong) NSString * type_string;

@property (nonatomic ,strong) NSString * string_search;

@property (nonatomic ,assign) BOOL  isNumber;

@property (nonatomic ,strong) LPCkeyBoardView  * keyBoardView;

@end
