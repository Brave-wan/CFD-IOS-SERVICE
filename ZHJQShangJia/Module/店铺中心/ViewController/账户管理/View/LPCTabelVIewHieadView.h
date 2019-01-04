//
//  LPCTabelVIewHieadView.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPCTabelVIewHieadView : UIView

-(id)initWithFrame:(CGRect)frame;

@property (nonatomic ,strong) UILabel * nowLabel ;

@property (nonatomic ,strong) NSString * nowString;

@property (nonatomic ,strong) UILabel * allLabel;

@property (nonatomic ,strong) NSString * allString;

@property (nonatomic ,strong) UILabel * henglabel;

@property (nonatomic, copy) void (^ShowType)(NSInteger  index);


@end
