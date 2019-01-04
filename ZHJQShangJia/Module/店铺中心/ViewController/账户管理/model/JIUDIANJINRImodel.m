//
//  JIUDIANJINRImodel.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/8.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "JIUDIANJINRImodel.h"

@implementation JIUDIANJINRImodel

@end
@implementation JiudianData

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"orderList" : [JiudianOrderlist class]};
}



@end


@implementation JiudianAll

@end


@implementation JiudianToday

@end


@implementation JiudianOrderlist

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"ID" : @"id"};
}

@end


@implementation JiudianHeader

@end


