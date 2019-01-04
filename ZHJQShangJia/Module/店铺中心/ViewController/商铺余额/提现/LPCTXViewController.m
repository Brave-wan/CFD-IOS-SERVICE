//
//  LPCTXViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCTXViewController.h"

@interface LPCTXViewController ()<UITextFieldDelegate>{
    
    UITextField  * textFild_num;
}

@end

@implementation LPCTXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self left];
    
    [self nav_title:@"提现"];
    
    self.view.backgroundColor = COLOR(237, 243, 248, 1);
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}

#pragma mark 创建视图
-(void)Creat_UI{
    
    textFild_num = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH -20, 30)];
    
    textFild_num.placeholder = @"请输入提现金额";
    
    textFild_num.layer.borderWidth = .5f;
    
    textFild_num.delegate = self;
    
    textFild_num.keyboardType = UIKeyboardTypeNumberPad;
    
    textFild_num.font = [UIFont systemFontOfSize:textFild_num.font.pointSize - 3];
    
    textFild_num.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [textFild_num addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    
    [self.view addSubview:textFild_num];
    
    
    
    UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    view.text = @"金额";
    
    view.font = [UIFont systemFontOfSize:view.font.pointSize - 6];
    
    view.textAlignment = NSTextAlignmentCenter;
    
    view.textColor = [UIColor blackColor];
    
    textFild_num.leftView   = view;
    
    textFild_num.leftViewMode = UITextFieldViewModeAlways;
    

    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, textFild_num.frame.size.height + textFild_num.frame.origin.y + 20, textFild_num.frame.size.width, 40)];
    
    button.backgroundColor = COLOR(252, 65, 80, 1);
    
    button.layer.cornerRadius = 5;
    
    [button addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"提  现" forState:0];
    
    [button setTitleColor:[UIColor whiteColor] forState:0];
    
    [self.view addSubview:button];
    
}

-(void)valueChanged:(UITextField * )text{
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if(range.location ==0.00){
        
        if([string isEqualToString:@"0"]){
            
            [self MBShow:@"请输入正确的数值" backview:self.view];
            
            
            return  false;
            
        }
        
    }
    
    
    return YES;
}
-(void)tixian{
    
    NSString * strng = [NSString stringWithFormat:@"确认提现￥ %@ ?",textFild_num.text];
    
    if([textFild_num.text isEqualToString:@""]){
        
        [self MBShow:@"请输入金额" backview:self.view];
        
        return ;
        
    }
    NSString * fisrt_string = [textFild_num.text substringToIndex:1];
    
    if([fisrt_string isEqualToString:@"0"]){
        
        [self MBShow:@"请输入金额" backview:self.view];
        
        return ;
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入密码" message:strng preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入支付密码";
        
        [textField  setSecureTextEntry:true];
        
        _textfild_pass = textField;
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        // 确认提现
        
        if([_textfild_pass.text isEqualToString:@""]){
            
            [self MBShow:@"请输入支付密码" backview:self.view];
            
        }
        
       
        [self Creat_requset:[[textFild_num text] integerValue]];
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
    

    
}
#pragma mark 确认提现
-(void)Creat_requset:(NSInteger)index{
    
    
    if([_string_num isEqualToString:@""] ||[_string_num isEqualToString:@"(null)"]|| [_string_num isEqualToString:@"<null>"]){
        
        [self MBShow:@"暂时没有余额" backview:self.view];
        
        return;
        
    }
    
    NSInteger num =  [_string_num integerValue];
    
    NSInteger tinum = [textFild_num.text integerValue];
    
    if(num < tinum){
        
        [self MBShow:@"余额不足" backview:self.view];
        
        return;
        
    }
    
    
    if([_textfild_pass.text isEqualToString:@""]){
        
        [self MBShow:@"请输入支付密码" backview:self.view];
        
        return;
        
    }
    [SHARE_APP showHud];
    
    NSDictionary *dic = @{@"passWord":_textfild_pass.text ,@"balance":textFild_num.text};
    
    [ZHJQHttpToll  GET:LPCSHANGJIATIXIAN parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        NSLog(@"%@",dic_json);
        
        if ([[self headdic:dic_json] isEqualToString:@"0"]) {
            
            [self MBShow:@"提现成功" backview:self.view];

            [self performSelector:@selector(next) withObject:self afterDelay:0.5];
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];

    
}

-(void)next{
    
    
    if([self.object respondsToSelector:@selector(tixianhuitiao)]){
        
        [self.object tixianhuitiao];
        
        [self.navigationController popViewControllerAnimated:true];
    }
    
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
