//
//  ZHJQHLoginViewControll.h
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"

@protocol ZHJQHLoginViewControllDelegate <NSObject>

- (void)chooseRootViewController:(NSString *)type;

@end

@interface ZHJQHLoginViewControll : ZHJQHRootViewController

@property (nonatomic, strong) id delegate;


@end
