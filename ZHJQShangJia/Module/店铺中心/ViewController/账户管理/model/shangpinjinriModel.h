//
//  shangpinjinriModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/13.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class shangpinjinrData,shangpinjinrAll,shangpinjinrToday,shangpinjinrHeader;
@interface shangpinjinriModel : NSObject


@property (nonatomic, strong) shangpinjinrData *data;

@property (nonatomic, strong) shangpinjinrHeader *header;


@end
@interface shangpinjinrData : NSObject

@property (nonatomic, strong) shangpinjinrAll *all;

@property (nonatomic, strong) NSArray *orderList;

@property (nonatomic, strong) shangpinjinrToday *today;

@end

@interface shangpinjinrAll : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface shangpinjinrToday : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface shangpinjinrHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

