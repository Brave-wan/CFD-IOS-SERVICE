//
//  LPCjiudianfandiantuijingModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPCJIUDIANFANDIANTUIDINGKUANHeader,LPCJIUDIANFANDIANTUIDINGKUANData;
@interface LPCjiudianfandiantuijingModel : NSObject



@property (nonatomic, strong) NSArray<LPCJIUDIANFANDIANTUIDINGKUANData *> *data;

@property (nonatomic, strong) LPCJIUDIANFANDIANTUIDINGKUANHeader *header;


@end
@interface LPCJIUDIANFANDIANTUIDINGKUANHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

@interface LPCJIUDIANFANDIANTUIDINGKUANData : NSObject

@property (nonatomic, assign) long long id;

@property (nonatomic, copy) NSString *start_date;

@property (nonatomic, assign) NSInteger pay_state;

@property (nonatomic, assign) NSInteger real_price;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *order_code;

@property (nonatomic, copy) NSString *describe_img;

@property (nonatomic, assign) NSInteger order_state;

@property (nonatomic, copy) NSString *order_describe;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *name;

@end

