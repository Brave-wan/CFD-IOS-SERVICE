//
//  LPCNEWSmodels.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/10.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCNEWSmodels.h"

@implementation LPCNEWSmodels

@end
@implementation newsData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"rows" : [newsRows class]};
}

@end


@implementation newsRows

@end


@implementation newsHeader

@end


