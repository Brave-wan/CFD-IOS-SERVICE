//
//  LPCDINGDANXIANGQImodel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/26.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPCqingdanxiangData,LPCqingdanxiangMap,LPCqingdanxiangHeader,LPCqingdanxiangExpress,LPCqingdanxiangrefundCause;
@interface LPCDINGDANXIANGQImodel : NSObject



@property (nonatomic, strong) LPCqingdanxiangData *data;

@property (nonatomic, strong) LPCqingdanxiangHeader *header;



@end
@interface LPCqingdanxiangData : NSObject

@property (nonatomic, strong) LPCqingdanxiangExpress *express;

@property (nonatomic ,strong) LPCqingdanxiangrefundCause * refundCause;

@property (nonatomic, strong) NSArray<LPCqingdanxiangMap *> *map;

@end


@interface LPCqingdanxiangExpress : NSObject

@property (nonatomic ,assign) long long expressCreateDate;

@property (nonatomic, assign) NSInteger express_code;

@property (nonatomic, copy) NSString *express_name;



@end

@interface LPCqingdanxiangrefundCause : NSObject

@property (nonatomic ,assign) long long id;

@property (nonatomic, assign)long long orderCode;

@property (nonatomic, assign)long long shopInformationId ;

@property (nonatomic, assign)long long userId ;

@property (nonatomic, assign)long long userPhone;

@property (nonatomic, copy) NSString *cause;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *userName;




@end

@interface LPCqingdanxiangMap : NSObject

@property (nonatomic, assign) NSInteger is_update_price;

@property (nonatomic, copy) NSString *detail_address;

@property (nonatomic, assign) NSInteger is_comment;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, copy) NSString *telphone;

@property (nonatomic, copy) NSString *place_address;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, assign) NSInteger newPrice;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, assign) long long informationId;

@property (nonatomic, assign) NSInteger pay_way;

@property (nonatomic, assign) NSInteger oldPrice;

@property (nonatomic, assign) long long goodsId;

@property (nonatomic, copy) NSString *informationName;

@property (nonatomic, copy) NSString *pay_time;

@property (nonatomic, assign) NSInteger is_deliver_fee;

@property (nonatomic, assign) NSInteger is_pickup;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, copy) NSString *refund_time;

@property (nonatomic, assign) NSInteger deliver_fee;

@property (nonatomic, assign) long long address_id;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *nick_name;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *goods_name;

@end

@interface LPCqingdanxiangHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

