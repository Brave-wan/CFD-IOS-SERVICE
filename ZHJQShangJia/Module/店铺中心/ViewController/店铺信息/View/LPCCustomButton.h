//
//  LPCCustomButton.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPCCustomButton : UIButton

/**
 *  初始化
 *
 *  @param frame  位置大小
 *  @param image  图片
 *  @param string 文本
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame image:(UIImage *)image string:(NSString *)string;

@end
