//
//  LPCCustomTextFild.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/3.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCCustomTextFild.h"

@implementation LPCCustomTextFild

-(id)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        
        
    }
    
    return self;
    
}

- (void)drawPlaceholderInRect:(CGRect)rect {

    [super drawPlaceholderInRect:CGRectMake(0, self.frame.size.height * 0.5 - 1, 0, 0)];

}

@end
