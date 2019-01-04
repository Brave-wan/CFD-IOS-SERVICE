//
//  shangpintuikuaidingdanmodel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/17.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class shangpintuikuaiData,shangpintuikuaiHeader;
@interface shangpintuikuaidingdanmodel : NSObject



@property (nonatomic, strong) shangpintuikuaiData *data;

@property (nonatomic, strong) shangpintuikuaiHeader *header;


@end
@interface shangpintuikuaiData : NSObject

@property (nonatomic, assign) NSInteger orderCount;

@property (nonatomic, strong) NSArray *orderList;

@end

@interface shangpintuikuaiHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

