//
//  LPCNEWSmodels.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/10.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class newsData,newsRows,newsHeader;
@interface LPCNEWSmodels : NSObject


@property (nonatomic, strong) newsData *data;

@property (nonatomic, strong) newsHeader *header;


@end
@interface newsData : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, strong) NSArray<newsRows *> *rows;

@end

@interface newsRows : NSObject

@property (nonatomic, assign) NSInteger detailId;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, assign) long long shopInformationId;

@property (nonatomic, assign) NSInteger type;

@end

@interface newsHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

