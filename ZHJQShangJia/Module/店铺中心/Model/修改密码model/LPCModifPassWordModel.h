//
//  LPCModifPassWordModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/21.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPCPassWordHeader;
@interface LPCModifPassWordModel : NSObject



@property (nonatomic, copy) NSString *data;

@property (nonatomic, strong) LPCPassWordHeader *header;


@end
@interface LPCPassWordHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

