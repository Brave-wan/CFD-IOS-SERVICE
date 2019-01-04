//
//  AutoTextView.h
//  AutoTextView
//
//  Created by cooptec on 16/6/9.
//  Copyright © 2016年 Wolibear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AutoTextViewOption)(CGFloat);
typedef void(^AutoTextViewDidFinishOption)(NSString *);

@interface AutoTextView : UITextView<UITextViewDelegate>

@property (copy, nonatomic) AutoTextViewOption option;

@property (copy, nonatomic) AutoTextViewDidFinishOption textOption;

/**
 *  提示用户输入的标语
 */
@property (nonatomic, copy) NSString *placeHolder;

/**
 *  标语文本的颜色
 */
@property (nonatomic, strong) UIColor *placeHolderTextColor;

@property (nonatomic, strong) UILabel * placeHolderLabel;



@end
