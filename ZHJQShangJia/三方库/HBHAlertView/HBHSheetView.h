//
//  HBHSheetView.h
//  ZHJQShangJia
//
//  Created by APP on 16/7/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBHSheetView : UIView
/**
 *  半透明背景
 */
@property (nonatomic, strong) UIControl *overlayView;
/**
 *  展示sheet的view
 */
@property(nonatomic,strong)UIView *viewS;

/**
 *  回调选中的
 */
@property (nonatomic, copy) void (^chooseBlock)(NSString * dataString);

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array;

/**
 *  sheetView展示
 */
-(void)show;
/**
 *  sheetView消失
 */
-(void)dismiss;

@end
