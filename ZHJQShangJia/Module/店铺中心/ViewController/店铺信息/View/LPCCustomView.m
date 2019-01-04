//
//  LPCCustomView.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCCustomView.h"

@implementation LPCCustomView

-(id)initWithFrame:(CGRect)frame images:(NSMutableArray *)images string:(NSMutableArray *)strings{
    
    if(self = [super initWithFrame:frame]){
        
        for (int i = 0 ; i < images.count ; i ++) {
            
            LPCCustomButton * button = [[LPCCustomButton alloc]initWithFrame:CGRectMake( i *self.frame.size.width/images.count , 0, self.frame.size.width/images.count, self.frame.size.height) image:images[i] string:strings[i]];
            
            [self addSubview:button];
            
            
        }
        
    }
    
    return self;
    
}

@end
