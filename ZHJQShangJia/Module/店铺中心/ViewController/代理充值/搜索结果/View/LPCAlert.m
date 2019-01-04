//
//  LPCAlert.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCAlert.h"

@implementation LPCAlert

-(id)initWithFrame:(CGRect)frame
             place:(NSString *)place
             color:(UIColor *)color
               viu:(UIView *)view{
    
    
    
    _color = color;
    
    if(self = [super initWithFrame:frame]){
        
        
        
        // 3 中间层view
        
        UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        coverView.backgroundColor = [UIColor blackColor];
        
        coverView.alpha = 0.3;//透明
        
        self.coverView = coverView;
        
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeVieww)];
        
        tap.numberOfTapsRequired = 1;
        
        [self.coverView addGestureRecognizer:tap];
        
        [self addSubview:self.coverView];
        
        
        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3 * 2, self.frame.size.width/2.4)];
        
        backView.center = [[UIApplication sharedApplication].delegate window].center;
        
        backView.backgroundColor =[UIColor whiteColor];
        
        backView.layer.cornerRadius = 7;
        
        _backView = backView;
        
        [self addSubview:backView];

        
        // message
        
        UILabel * message_label = [[UILabel alloc]initWithFrame:CGRectMake(0, backView.frame.size.height/3, backView.frame.size.width, backView.frame.size.height/3)];
        
        message_label.textAlignment = NSTextAlignmentCenter;
        
        message_label.text = [NSString stringWithFormat:@"确认充值   ￥%@ ?",place];
        
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"确认充值    ￥%@ ?",place]];
        
        
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(8, place.length + 1)];
        
        message_label.attributedText = AttributedStr;
        
        
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

-(void)no_click:(UIButton *)sender{
    
    if(self.Showstring)
    {
        self.Showstring(sender.titleLabel.text);
        
    }
    
    [self removeVieww];
    
}
-(void)button_click:(UIButton *)sender{
 
    [self removeVieww];
    
}

-(void)removeVieww{
    
    [self.coverView removeFromSuperview];
    
    [self  removeFromSuperview];
    
}


- (void)alertShow{
   
    
    UIWindow * window  = [[UIApplication sharedApplication].delegate window];
    
    
    [window addSubview:self];
    
  
    
    CGFloat duration = 0.3;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.8), @(1.05), @(1.1), @(1)];
    animation.keyTimes = @[@(0), @(0.3), @(0.5), @(1.0)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.duration = duration;
    [_backView.layer addAnimation:animation forKey:@"bouce"];
}
@end
