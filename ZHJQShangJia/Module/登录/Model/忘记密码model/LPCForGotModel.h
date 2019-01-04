//
//  LPCForGotModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/22.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ForGorHeader;
@interface LPCForGotModel : NSObject



@property (nonatomic, copy) NSString *data;

@property (nonatomic, strong) ForGorHeader *header;



@end
@interface ForGorHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

