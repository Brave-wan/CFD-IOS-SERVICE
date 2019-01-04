//
//  LPCbugeSegmentView.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCbugeSegmentView.h"

@implementation LPCbugeSegmentView


-(id)initWithFrame:(CGRect)frame name:(NSMutableArray *)name{
    
    if(self = [super initWithFrame:frame]){
        
        _dataSourceArr = name;
        
        self.backgroundColor = COLOR(237, 243, 249, 1);
        
        for(int i = 10 ; i < _dataSourceArr.count + 10 ; i ++){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((i - 10) * (self.frame.size.width/_dataSourceArr.count), 0, self.frame.size.width/_dataSourceArr.count-.25, frame.size.height)];
            
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
            
            // 第一个
            if(i == 10){
                
                _bugeLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.size.width - 15, 6, 15, 15)];
                
                _bugeLabel.textColor = [UIColor whiteColor];
                
                _bugeLabel.layer.masksToBounds = true;
                
                _bugeLabel.textAlignment = NSTextAlignmentCenter;
            
                _bugeLabel.backgroundColor = [UIColor clearColor];
                
                _bugeLabel.layer.cornerRadius = 7.5;
                
                //_bugeLabel.adjustsFontSizeToFitWidth = true;
                
                _bugeLabel.text = @"";
                
                _bugeLabel.font = [UIFont systemFontOfSize:11];
                
                [self addSubview:_bugeLabel];
                
            }
            
            // 第二个
            if(i - 10  == 1){
                
                _bugeLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width - 15, 6, 15, 15)];
                
                _bugeLabel_one.textColor = [UIColor whiteColor];
                
                _bugeLabel_one.layer.masksToBounds = true;
                
                _bugeLabel_one.textAlignment = NSTextAlignmentCenter;
                
                _bugeLabel_one.backgroundColor = [UIColor clearColor];
                
                _bugeLabel_one.layer.cornerRadius = 7.5;
                
                //_bugeLabel.adjustsFontSizeToFitWidth = true;
                
                _bugeLabel_one.text = @"";
                
                _bugeLabel_one.font = [UIFont systemFontOfSize:11];
                
                [self addSubview:_bugeLabel_one];
                
            }
            
            // 第三个
            if(i - 10  == 2){
                
                _bugeLabel_two = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width - 15, 6, 15, 15)];
                
                _bugeLabel_two.textColor = [UIColor whiteColor];
                
                _bugeLabel_two.layer.masksToBounds = true;
                
                _bugeLabel_two.textAlignment = NSTextAlignmentCenter;
                
                _bugeLabel_two.backgroundColor = [UIColor clearColor];
                
                _bugeLabel_two.layer.cornerRadius = 7.5;
                
                //_bugeLabel.adjustsFontSizeToFitWidth = true;
                
                _bugeLabel_two.text = @"";
                
                _bugeLabel_two.font = [UIFont systemFontOfSize:11];
                
                [self addSubview:_bugeLabel_two];
                
            }
            
            // 第四个
            if(i - 10  == 3){
                
                _bugeLabel_three = [[UILabel alloc]initWithFrame:CGRectMake( label.frame.origin.x+label.frame.size.width - 15, 6, 15, 15)];
                
                _bugeLabel_three.textColor = [UIColor whiteColor];
                
                _bugeLabel_three.layer.masksToBounds = true;
                
                _bugeLabel_three.textAlignment = NSTextAlignmentCenter;
                
                _bugeLabel_three.backgroundColor = [UIColor clearColor];
                
                _bugeLabel_three.layer.cornerRadius = 7.5;
                
                //_bugeLabel.adjustsFontSizeToFitWidth = true;
                
                _bugeLabel_three.text = @"";
                
                _bugeLabel_three.font = [UIFont systemFontOfSize:11];
                
                [self addSubview:_bugeLabel_three];
                
            }
            
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
-(void)setBugeString:(NSString *)bugeString{
    
    _bugeString = bugeString;
    
    NSInteger  index = [bugeString integerValue];
    
    if(index > 99){
        
        _bugeLabel.text = @"99+";
        
        
        _bugeLabel.font = [UIFont systemFontOfSize:7];
        
        
    }else{
        
        _bugeLabel.text = bugeString;
        
        _bugeLabel.font = [UIFont systemFontOfSize:11];

        
    }
    
}
-(void)setBugeString_one:(NSString *)bugeString_one{
    
    _bugeString_one = bugeString_one;
    
    NSInteger  index = [bugeString_one integerValue];
    
    if(index > 99){
        
        _bugeLabel_one.text = @"99+";
        
        _bugeLabel_one.font = [UIFont systemFontOfSize:7];
        
        
    }else{
        
        _bugeLabel_one.text = bugeString_one;
        
        _bugeLabel_one.font = [UIFont systemFontOfSize:11];
        
        
    }
    
}

-(void)setBugeString_two:(NSString *)bugeString_two{
    
    _bugeString_two = bugeString_two;
    
    NSInteger  index = [bugeString_two integerValue];
    
    if(index > 99){
        
        _bugeLabel_two.text = @"99+";
        
        _bugeLabel_two.font = [UIFont systemFontOfSize:7];
        
        
    }else{
        
        _bugeLabel_two.text = bugeString_two;
        
        _bugeLabel_two.font = [UIFont systemFontOfSize:11];
        
        
    }
    
}

-(void)setBugeString_three:(NSString *)bugeString_three{
    
    _bugeString_three = bugeString_three;
    
    NSInteger  index = [bugeString_three integerValue];
    
    if(index > 99){
        
        _bugeLabel_three.text = @"99+";
        
        _bugeLabel_three.font = [UIFont systemFontOfSize:7];
        
        
    }else{
        
        _bugeLabel_three.text = bugeString_three;
        
        _bugeLabel_three.font = [UIFont systemFontOfSize:11];
        
        
    }
    
}

@end
