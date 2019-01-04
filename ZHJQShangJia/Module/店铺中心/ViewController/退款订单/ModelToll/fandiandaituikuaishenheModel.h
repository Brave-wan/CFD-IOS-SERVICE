//
//  fandiandaituikuaishenheModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/11.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class fandiandaishenheheHeader;
@interface fandiandaituikuaishenheModel : NSObject


@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) fandiandaishenheheHeader *header;


@end
@interface fandiandaishenheheHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

