//
//  LPCSetingViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSetingViewController.h"
#import "AppDelegate.h"


@interface LPCSetingViewController ()

@end

@implementation LPCSetingViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0 基本设置
    [self nav_title:@"设置"];
    
    [self left];
    
    // 1 页面布局
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}
-(void)Creat_UI{
    
    if(!_TableView ){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.frame.size.height - State_HEIGHT)];
        
        _TableView.dataSource = self;
        
        _TableView.delegate = self;
        
        _TableView.tableFooterView = [[UIView alloc]init];
        
        _TableView.backgroundColor = COLOR(237, 243, 248, 1);
        
        [self.view addSubview:_TableView];
        
        _dataSourecArr = [NSMutableArray arrayWithObjects:@"修改密码",@"退出账号", nil];
        
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    // 0 基本设置
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    NSInteger  row =  indexPath.row ;
    
    cell.textLabel.text = _dataSourecArr[row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPCModifyPasswordViewController * PassviewController = [[LPCModifyPasswordViewController alloc]init];
    
    if(indexPath.row == 0){
        
        [self push:PassviewController];
        
    }if(indexPath.row == 1){
        
        UIColor * color = COLOR(0, 150, 224, 1);
       
        LPCCustomAlertView * alert = [[LPCCustomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) message:@"确定退出曹妃甸商家端?\n 再次进入需要登录,重新验证身份信息。" title:@"安全退出" color:color];
        
        alert.Showstring = ^(NSString *string){
            
            if([string isEqualToString:@"确定"]){
               
                [SHARE_APP removeUser];
                
                [SHARE_APP  jPushtags:@""];
                
                [SHARE_APP  chageViewController];
            }
            
        };
        
        [alert alertShow];
        
    }
   
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
