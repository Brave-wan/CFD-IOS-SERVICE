//
//  LPCSearchResultViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSearchResultViewController.h"

@interface LPCSearchResultViewController (){
    
    LPCCustomAlertView  * alert;
}

@property (nonatomic ,strong) UIImageView * backImage;

@property (nonatomic ,strong) UIImageView * headImage;

@property (nonatomic ,strong) UILabel * name_label;

@property (nonatomic ,strong) UILabel * yu;


@end

@implementation LPCSearchResultViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  0 基本设置
    [self nav_title:@"代理充值"];
    
    [self left];
    
    //  1 页面布局
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)creatUI{
    
    _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 174)];
    
    _backImage.image = [UIImage imageNamed:@"d19_bejjing"];
    
    [self.view addSubview:_backImage];

    
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 161/3/2, 20, 161/3, 163/3)];
    
    _headImage.image = [UIImage imageNamed:@"d19_touxaing"];
    
    [self.view addSubview:_headImage];
    
    
    
    _name_label = [[UILabel alloc]initWithFrame:CGRectMake(0, _headImage.frame.origin.y + _headImage.frame.size.height + 10, SCREEN_WIDTH, 30)];
    
    _name_label.textAlignment = NSTextAlignmentCenter;
    
    _name_label.text = @"爱旅行的小疯子";
    
    _name_label.textColor = [UIColor whiteColor];
    
    _name_label.font = [UIFont systemFontOfSize:_name_label.font.pointSize - 2];
    
    [self.view addSubview:_name_label];
    
    
    _yu = [[UILabel alloc]initWithFrame:CGRectMake(0, _backImage.frame.size.height - 40, SCREEN_WIDTH, 40)];
    
    _yu.textColor = [UIColor whiteColor];
    
    _yu.textAlignment = NSTextAlignmentCenter;
    
    _yu.text = @"当前余额 : ￥1000";

    [self.view addSubview:_yu];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 -50, _backImage.frame.size.height + 30, 100, 35)];
    
    [button setBackgroundColor:COLOR(0, 150, 224, 1)];
    
    [button setTitle:@"充值" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.masksToBounds = true;
    
    button.layer.cornerRadius = 8;
    
    [button addTarget:self action:@selector(button_click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}
#pragma mark 充值
-(void)button_click{
    
    UIColor * color = COLOR(255, 63, 81, 1);
    
    alert = [[LPCCustomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) place:@"请输入金额" title:@"充值" color:color    string:@"1" view:self.view];
    
    __weak typeof(self) weakself =  self;
    
    alert.ShowNum = ^(NSString *string , NSString * numstring){
        
        if([numstring isEqualToString:@""] || [numstring isEqualToString:@"(null)"] || [numstring isEqualToString:@"<null>"]){
            
            
            
        }else{
            
            [weakself queren:numstring];
        }
        
    };
    
    
    [alert alertViewShow];
    
    
}
#pragma mark 确认充值
-(void)queren:(NSString *)numstring{
    
    
    UIColor * color = COLOR(255, 63, 81, 1);

    
    
    
   LPCAlert * alerta = [[LPCAlert alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) place:numstring color:color viu:self.view];
    
    alerta.Showstring = ^(NSString * string){
      
        if([string isEqualToString:@"确定"]){
            
            [self alertshow];
            
        }
        
        
    };
    
    [alerta alertShow];

   
}
 -(void)alertshow{
                                       
     UIAlertView * view = [[UIAlertView alloc]initWithTitle:@"" message:@"充值成功" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
     
     [view show];
     
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
