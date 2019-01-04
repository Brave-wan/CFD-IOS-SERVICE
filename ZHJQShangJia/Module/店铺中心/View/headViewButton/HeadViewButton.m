//
//  HeadViewButton.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "HeadViewButton.h"

@implementation HeadViewButton

-(instancetype)initWithFrame:(CGRect)frame dataSourceArr:(NSMutableArray *)dataSourceArr nameArr:(NSMutableArray *)name{
    
    if(self = [super initWithFrame:frame]){
    
        // 0. 背景色
        
        self.backgroundColor = [UIColor clearColor];
        
        // 1. 数据源
        
        _dataSourceArr = dataSourceArr;
        
        _nameArr = name;
        
        
        // 2. imageview 和label
        
        for(int i = 0 ; i < _dataSourceArr.count ; i ++){
            
            // 2.0 背景View
            
            UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(i  * (frame.size.width/3), 0, frame.size.width/3-1, frame.size.height)];
            
            self.userInteractionEnabled = backView.userInteractionEnabled = true;
            
            backView.backgroundColor = COLOR(132, 219, 255, .6);
            
            UITapGestureRecognizer* singleRecognizer;
            
            self.userInteractionEnabled = backView.userInteractionEnabled = true;
            
            backView.tag = i;
            
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
            
            singleRecognizer.numberOfTapsRequired = 1;
            
            [backView addGestureRecognizer:singleRecognizer];
            
            
            // 2.1 imageView
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/4 -10, 10, 24, 24)];
            
            imageView.image = _dataSourceArr[i];
            
            [backView addSubview:imageView];
            
            [self addSubview:backView];
            
            // 2.2 内容Label
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + 26, imageView.frame.origin.y - 2, backView.frame.size.width - imageView.frame.origin.x- 35, 24)];
            
            label.text =_nameArr[i];
            
            label.textColor = [UIColor whiteColor];
            
            label.adjustsFontSizeToFitWidth = true;
            
            imageView.userInteractionEnabled = label.userInteractionEnabled = true;
            
            [backView addSubview:label];
            
        }
        
    }
    
    return self;
}

-(void)handleSingleTapFrom:(UITapGestureRecognizer *)flay{
    
    UIView * backView = (UIView *)flay.view;
    
    if(self.Showstring){
        
        self.Showstring(backView.tag);
        
    }
    
    
}

@end
