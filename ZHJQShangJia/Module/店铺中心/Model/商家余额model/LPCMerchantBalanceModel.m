//
//  LPCMerchantBalanceModel.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/22.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCMerchantBalanceModel.h"

@implementation LPCMerchantBalanceModel

@end
@implementation MerchanData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tradeLogList" : [MerchanTradeloglist class]};
}

@end


@implementation MerchanBalancemap

@end


@implementation MerchanTradeloglist

@end


@implementation MerchanHeader

@end


