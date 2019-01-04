//
//  LPCloginModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/7.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LOGINData,Shopmessge,Header;
@interface LPCloginModel : NSObject


@property (nonatomic, strong) LOGINData *data;

@property (nonatomic, strong) Header *header;


@end

@interface LOGINData : NSObject

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) long long userId;

@property (nonatomic, strong) Shopmessge *shopMessge;

//@property (nonatomic, strong) Shopmessge1 *Shopmessge;

@property (nonatomic, copy) NSString *token;

@end

@interface Shopmessge : NSObject

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, copy) NSString *headImg;

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *cashPassWord;

@property (nonatomic, copy) NSString *bankCard;

@property (nonatomic, copy) NSString *shopImg;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *idCard;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger isAudit;

@property (nonatomic, copy) NSString *backgroudImg;

@property (nonatomic, copy) NSString *isFood;

@property (nonatomic, copy) NSString *holdCardImg;

@property (nonatomic, copy) NSString *accountType;

@property (nonatomic, copy) NSString *faceCardImg;

@property (nonatomic, assign) long long shopUserId;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *backCardImg;

@property (nonatomic, copy) NSString *isLicense;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *accountBank;

@property (nonatomic, copy) NSString *isBlss;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *otherImg1;

@property (nonatomic, copy) NSString *accountName;

@property (nonatomic, copy) NSString *consumption;

@property (nonatomic, copy) NSString *isMedia;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *licenseImg;

@property (nonatomic, copy) NSString *isYushi;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *detailId;

@property (nonatomic, copy) NSString *otherImg2;

@property (nonatomic, copy) NSString *businessScope;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, copy) NSString *isWifi;

@property (nonatomic, copy) NSString *auditFail;

@property (nonatomic, copy) NSString *latitude;

@end

@interface Header : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

