//
//  LPCTXViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@protocol tixianelegate <NSObject>

- (void)tixianhuitiao;

@end

@interface LPCTXViewController : ZHJQHRootViewController

@property (nonatomic ,strong) id object;

@property (nonatomic ,strong) UITextField  * textfild_pass;

@property (nonatomic ,strong) NSString * string_num;

@end
