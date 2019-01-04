
//
//  LPCTabelVIewHieadView.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCTabelVIewHieadView.h"

@implementation LPCTabelVIewHieadView

-(id)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
       
        
        for(int i = 0 ; i < 2  ; i ++){
            
            UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * i, 0, frame.size.width/2-.5, 100)];
            
            backView.backgroundColor = COLOR(237, 243, 248, 1);
            
            [self addSubview:backView];
            
            UILabel * now = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, backView.frame.size.width, 30)];
            if(i == 0)
            
                now.text = @"今日营业额";
           
            if (i == 1)
             
                now.text= @"今日订单数";
            
            
            
            now.textAlignment = NSTextAlignmentCenter;
            
            now.font = [UIFont systemFontOfSize:now.font.pointSize - 3];
            
            now.adjustsFontSizeToFitWidth = true;
            
            [backView addSubview:now];
            
            backView.tag = i ;
            
            backView.userInteractionEnabled = self.userInteractionEnabled = true;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            
            tap.numberOfTapsRequired = 1;
            
            [backView addGestureRecognizer:tap];
            
            
            
            if(i == 0){
                
                _nowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+ 10, backView.frame.size.width, 30)];
                
                _nowLabel.textAlignment = NSTextAlignmentCenter;
                
                _nowLabel.adjustsFontSizeToFitWidth = true;
                
                _nowLabel.textColor = COLOR(0, 149, 222, 1);//textColor = COLOR(255, 70, 78, 1);
                
                _nowLabel.font = [UIFont systemFontOfSize:_nowLabel.font.pointSize + 4];

                
                [backView addSubview:_nowLabel];
                
              
                
                
            }
            if(i == 1){
                
                _allLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+ 10, backView.frame.size.width, 30)];
                
                _allLabel.textAlignment = NSTextAlignmentCenter;
                
                _allLabel.adjustsFontSizeToFitWidth = true;
                
                _allLabel.font = [UIFont systemFontOfSize:_allLabel.font.pointSize + 4];

                
                _allLabel.textColor = COLOR(247,91,92, 1);
                
                [backView addSubview:_allLabel];
                
            }
            
            
            if(i == 1){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-.5, 0, .7, backView.frame.size.height)];
                
                label.backgroundColor = [UIColor lightGrayColor];
                
                [self addSubview:label];
                
            }
            
        }
        
        
        _henglabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100-1.5, SCREEN_WIDTH/2 -40, 1.5)];
        
        _henglabel.backgroundColor =COLOR(255, 70, 78, 1);
        
       // [self addSubview:_henglabel];
        
        
        UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, SCREEN_WIDTH , 30)];
        
        contentLabel.textColor = [UIColor lightGrayColor];
        
        contentLabel.text =@"以下是今日订单明细 :";
        
        contentLabel.textAlignment = NSTextAlignmentLeft;
        
        contentLabel.font = [UIFont systemFontOfSize:contentLabel.font.pointSize - 4];
        
        [self addSubview:contentLabel];
        
        UILabel * hh = [[UILabel alloc]initWithFrame:CGRectMake(0, 129.5, SCREEN_WIDTH, .5)];
        
        hh.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:hh];
        
    }
    
    return self;
    
}

-(void)setNowString:(NSString *)nowString{
    
    [self text:nowString label:_nowLabel string:@"1"];
    
}

-(void)setAllString:(NSString *)allString{
    
    [self text:allString label:_allLabel string:@"2"];
    
}

-(void)text:(NSString *)string label:(UILabel *)label string:(NSString *)type{
   
    label.text = nil;
    
    NSString * lengString = @"";
    
    UIColor * color;
    
    
    
    if([type isEqualToString:@"2"]){
        
       lengString = [NSString stringWithFormat:@"%@",string];

        color=  COLOR(247,91,92, 1);
    }
    
    else if([type isEqualToString:@"1"]){
        
      lengString=  [NSString stringWithFormat:@"￥%@",string];
    
      color=  COLOR(0, 149, 222, 1);
        
    }

    
    label.text  = lengString; //[NSString stringWithFormat:@"￥%@",string];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:lengString];
    
   
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:color
     
                          range:NSMakeRange(0, lengString.length)];
    
    
    
    label.attributedText = AttributedStr;
    
    
}

-(void)tap:(UITapGestureRecognizer *)flay{
    /*
    if(flay.view.tag == 0){
       
        CGRect frame = CGRectMake(20, flay.view.frame.size.height -1.5, SCREEN_WIDTH/2 -40, 1.5);
        
        _allLabel.textColor = COLOR(53, 163, 227, 1);
        
        _nowLabel.textColor  = COLOR(255, 70, 78, 1);
        
        [self frameP:frame label:@"0"];
        
    }if(flay.view.tag == 1){
        
        _allLabel.textColor = COLOR(255, 70, 78, 1);
        
        _nowLabel .textColor = COLOR(53, 163, 227, 1);
        
        CGRect frame = CGRectMake(SCREEN_WIDTH/2+20, flay.view.frame.size.height -1.5, SCREEN_WIDTH/2 -40, 1.5);
        
        [self frameP:frame label:@"1"];
    }
    
    
    if(self.ShowType){
        
        self.ShowType(flay.view.tag);
    }
    */
}

-(void)frameP:(CGRect )frame label:(NSString *)type{

    [UIView animateWithDuration:.2 animations:^{
        
        CGRect frem =   _henglabel.frame;
        
        frem = frame;
        
        _henglabel.frame = frem;
        
    } completion:^(BOOL finished) {
        
       
        
    }];
    
    
    [UIView animateWithDuration:.2 animations:^{
        
        
        
    }];
    
}
@end
