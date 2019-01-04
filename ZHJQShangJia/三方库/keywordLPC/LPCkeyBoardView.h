//
//  LPCkeyBoardView.h
//  ZHJQShangJia
//
//  Created by APP on 16/10/11.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoTextView.h"

@protocol sendbuttonclick <NSObject>

- (void)sendbuttonclick:(NSString *)string;


- (void)changeFrame:(CGFloat) heghit keyheghit:(CGFloat)keyheghit;

@end

@interface LPCkeyBoardView : UIView

/**
 *  发送按钮
 */
@property (nonatomic ,strong )UIButton * sendButton;

/**
 *  内置textview
 */
@property (nonatomic ,strong )AutoTextView * TextView;

/**
 *  初始化
 *
 *  @param frame 位置大小
 *
 *  @return self
 */
-(id)initWithFrame:(CGRect)frame;

/**
 *  必传项（用来回调）
 */
@property (nonatomic ,strong) id object;

/**
 *  键盘的高度
 */
@property (nonatomic ,assign) CGFloat  key_heght;

@end
