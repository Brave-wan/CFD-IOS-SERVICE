//
//  LPCDLCZViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCDLCZViewController.h"

@interface LPCDLCZViewController ()

//搜索框
@property (nonatomic ,strong) LPCCustomTextFild * searchtextfild;

@end

@implementation LPCDLCZViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // 0 基本设置
    [self nav_title:@"代理充值"];
    
    [self left];
    
    [self backColor:BACKCOLOR];
    
    // 1 布局
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}
#pragma mark 页面布局
-(void)Creat_UI{
    
    _searchtextfild  =[[LPCCustomTextFild alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 30)];
    
    _searchtextfild.placeholder = @"请输入手机号";
    
    [_searchtextfild setValue:[UIFont boldSystemFontOfSize:_searchtextfild.font.pointSize - 4] forKeyPath:@"_placeholderLabel.font"];
    
    _searchtextfild.layer.masksToBounds = true;
    
    _searchtextfild.layer.borderWidth = .6;
    
    _searchtextfild.backgroundColor = [UIColor whiteColor];
    
    UIView * view__ = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    _searchtextfild.leftView   = view__;
    
    _searchtextfild.leftViewMode = UITextFieldViewModeAlways;
    
    _searchtextfild.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [self.view addSubview:_searchtextfild];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, _searchtextfild.frame.origin.y + _searchtextfild.frame.size.height + 30, SCREEN_WIDTH-20, 30)];
    
    [button setTitle:@"查询" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:COLOR(252, 62, 80, 1)];
    
    button.layer.masksToBounds = true;
    
    button.layer.cornerRadius = 7;
    
    [button addTarget:self action:@selector(searchBar_click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

#pragma mark 查询
-(void)searchBar_click{
    
    LPCSearchResultViewController * viewcontroller = [[LPCSearchResultViewController alloc]init];
    
    [self push:viewcontroller];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
