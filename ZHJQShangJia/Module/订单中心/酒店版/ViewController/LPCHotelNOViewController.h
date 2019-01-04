//
//  LPCHotelNOViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"


@protocol typededategele <NSObject>

- (void)chooserefre:(NSString *)type;

@end

@interface LPCHotelNOViewController : ZHJQHRootViewController
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) id  object;

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString * idString;

@property (nonatomic ,strong) NSDictionary  * data_dic;


@end
