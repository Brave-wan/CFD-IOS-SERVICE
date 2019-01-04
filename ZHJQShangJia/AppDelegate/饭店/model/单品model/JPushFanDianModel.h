//
//  JPushFanDianModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/18.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPushFanDianHeader,JPushFanDianData;
@interface JPushFanDianModel : NSObject



@property (nonatomic, strong) NSArray<JPushFanDianData *> *data;

@property (nonatomic, strong) JPushFanDianHeader *header;


@end
@interface JPushFanDianHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

@interface JPushFanDianData : NSObject

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, assign) NSInteger is_balance;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, assign) NSInteger goods_type;

@property (nonatomic, assign) long long shop_information_id;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *refund_time;

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) long long goods_id;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *eat_date;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger is_comment;

@end

