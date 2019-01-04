//
//  LPCResinDelegateViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCResinDelegateViewController.h"

@interface LPCResinDelegateViewController ()

@property (nonatomic ,strong) UIWebView  * webView;

@end

@implementation LPCResinDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"注册协议"];
    
    [self left];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey: UITextAttributeTextColor];
    //UITextAttributeTextColor
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
    
    [_webView setScalesPageToFit:YES];
    
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
