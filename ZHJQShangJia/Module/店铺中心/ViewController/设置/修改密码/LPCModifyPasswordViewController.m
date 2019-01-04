//
//  LPCModifyPasswordViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCModifyPasswordViewController.h"
#import "LPCModifPassWordModel.h"



@interface LPCModifyPasswordViewController ()

@property (nonatomic ,strong) UITextField * oldtextFild;

@property (nonatomic ,strong) UITextField * newtextFild;

@property (nonatomic ,strong) UITextField * agintextFild;


@end

@implementation LPCModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0 基本设置
    [self nav_title:@"修改密码"];
    
    [self backColor:BACKCOLOR];
    
    [self left];
    
    // 1. 页面布局
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}
#pragma mark 页面布局
-(void)Creat_UI{
    
    _oldtextFild = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH -20, 30)];
    
    _oldtextFild.placeholder = @"请输入当前密码";
    
    _oldtextFild.layer.borderWidth = .5f;
    
    _oldtextFild.font = [UIFont systemFontOfSize:_oldtextFild.font.pointSize - 3];
    
    _oldtextFild.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:_oldtextFild];
    
    
    _newtextFild = [[UITextField alloc]initWithFrame:CGRectMake(10, _oldtextFild.frame.origin.y + _oldtextFild.frame.size.height + 15, SCREEN_WIDTH -20, 30)];
    
    _newtextFild.placeholder = @"请输入新密码";
    
    _newtextFild.layer.borderWidth = .5f;
    
    _newtextFild.font = [UIFont systemFontOfSize:_newtextFild.font.pointSize - 3];
    
    _newtextFild.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:_newtextFild];
    
    
    _agintextFild = [[UITextField alloc]initWithFrame:CGRectMake(10, _newtextFild.frame.origin.y + _newtextFild.frame.size.height + 15, SCREEN_WIDTH -20, 30)];
    
    _agintextFild.placeholder = @"再次输入新密码";
    
    _agintextFild.layer.borderWidth = .5f;
    
    _agintextFild.font = [UIFont systemFontOfSize:_agintextFild.font.pointSize - 3];
    
    _agintextFild.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:_agintextFild];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    _oldtextFild.leftView   = view;
    
    _oldtextFild.leftViewMode = UITextFieldViewModeAlways;

    
    UIView * view_ = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    _newtextFild.leftView   = view_;
    
    _newtextFild.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView * view__ = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    
    _agintextFild.leftView   = view__;
    
    _agintextFild.leftViewMode = UITextFieldViewModeAlways;
    
    _oldtextFild.backgroundColor = _newtextFild.backgroundColor = _agintextFild.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, _agintextFild.frame.origin.y + _agintextFild.frame.size.height + 20, SCREEN_WIDTH -20, 30)];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitle:@"确认修改" forState:UIControlStateNormal];
    
    button.backgroundColor = COLOR(255, 63, 81, 1);
    
    button.layer.masksToBounds = true;
    
    button.layer.cornerRadius = 7;
    
    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    _oldtextFild.secureTextEntry = true;

    _newtextFild.secureTextEntry = true;
    
    _agintextFild.secureTextEntry = true;

}

#pragma mark 确认修改的点击事件
-(void)buttonclick{
    
    if(_oldtextFild.text.length == 0){
        
        [self MBShow:@"请输入旧密码" backview:self.view];
        
        return;
        
    }
    
    if(![_newtextFild.text isEqualToString:_agintextFild.text ] || _newtextFild.text.length == 0 || _agintextFild.text.length == 0){
        
        
        [self MBShow:@"俩次密码不一致" backview:self.view];
        
        return;
        
    }
    
    [SHARE_APP showHud];
    
    NSDictionary * dict = @{@"oldPassWord":_oldtextFild.text ,@"newPassWord":_agintextFild.text};
    
    [ZHJQHttpToll GET:LPCRESETPASSWORD parameters:dict success:^(id responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCModifPassWordModel * model = [LPCModifPassWordModel yy_modelWithJSON:dict];
        
        if(model.header.status == 0){
            
            [self MBShow:@"修改成功" backview:self.view];
            
            
            [self performSelector:@selector(change) withObject:self afterDelay:1];

            return ;
        }
        
        [self MBShow:[self head:dic] backview:self.view];
        
        
    } failure:^(NSError *error) {
    
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
#pragma mark 重新登录
-(void)change{
    [SHARE_APP removeUser];
    
    [SHARE_APP  chageViewController];
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
