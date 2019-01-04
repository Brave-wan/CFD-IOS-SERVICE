//
//  LPCCustomView.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPCCustomButton.h"

@interface LPCCustomView : UIView

/**
 *  初始化
 *
 *  @param frame   位置大小
 *  @param images  图片集合
 *  @param strings 文本集合
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame
            images:(NSMutableArray *)images
            string:(NSMutableArray *)strings;
@end
