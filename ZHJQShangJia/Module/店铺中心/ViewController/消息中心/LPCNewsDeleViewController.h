//
//  LPCNewsDeleViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "LPCNEWSmodels.h"

@interface LPCNewsDeleViewController : ZHJQHRootViewController

@property (nonatomic ,strong) newsRows * model_row;

@property (nonatomic ,assign) long long detaileID;

@property (nonatomic ,strong) NSString * type;

@property (nonatomic ,assign) int type_root;


@end
