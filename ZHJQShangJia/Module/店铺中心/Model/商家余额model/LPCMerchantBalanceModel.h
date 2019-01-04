//
//  LPCMerchantBalanceModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/22.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MerchanData,MerchanBalancemap,MerchanTradeloglist,MerchanHeader;
@interface LPCMerchantBalanceModel : NSObject



@property (nonatomic, strong) MerchanData *data;

@property (nonatomic, strong) MerchanHeader *header;


@end
@interface MerchanData : NSObject

@property (nonatomic, strong) MerchanBalancemap *balanceMap;

@property (nonatomic, strong) NSArray<MerchanTradeloglist *> *tradeLogList;

@end

@interface MerchanBalancemap : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, assign) NSInteger balance;

@end

@interface MerchanTradeloglist : NSObject

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) long long id;

@property (nonatomic, assign) NSInteger trade_integration;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger integration;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger balance;

@property (nonatomic, copy) NSString *name;

@property (nonatomic ,copy)  NSString *nick_name;

@end

@interface MerchanHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

