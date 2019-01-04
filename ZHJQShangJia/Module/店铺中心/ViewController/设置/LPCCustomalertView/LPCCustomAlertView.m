//
//  LPCCustomAlertView.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCCustomAlertView.h"

@implementation LPCCustomAlertView

-(id)initWithFrame:(CGRect)frame message:(NSString *)message title:(NSString *)title color:(UIColor *)color{
    
    _color = color;
    
    if(self = [super initWithFrame:frame]){
        
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3 * 2, self.frame.size.width/2.4)];
        
        backView.center = self.center;
        
        backView.backgroundColor =[UIColor whiteColor];
        
        backView.layer.cornerRadius = 7;
        
        [self addSubview:backView];
        
        
        // 3 中间层view
        
        UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        coverView.backgroundColor = [UIColor blackColor];
        
        coverView.alpha = 0.0;//透明
        
        self.coverView = coverView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        
        tap.numberOfTapsRequired = 1;
        
        [self.coverView addGestureRecognizer:tap];
        
        // 标题
        UILabel * title_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height/3)];
        
        title_label.text = title;
        
        title_label.textAlignment = NSTextAlignmentCenter;
        
        title_label.font = [UIFont systemFontOfSize:title_label.font.pointSize];
        
        [backView addSubview:title_label];
        
        // message
        
        UILabel * message_label = [[UILabel alloc]initWithFrame:CGRectMake(0, backView.frame.size.height/3, backView.frame.size.width, backView.frame.size.height/3)];
        
        message_label.textAlignment = NSTextAlignmentCenter;
        
        message_label.text = message;
        
        message_label.numberOfLines = 0;
        
        message_label.font = [UIFont systemFontOfSize:message_label.font.pointSize - 3];
        
        message_label.adjustsFontSizeToFitWidth = true;
        
        [backView addSubview:message_label];
        
        // 俩个按钮
        
        UILabel * heng = [[UILabel alloc]initWithFrame:CGRectMake(0, backView.frame.size.height/3 * 2, backView.frame.size.width, .4)];
        
        heng.backgroundColor = [UIColor lightGrayColor];
        
        [backView addSubview:heng];
        
        UILabel * shu = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width/2 -0.3, heng.frame.origin.y + .4 + 5, .4, backView.frame.size.height/3 - 10)];
        
        shu.backgroundColor = [UIColor lightGrayColor];
        
        [backView addSubview:shu];
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, heng.frame.origin.y + .4 + 5, backView.frame.size.width/2 -20, backView.frame.size.height/3 - 10.8)];
        
        [button setTitle:@"确定" forState:UIControlStateNormal];
        
        [button setTitleColor:color forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.layer.borderWidth = .4;
        
        button.layer.cornerRadius = 5;
        
        button.layer.borderColor = color.CGColor;
        
        [button addTarget:self action:@selector(button_click:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:button];
        
        
        
        UIButton * button_ = [[UIButton alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+10, heng.frame.origin.y + .4 + 5, backView.frame.size.width/2 -20, backView.frame.size.height/3 - 10.8)];
        
        [button_ setTitle:@"取消" forState:UIControlStateNormal];
        
        [button_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button_.layer.masksToBounds = true;
        
        button_.layer.borderWidth = .4;
        
        button_.layer.cornerRadius = 5;
        
        button_.layer.borderColor = color.CGColor;
        
        [button_ setBackgroundColor:color];
        
        [button_ addTarget:self action:@selector(no_click:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:button_];
        
        
    }
    
    return self;
    
}

-(void)removeView{

    [self.coverView removeFromSuperview];
    
    [self  removeFromSuperview];

}


- (void)alertShow{
    UIView *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    [window insertSubview:self.coverView belowSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.coverView.alpha = .4;
        
    } completion:^(BOOL finished) {
        
    }];
    
    CGFloat duration = 0.3;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:@"bouce"];
}

