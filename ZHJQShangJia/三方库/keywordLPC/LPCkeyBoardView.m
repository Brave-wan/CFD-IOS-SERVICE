//
//  LPCkeyBoardView.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/11.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCkeyBoardView.h"

@implementation LPCkeyBoardView

-(id)initWithFrame:(CGRect)frame{
    
    if([super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor  grayColor];
        
        // 文本框
        
        _TextView = [[AutoTextView alloc]initWithFrame:CGRectMake(21, 6, SCREEN_WIDTH-116, 32)];
        
        _TextView.backgroundColor = [UIColor redColor];
        
        __weak typeof(self) weakSelf = self;
      
        _TextView.option = ^(CGFloat height){
            
            __strong typeof(weakSelf) strongSelf = weakSelf;

            if(height > 32){
                
                [strongSelf fraemchange:height];
                
            }
            
        };
        
        [self addSubview:_TextView];
        
        
        
        //  发送按钮
        
        _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-75, 7, 65, 30)];
        
        _sendButton.clipsToBounds = YES;
       
        _sendButton.layer.cornerRadius = 5;
       
        _sendButton.backgroundColor = [UIColor orangeColor];
        
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
       
        [_sendButton addTarget:self action:@selector(sendTheMessage:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_sendButton];
        
        
        // 通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        
    }
    
    return self;
    
}
#pragma mark 发送点击事件
-(void)sendTheMessage:(UIButton *)sendButton{
    
    if([self.object respondsToSelector:@selector(sendbuttonclick:)]){
        
        [self.object sendbuttonclick:_TextView.text];
        
    }
    
}

#pragma mark 调起键盘
-(void)keyboardShow:(NSNotification*)notif{
    
    CGRect boxFrame = self.frame;
    
    NSDictionary* info = [notif userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _key_heght = kbSize.height;
    
    boxFrame.origin.y = SCREEN_HEIGHT - kbSize.height - 64 - 44;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.frame = boxFrame;
        
    }];
    
}
#pragma mark 删除通知
-(void)dealloc {
    
    
    
}


#pragma mark 变化frame
-(void)fraemchange:(CGFloat)height{

    if([self.object respondsToSelector:@selector(changeFrame:keyheghit:)]){
        
        [self.object changeFrame:SCREEN_HEIGHT - 64 - 44 - (height - 32) -_key_heght keyheghit:_key_heght];
        
    }
    
}

@end
