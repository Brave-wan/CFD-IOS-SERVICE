//
//  LPCSegemView.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/3.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSegemView.h"

@implementation LPCSegemView

-(id)initWithFrame:(CGRect)frame name:(NSMutableArray *)name{
    
    if(self = [super initWithFrame:frame]){
        
        _dataSourceArr = name;
        
        _title_numLabelArr = [NSMutableArray array];
        
        _label_dataSoureArr = [NSMutableArray array];
        
        self.backgroundColor = COLOR(237, 243, 249, 1);
        
        for(int i = 10 ; i < _dataSourceArr.count + 10 ; i ++){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((i - 10) * (self.frame.size.width/_dataSourceArr.count), 0, self.frame.size.width/_dataSourceArr.count-1, frame.size.height)];
            
            label.textAlignment = NSTextAlignmentCenter ;
            
            label.text = _dataSourceArr[i-10];
            
         
            
            if(i == 10){
                
                label.textColor = COLOR(239, 61, 76, 1);
                
            }
            
            label.backgroundColor = [UIColor whiteColor];
            
            label.tag = i ;
            
            label.userInteractionEnabled = self.userInteractionEnabled = true;
            
            UITapGestureRecognizer* singleRecognizer;
            
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
            
            singleRecognizer.numberOfTapsRequired = 1;
            
            [label addGestureRecognizer:singleRecognizer];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
            
            [self addSubview:label];
            
            
            // 角标集合
            
            UILabel * bageLabel = [[UILabel  alloc]initWithFrame:CGRectMake(label.frame.origin.x + label.frame.size.width - 30, 5, 25, 15)];
            
            bageLabel.textColor = [UIColor whiteColor];
            
            bageLabel.textAlignment = NSTextAlignmentCenter;
            
            bageLabel.clipsToBounds = true;
            
            bageLabel.layer.cornerRadius = 7.5;
            
            bageLabel.font = [UIFont systemFontOfSize:bageLabel.font.pointSize - 3];
            
            [_label_dataSoureArr addObject:bageLabel];
            
            [self addSubview:bageLabel];
            
            
        }
        
        _hengLabel = [[UILabel alloc]initWithFrame:CGRectMake( self.frame.size.width/_dataSourceArr.count - self.frame.size.width/_dataSourceArr.count/2 - self.frame.size.width/_dataSourceArr.count/2/2, self.frame.size.height - 1.5, SCREEN_WIDTH/_dataSourceArr.count/2, 1.5)];
        
        _hengLabel.backgroundColor = COLOR(239, 61, 76, 1);
        
        [self addSubview:_hengLabel];
        
        
    }
    
    return self;
    
}



-(void)handleSingleTapFrom:(UITapGestureRecognizer *)faly{
    
    UILabel * label = (UILabel *)faly.view;
    
    label.textColor = COLOR(239, 61, 76, 1);
    
    for(int i  = 10 ; i < _dataSourceArr.count + 10; i ++){
        
        UILabel * otherLabel = (UILabel *)[self viewWithTag:i];
        
        if([otherLabel isEqual:label]){
            
            otherLabel.textColor = COLOR(239, 61, 76, 1);
            
        }else{
            
            otherLabel.textColor = [UIColor blackColor];
        }
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = label.frame;
        
        CGRect hframe = _hengLabel.frame;
        
        hframe.origin.x = frame.origin.x + frame.size.width/4;
        
        _hengLabel.frame = hframe;
        
        
    }];
    
    if([self.delegate respondsToSelector:@selector(index:type:)]){
        
        [self.delegate index:label.tag -10 type:label.text];
        
    }
    
}


-(void)setTitle_numLabelArr:(NSMutableArray *)title_numLabelArr{
    
    _title_numLabelArr = title_numLabelArr;
    
    if(_title_numLabelArr.count == _label_dataSoureArr.count){
        
        for (int i = 0 ; i < _title_numLabelArr.count; i ++) {
            
            UILabel * label = _label_dataSoureArr[i];

            label.backgroundColor = [UIColor redColor];
            
            label.textColor = [UIColor whiteColor];
            
            label.text =[NSString stringWithFormat:@"%@",[_title_numLabelArr objectAtIndex:i]];
            
            if([label.text  isEqualToString:@""] || [label.text  isEqualToString:@"0"]){
                
                label.backgroundColor = [UIColor clearColor];


            }
            
        }
        
    }
    
    return ;
    
}

@end