-(id)initWithFrame:(CGRect)frame
             place:(NSString *)place
             title:(NSString *)title
             color:(UIColor *)color
            string:(NSString *)string
              view:(UIView *)view{
    
    _color = color;
    
    self.selfview = view;
    
    _string = string;
    
    if(self = [super initWithFrame:frame]){
        
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3 * 2, self.frame.size.width/2.4)];
        
        backView.center = self.center;
        
        backView.backgroundColor =[UIColor whiteColor];
        
        CGRect frame = backView.frame;
        
        frame.origin.y =  frame.origin.y - 100;
        
        backView.frame = frame;
        
        backView.layer.cornerRadius = 7;
        
        [self addSubview:backView];
        
        
        // 3 中间层view
        
        UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        coverView.backgroundColor = [UIColor blackColor];
        
        coverView.alpha = 0.0;//透明
        
        self.coverView = coverView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        
        tap.numberOfTapsRequired = 1;
        
        [self.coverView addGestureRecognizer:tap];
        
        // 标题
        UILabel * title_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height/3)];
        
        title_label.text = title;
        
        title_label.textAlignment = NSTextAlignmentCenter;
        
        title_label.font = [UIFont systemFontOfSize:title_label.font.pointSize];
        
        [backView addSubview:title_label];
        
        // message
        
        UITextField * message_label = [[UITextField alloc]initWithFrame:CGRectMake(0, backView.frame.size.height/3, backView.frame.size.width, backView.frame.size.height/3)];
        
        message_label.textAlignment = NSTextAlignmentCenter;
        
        message_label.placeholder = place;
        
        message_label.keyboardType = UIKeyboardTypeNumberPad;
                
        message_label.font = [UIFont systemFontOfSize:message_label.font.pointSize - 3];
        
        message_label.adjustsFontSizeToFitWidth = true;
        
        _messtextfild = message_label;
        
        [backView addSubview:message_label];
        
        // 俩个按钮
        
        UILabel * heng = [[UILabel alloc]initWithFrame:CGRectMake(0, backView.frame.size.height/3 * 2, backView.frame.size.width, .4)];
        
        heng.backgroundColor = [UIColor lightGrayColor];
        
        [backView addSubview:heng];
        
        UILabel * shu = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width/2 -0.3, heng.frame.origin.y + .4 + 5, .4, backView.frame.size.height/3 - 10)];
        
        shu.backgroundColor = [UIColor lightGrayColor];
        
        [backView addSubview:shu];
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, heng.frame.origin.y + .4 + 5, backView.frame.size.width/2 -20, backView.frame.size.height/3 - 10.8)];
        
        [button setTitle:@"取消" forState:UIControlStateNormal];
        
        [button setTitleColor:color forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.layer.borderWidth = .4;
        
        button.layer.cornerRadius = 5;
        
        button.layer.borderColor = color.CGColor;
        
        [button addTarget:self action:@selector(button_click:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:button];
        
        
        
        UIButton * button_ = [[UIButton alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+10, heng.frame.origin.y + .4 + 5, backView.frame.size.width/2 -20, backView.frame.size.height/3 - 10.8)];
        
        [button_ setTitle:@"确定" forState:UIControlStateNormal];
        
        [button_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button_ setBackgroundColor:color];
        
        button_.layer.masksToBounds = true;
        
        button_.layer.borderWidth = .4;
        
        button_.layer.cornerRadius = 5;
        
        button_.layer.borderColor = color.CGColor;
        
        [button_ addTarget:self action:@selector(no_click:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:button_];
        
        
    }
    
    return self;
    
    
}

-(void)button_click:(UIButton *)sender{
    
    sender.backgroundColor =  _color;
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    if(self.Showstring){
        
        self.Showstring(sender.titleLabel.text);
        
    }
    
    [self removeView];
    
}

-(void)no_click:(UIButton *)sender{
    
    sender.backgroundColor =  _color;
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    if(self.Showstring){
        
        self.Showstring (sender.titleLabel.text);
        
    }
    
    if(self.ShowNum){
        
        self.ShowNum(sender.titleLabel.text,_messtextfild.text);
        
    }
    
    if([_string isEqualToString:@"1"]){
        
        
    }else {

       

    }
     [self removeView];
    
}

- (void)alertViewShow{
    //UIView *window = [[UIApplication sharedApplication].windows lastObject];
    [self.selfview addSubview:self];
    
    [self.selfview insertSubview:self.coverView belowSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.coverView.alpha = .4;
        
    } completion:^(BOOL finished) {
        
    }];
    
    CGFloat duration = 0.3;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [self.layer addAnimation:animation forKey:@"bouce"];
}

@end
