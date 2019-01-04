//
//  JIUDIANJINRImodel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/8.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JiudianData,JiudianAll,JiudianToday,JiudianOrderlist,JiudianHeader;
@interface JIUDIANJINRImodel : NSObject



@property (nonatomic, strong) JiudianData *data;

@property (nonatomic, strong) JiudianHeader *header;


@end
@interface JiudianData : NSObject

@property (nonatomic, strong) JiudianAll *all;

@property (nonatomic, strong) NSArray<JiudianOrderlist *> *orderList;

@property (nonatomic, strong) JiudianToday *today;

@end

@interface JiudianAll : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface JiudianToday : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger realPrice;

@end

@interface JiudianOrderlist : NSObject

@property (nonatomic, assign) long long ID;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *start_date;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger check_days;

@property (nonatomic, assign) long long consumerId;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, copy) NSString *name;

@property (nonatomic ,copy) NSString *goods_name;

@end

@interface JiudianHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

