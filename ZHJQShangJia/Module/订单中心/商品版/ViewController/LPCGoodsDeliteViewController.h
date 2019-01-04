//
//  LPCGoodsDeliteViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCDINGDANXIANGQImodel.h"

@protocol ClickReusetDelegate <NSObject>

- (void)chooserefre:(NSString *)type;

@end

@interface LPCGoodsDeliteViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) id delegate;

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong ) NSMutableArray * data_weifahuoArr;

@property (nonatomic ,strong ) NSMutableArray * data_weifahuoArr_two;

@property (nonatomic ,strong ) NSMutableArray * data_yifahuoArr;

@property (nonatomic ,strong ) NSMutableArray * data_yifahuoArr_two;

@property (nonatomic ,strong ) NSMutableArray * data_wanfahuoArr;

@property (nonatomic ,strong ) NSMutableArray * data_wanfahuoArr_two;

@property (nonatomic ,strong)   LPCqingdanxiangExpress * express;

@property (nonatomic ,strong)  LPCqingdanxiangrefundCause  * cause;

/**
 *  订单号
 */
@property (nonatomic ,strong)  NSString * string_id;

@property (nonatomic ,strong)  id  object;

/**
 *  完成的状态
 */
@property (nonatomic ,strong) NSString * string;

/**
 *  订单号
 */
@property(nonatomic ,strong) NSString * idstring;


/**
 *  点击的第几个section
 */
@property(nonatomic ,assign) NSInteger  section;

@property (nonatomic ,strong) NSString  * is_pickup_string;// 是否自提

@end
