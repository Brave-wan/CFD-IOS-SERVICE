//
//  LPCNOTwoModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelHeader,LPCNOTwoModelLei;
@interface LPCNOTwoModel : NSObject

@property (nonatomic, strong) NSArray<LPCNOTwoModelLei *> *data;

@property (nonatomic, strong) ModelHeader *header;

@end

@interface ModelHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

@interface LPCNOTwoModelLei : NSObject

@property (nonatomic, assign) NSInteger is_comment;

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, assign) NSInteger goods_type;

@property (nonatomic, assign) long long shop_information_id;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *refund_time;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *eat_date;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger is_balance;

@end