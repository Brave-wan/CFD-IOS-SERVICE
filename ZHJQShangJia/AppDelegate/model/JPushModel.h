//
//  JPushModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/12.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JpushAps;
@interface JPushModel : NSObject



@property (nonatomic, assign) NSInteger _j_msgid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) JpushAps *aps;

@property (nonatomic, assign) long long siId;

@property (nonatomic, assign) NSInteger  type;

@property (nonatomic, assign) long long orderCode;

@property (nonatomic, assign) NSInteger  goodsType;

@property (nonatomic, assign) long long detailId;

@end
@interface JpushAps : NSObject

@property (nonatomic, copy) NSString *alert;

@property (nonatomic, assign) NSInteger badge;

@property (nonatomic, copy) NSString *sound;

@end

