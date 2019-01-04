//
//  JPushJiuDianModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/18.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPushJiuDianHeader,JPushJiuDianData;
@interface JPushJiuDianModel : NSObject


@property (nonatomic, strong) NSArray<JPushJiuDianData *> *data;

@property (nonatomic, strong) JPushJiuDianHeader *header;



@end
@interface JPushJiuDianHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

@interface JPushJiuDianData : NSObject

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, assign) NSInteger is_balance;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, copy) NSString *goods_name;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, strong) NSArray<NSString *> *personName;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *refund_time;

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) long long goods_id;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *start_date;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger check_days;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger is_comment;

@end

