//
//  ZHJQHRootViewController.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHJQHRootViewController : UIViewController

/**
 *  nav 标题
 *
 *  @param title 文本内容
 */
-(void)nav_title:(NSString *)title;

/**
 *  返回
 */
-(void)left;

/**
 *  push 页面
 *
 *  @param viewcontroller 目标Controller
 */
-(void)push:(UIViewController *)viewcontroller;

/**
 *  self.view 的背景色
 *
 *  @param color 颜色
 */
-(void)backColor:(UIColor *)color;


/**
 *  label 计算高度
 *
 *  @param contentLabel 当前的label ---- 需要计算的
 *  @param poit         字体大小----- 当前的字体大小-(self)
 *  @param string       text
 *  @param roadLabel    根据某个label 创建的当前的label
 *
 *  @return height/width
 */
-(CGRect)gethegitLabel:(UILabel *)contentLabel sizepoit:(int)poit textString:(NSString *)string newLbale:(UILabel *)roadLabel;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

/**
 *  网络指示器的展示
 */
-(void)MBPhudShow;

/**
 *  网络指示器消失
 */
-(void)MBhudhud;

/**
 *  自定义网络指示器内容
 *
 *  @param string 自定义的内容
 */
-(void)MBShow:(NSString *)string backview:(UIView *)backview;

/**
 *  判断字符串是不是<null>
 *
 *  @param string 需要判断的字符串
 *
 *  @return true ? false
 */
-(NSString *)getstring:(NSString *)string;

/**
 *  判断iamge是不是<null>
 *
 *  @param image 需要判断的字符串
 *
 *  @return true ? false
 */
-(BOOL)getimage:(UIImage *)image;

/**
 *  返回服务器给的错误信息
 *
 *  @param headdic 传入的字典
 *
 *  @return string - msg
 */
-(NSString *)head:(NSDictionary *)headdic;

/**
 *  返回状态值
 *
 *  @param dic 传入参数
 *
 *  @return status-string
 */
-(NSString *)headdic:(NSDictionary *)dic;

@end
