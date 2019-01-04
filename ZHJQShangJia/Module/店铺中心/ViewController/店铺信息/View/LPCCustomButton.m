//
//  LPCCustomButton.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCCustomButton.h"

@implementation LPCCustomButton

-(id)initWithFrame:(CGRect)frame image:(UIImage *)image string:(NSString *)string{
    
    if(self = [super initWithFrame:frame]){
        
        
        [self setImage:image forState:UIControlStateNormal];
        
       
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self setTitle:string forState:UIControlStateNormal];
        
    }
    
    return self;
    
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2 + 5;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 10;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    
    self.titleLabel.textAlignment =  NSTextAlignmentCenter;
}
@end
