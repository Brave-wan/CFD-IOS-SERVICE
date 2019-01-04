//
//  LPCgoodModel.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/24.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LPCgoddsData,LPCgoddsHeader,LPCGOODSPage;
@interface LPCgoodModel : NSObject


@property (nonatomic, strong) LPCgoddsData *data;

@property (nonatomic, strong) LPCgoddsHeader *header;



@end
@interface LPCgoddsData : NSObject

@property (nonatomic, strong) LPCGOODSPage *orderList;

@property (nonatomic, assign) NSInteger orderCount;

@end

@interface LPCGOODSPage : NSObject

@property (nonatomic , assign) NSInteger  total;

@property (nonatomic , assign) NSInteger lastPage;


@property (nonatomic ,strong) NSArray  * rows;

@end

@interface LPCgoodsnriong : NSObject



@end

@interface LPCgoddsHeader : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@end

