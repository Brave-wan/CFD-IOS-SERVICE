//
//  HBHSheetView.m
//  ZHJQShangJia
//
//  Created by APP on 16/7/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "HBHSheetView.h"

@interface HBHSheetView ()

@property (nonatomic, strong) NSMutableArray *stringArray;

@end

@implementation HBHSheetView

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = true;
        
        self.overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        self.overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        
        self.overlayView.userInteractionEnabled = true;
        
        [self.overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.overlayView];
        
        UIView *viewS = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40 * array.count, SCREEN_WIDTH, 40 * array.count + 10)];
        
        viewS.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:viewS];
        
        _stringArray = array;
        
        for (int i = 0; i < array.count; i ++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(-2, 40 * i, SCREEN_WIDTH + 4, 40);
            
            [button setTitle:array[i] forState:UIControlStateNormal];
            
            button.tag = i;
            
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH/2   + 100);
            
            [button addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setBackgroundColor:[UIColor whiteColor]];
            
            [button setTitleColor:[UIColor blackColor] forState:0];
            
            [viewS addSubview:button];

            ViewBorderRadius(button, 0, 0.5, [UIColor lightGrayColor]);
            
            
            UIImageView  * CornImage = [[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width - 50, 0, 40, 40)];
            
            CornImage.image = [UIImage imageNamed:@"dl4_quan"];
            
            CornImage.tag = 10 + i ;
            
            [button addSubview:CornImage];
            
            
        }
        
        
        
    }
        return self;
}
-(void)onCancleBtn
{
    
    [self dismiss];
    
}

-(void)show {
    
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    keywindow.userInteractionEnabled = true;
    
    [keywindow addSubview:self];
    
    [self fadeIn];
    
}

-(void)dismiss {
    
    [self fadeOut];
}

//弹入层
- (void)fadeIn
{
    
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        
        self.alpha = 1;
        
    }];
    
}

//弹出层
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self.overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)chooseClick:(id)sender {
    
    UIButton * butt = (UIButton *)sender;
    
    UIImageView * cornImage = (UIImageView *)[butt viewWithTag:10 + butt.tag];
    
    cornImage.image = [UIImage imageNamed:@"dl4_hongquan"];
    
    NSString * string = _stringArray[butt.tag];
    
    if (self.chooseBlock) {
        
        self.chooseBlock(string);
        
    }
    
    [self dismiss];
    
}


@end
