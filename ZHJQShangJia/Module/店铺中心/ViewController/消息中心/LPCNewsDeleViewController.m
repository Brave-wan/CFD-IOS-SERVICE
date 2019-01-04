//
//  LPCNewsDeleViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCNewsDeleViewController.h"

@interface LPCNewsDeleViewController ()

@end

@implementation LPCNewsDeleViewController

-(void)click_nav{
    
    if(_type_root == 1){
        
        // 切换跟试图
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        if([[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]]] isEqualToString:@""]){
            
            [SHARE_APP chageViewController];
            
        }else {
            
            [SHARE_APP  changeRootViewController:[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]]]];
            
        }

        
    }else {
        
        [self.navigationController popViewControllerAnimated:true];
        
    }
    
}
/**
 *  返回
 */
-(void)left_nav{
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"dl3_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(click_nav)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // 0 基本设置
    
    [self nav_title:@"消息中心"];
    
    [self left_nav];
    
    // 1 页面布局
    
    [self Creat_UI];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    // Do any additional setup after loading the view.
}
#pragma mark 界面布局
-(void)Creat_UI{
    
    NSString * string =@"";
    
    if([_type isEqualToString:@"1"]){
        
        string = [NSString stringWithFormat:@"%lld",_detaileID];
        
    }else {
        
        string  = [NSString stringWithFormat:@"%ld",(long)_model_row.detailId];
        
    }
    
    NSDictionary * dic = @{@"detailId":string};
    
    [ZHJQHttpToll GET:LPCNEWSXIANGQIYENGYE parameters:dic success:^(id responseObject) {
        
         NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if([self headdic:dic_json]){
            
            
            UIWebView * WebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
            
            NSString * path = [NSString stringWithFormat:@"%@",dic_json[@"data"]];
        
            NSURL *url = [NSURL URLWithString:path];
            
            WebView.scalesPageToFit = true;
            
            [WebView loadRequest:[NSURLRequest requestWithURL:url]];
            
            [self.view addSubview:WebView];
            
        }
        
        
    } failure:^(NSError *error) {
        
    
    }];
    
   
   

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
