//
//  LPCPersonauthenticationViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@interface LPCPersonauthenticationViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView * TabelView;

@property (nonatomic ,strong) NSString * nameString;

@property (nonatomic ,strong) NSString * SexString;

@property (nonatomic ,strong) NSString * NoString;

@property (nonatomic ,strong) NSString  * image_one_string;

@property (nonatomic ,strong) NSString  * image_two_string;

@property (nonatomic ,strong) NSString  * imeage_three_string;


@property (nonatomic ,strong) UIImage  * image_one;

@property (nonatomic ,strong) UIImage  * image_two;

@property (nonatomic ,strong) UIImage  * imeage_three;


@property (nonatomic ,strong) NSMutableArray * name_dataSurceArr;

@end
