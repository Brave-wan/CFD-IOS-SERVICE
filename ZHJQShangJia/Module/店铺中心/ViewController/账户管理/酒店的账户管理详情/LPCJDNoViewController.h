//
//  LPCJDNoViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@protocol jiudiandeshenhe <NSObject>

- (void)jiudiandeshenhetuikuai:(NSString *)type;

@end

@interface LPCJDNoViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * TableView;

@property (nonatomic ,strong) NSString * idString;

@property (nonatomic ,strong) id  object;

@property (nonatomic ,strong) NSDictionary  * data_dic;

@property (nonatomic ,strong) NSString * okNostring;

@end
