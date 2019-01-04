//
//  JPushshangpinModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/17.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPushShangPinData,JPushShangPinExpress,JPushShangPinMap,JPushShangPinHeader;
@interface JPushshangpinModel : NSObject


@property (nonatomic, strong) JPushShangPinData *data;

@property (nonatomic, strong) JPushShangPinHeader *header;




@end
@interface JPushShangPinData : NSObject

@property (nonatomic, strong) JPushShangPinExpress *express;

@property (nonatomic, strong) NSArray<JPushShangPinMap *> *map;

@end

@interface JPushShangPinExpress : NSObject

@property (nonatomic, copy) NSString *express_name;

@property (nonatomic, copy) NSString *expressCreateDate;

@property (nonatomic, copy) NSString *express_code;

@end

@interface JPushShangPinMap : NSObject

@property (nonatomic, copy) NSString *detail_address;

@property (nonatomic, assign) NSInteger is_update_price;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, copy) NSString *place_address;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger newPrice;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, assign) long long informationId;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, assign) NSInteger oldPrice;

@property (nonatomic, assign) long long goodsId;

@property (nonatomic, copy) NSString *informationName;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, assign) NSInteger is_deliver_fee;

@property (nonatomic, assign) NSInteger is_pickup;

@property (nonatomic, assign) NSInteger is_comment;

@property (nonatomic, copy) NSString *refund_time;

@property (nonatomic, assign) NSInteger deliver_fee;

@property (nonatomic, assign) long long address_id;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *order_code;

@end

@interface JPushShangPinHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

