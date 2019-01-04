//
//  LPCUPPAWmodel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/21.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPCPAWHeader;
@interface LPCUPPAWmodel : NSObject


@property (nonatomic, strong) NSArray<NSString *> *data;

@property (nonatomic, strong) LPCPAWHeader *header;


@end
@interface LPCPAWHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

