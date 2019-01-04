//
//  LPCShopCeneterModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/21.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class shopData,shopHeader;
@interface LPCShopCeneterModel : NSObject

@property (nonatomic, strong) shopData *data;

@property (nonatomic, strong) shopHeader *header;

@end
@interface shopData : NSObject

@property (nonatomic, assign) long long assid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *start_date;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *backgroud_img;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *detailUrl;

@property (nonatomic, copy) NSString *is_blss;

@property (nonatomic, copy) NSString *is_yushi;

@property (nonatomic, copy) NSString *is_wifi;

@property (nonatomic, copy) NSString *is_food;

@property (nonatomic, copy) NSString *is_media;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger shop_id;

@end

@interface shopHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

