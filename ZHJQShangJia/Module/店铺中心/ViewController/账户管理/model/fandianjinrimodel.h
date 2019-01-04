//
//  fandianjinrimodel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/9.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class fandianjinriData,fandianjinriAll,fandianjinriToday,fandianjinriHeader;
@interface fandianjinrimodel : NSObject



@property (nonatomic, strong) fandianjinriData *data;

@property (nonatomic, strong) fandianjinriHeader *header;


@end
@interface fandianjinriData : NSObject

@property (nonatomic, strong) fandianjinriAll *all;

@property (nonatomic, strong) NSArray *orderList;

@property (nonatomic, strong) fandianjinriToday *today;

@end




@interface fandianjinriAll : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface fandianjinriToday : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface fandianjinriHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

