//
//  LPCInformationViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCInformationViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据载体
 */
@property (nonatomic ,strong) UITableView * TableView;

/**
 *  身份的验证
 */
@property (nonatomic ,assign) NSInteger   section_index;

/**
 *  酒店设施的图片集合
 */
@property(nonatomic ,strong) NSMutableArray  * jd_dataSurceImageArr;

/**
 *  酒店设施的文字集合
 */
@property (nonatomic ,strong) NSMutableArray  * jd_dataSurcetitleArr;


/**
 *  饭店设施的图片集合
 */
@property(nonatomic ,strong) NSMutableArray  * fd_dataSurceImageArr;

/**
 *  饭店设施的文字集合
 */
@property (nonatomic ,strong) NSMutableArray  * fd_dataSurcetitleArr;


@end
