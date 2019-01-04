//
//  LPCfandiandataArrModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LpcfandianData,LpcfandianHeader;
@interface LPCfandiandataArrModel : NSObject


@property (nonatomic, strong) LpcfandianData *data;

@property (nonatomic, strong) LpcfandianHeader *header;

@end
@interface LpcfandianData : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray *rows;

@property (nonatomic, assign) NSInteger lastPage;

@end

@interface LpcfandianHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

