//
//  HeadViewButton.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadViewButton : UIView

/**
 *  初始化
 *
 *  @param frame         位置大小
 *  @param dataSourceArr 数据源
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame dataSourceArr:(NSMutableArray *)dataSourceArr nameArr:(NSMutableArray *)name;

/**
 *  数据源
 */
@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

/**
 *  内容数据源
 */
@property (nonatomic ,strong) NSMutableArray * nameArr;

/**
 *  block 回调
 */
@property (nonatomic, copy) void (^Showstring)(NSInteger  index);


@end
