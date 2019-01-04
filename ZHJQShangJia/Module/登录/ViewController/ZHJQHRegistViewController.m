//
//  ZHJQHRegistViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRegistViewController.h"
#import "ZHJQHRegistrationBusinessViewController.h"
#import "UIButton+CountDown.h"
#import "HBHSheetView.h"

@interface ZHJQHRegistViewController ()

{
    
    UITextField * _telephotoField;
    
    UITextField * _validationField;
    
    UITextField * _passField;
    
    UITextField * _passTwoField;
    
    
}

@end

@implementation ZHJQHRegistViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    
}

- (void)creatUI {
    
    //设置背景图片
    UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    bottomView.image = [UIImage imageNamed:@"登录背景图片"];
    
    [self.view addSubview:bottomView];
    
    //标题
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 30, 30, 60, 30)];
    
    title.text      = @"注册";
    
    title.textColor = [UIColor whiteColor];
    
    title.font      = [UIFont systemFontOfSize:20];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:title];
	
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(10, 20, 30, 30);
    
    [backButton setImage:[UIImage imageNamed:@"白色返回箭头"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    //手机号
    _telephotoField = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, SCREEN_WIDTH - 40, 20)];
    
    _telephotoField.placeholder = @"请输入手机号";
    
    _telephotoField.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView * right = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton * image = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    
    [image setImage:[UIImage imageNamed:@"白色账号"] forState:UIControlStateNormal];
    
    right.userInteractionEnabled = image.userInteractionEnabled = true;
    
    [right addSubview:image];
    
    _telephotoField.leftView = right;
    
    _telephotoField.leftViewMode = UITextFieldViewModeAlways;
    
    [_telephotoField setValue:COLOR(166, 209, 242, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_telephotoField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    _telephotoField.textColor = [UIColor whiteColor];
    
    _telephotoField.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:_telephotoField];
    
    UIView * viewLine = [[UIView alloc] initWithFrame:CGRectMake(20, _telephotoField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine];
    
    //验证码
    _validationField = [[UITextField alloc] initWithFrame:CGRectMake(20, viewLine.frame.origin.y + 30, SCREEN_WIDTH - 40 - 100 , 20)];
    
    _validationField.placeholder = @"请输入验证码";
    
    UIView * rightPass = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton * imagePass = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    
    [imagePass setImage:[UIImage imageNamed:@"注册的白色验证码"] forState:UIControlStateNormal];
    
    rightPass.userInteractionEnabled = imagePass.userInteractionEnabled = true;
    
    [rightPass addSubview:imagePass];
    
    _validationField.leftView = rightPass;
    
    _validationField.leftViewMode = UITextFieldViewModeAlways;
    
    [_validationField setValue:COLOR(166, 209, 242, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_validationField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    _validationField.textColor = [UIColor whiteColor];
    
    _validationField.tintColor = [UIColor whiteColor];
    
    [self.view addSubview:_validationField];
    
    UIButton * validationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    validationButton.frame = CGRectMake(_validationField.frame.origin.x + _validationField.frame.size.width, _validationField.frame.origin.y - 10, 100, 30);
    
    validationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [validationButton setBackgroundImage:[UIImage imageNamed:@"蓝色圆角底部图"] forState:UIControlStateNormal];
    
    validationButton.tag = 2;
    
    [validationButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [validationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [self.view addSubview:validationButton];
    
    UIView * viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(20, _validationField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine1.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine1];
    
    //输入密码
    _passField = [[UITextField alloc] initWithFrame:CGRectMake(20, viewLine1.frame.origin.y + 30, SCREEN_WIDTH - 40 - 100 , 20)];
    
    _passField.placeholder = @"请输入密码";
    
    _passField.secureTextEntry = true;
    
    UIView * right1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton * image1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    
    [image1 setImage:[UIImage imageNamed:@"白色密码锁"] forState:UIControlStateNormal];
    
    [image1 addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    right1.userInteractionEnabled = image1.userInteractionEnabled = true;
    
    [right1 addSubview:image1];
    
    _passField.leftView = right1;
    
    _passField.leftViewMode = UITextFieldViewModeAlways;
    
    [_passField setValue:COLOR(166, 209, 242, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_passField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    _passField.textColor = [UIColor whiteColor];
    
    _passField.tintColor = [UIColor whiteColor];

    
    [self.view addSubview:_passField];
    
    
    UIView * viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(20, _passField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine2.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine2];

    //确认密码
    _passTwoField = [[UITextField alloc] initWithFrame:CGRectMake(20, viewLine2.frame.origin.y + 30, SCREEN_WIDTH - 40 - 100 , 20)];
    
    _passTwoField.placeholder = @"请确认密码";
    
    _passTwoField.secureTextEntry = true;
    
    UIView * rightPas = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton * imagePas = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    
    [imagePas setImage:[UIImage imageNamed:@"白色密码锁"] forState:UIControlStateNormal];
    
    image1.tag = 2;
    
    rightPas.userInteractionEnabled = imagePas.userInteractionEnabled = true;
    
    [rightPas addSubview:imagePas];
    
    _passTwoField.leftView = rightPas;
    
    _passTwoField.leftViewMode = UITextFieldViewModeAlways;
    
    [_passTwoField setValue:COLOR(166, 209, 242, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_passTwoField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    _passTwoField.textColor = [UIColor whiteColor];
    
    _passTwoField.tintColor = [UIColor whiteColor];

    
    [self.view addSubview:_passTwoField];
    
    UIView * viewLine3 = [[UIView alloc] initWithFrame:CGRectMake(20, _passTwoField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine3.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine3];

    //选中协议button
    UIButton * buttonSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buttonSelect.frame = CGRectMake(_validationField.frame.origin.x, viewLine3.frame.origin.y + 20, 30, 30);
    
    buttonSelect.selected = true;
    
    [buttonSelect setBackgroundImage:[UIImage imageNamed:@"白色框"] forState:UIControlStateNormal];
    
    [buttonSelect setImage:[UIImage imageNamed:@"白色对勾"] forState:UIControlStateSelected];
    
    [buttonSelect addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonSelect.tag = 3;
    
    [self.view addSubview:buttonSelect];
    
    UIButton * registBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    registBotton.frame = CGRectMake(buttonSelect.frame.origin.x + buttonSelect.frame.size.width, buttonSelect.frame.origin.y, 200, 25);
    
    registBotton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [registBotton setTitle:@"同意《曹妃甸商家入驻协议》" forState:UIControlStateNormal];
    
    [registBotton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [registBotton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    registBotton.tag = 4;
    
    [self.view addSubview:registBotton];
    
    
    
    
    //提交注册信息按钮
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    loginButton.frame = CGRectMake(_passTwoField.frame.origin.x, registBotton.frame.origin.y + 80 + 30, SCREEN_WIDTH - 40, 50);
    
    [loginButton setTitle:@"申请注册商家" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"登录白色圆角框"] forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(registButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    loginButton.tag = 5;
    
    [self.view addSubview:loginButton];
    
    
    
    
}

- (void)backButtonClick {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)registButtonClick:(id)sender {
    //注册和选择协议
	
    UIButton * button = (UIButton *)sender;

    
    switch (button.tag) {
        case 2:
        {
            //获取验证码
            
            [_telephotoField resignFirstResponder];
            
            [self getCode:_telephotoField.text button:button];
            
        }
            break;
        case 3:
        {
            //选中协议
            button.selected = !button.selected;
            
            
            
        }
            break;

        case 4:
        {
            //查看协议
            
            LPCResinDelegateViewController * Viewcontroller = [[LPCResinDelegateViewController alloc]init];
            
            [self push:Viewcontroller];
            
            
        }
            break;
        case 5:
        {
            if([self registrationBusinessIsMeetTheConditions] == false)return;
            
          
            [self regisRequset];
            
            
        }
            break;

            
        default:
            break;
    }
    
    
}
#pragma mark 注册的接口
/**
 *  注册的接口方法
 */
-(void)regisRequset{
    
    [self MBPhudShow];
    
    NSDictionary * dic = @{@"telPhone":_telephotoField.text,@"passWord":_passField.text,@"checkcode":_validationField.text};
    
    [ZHJQHttpToll GET:LPCRESGIN parameters:dic success:^(id responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        
        if([[self headdic:dict] isEqualToString:@"0"]){
            
            [self MBShow:@"注册成功" backview:self.view];
            
            [self performSelector:@selector(pop) withObject:self afterDelay:1];
            
            
        }else {
            
            [self MBShow:[self head:dict] backview:self.view];
            
        }
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
   
    
}
#pragma mark pop 
-(void)pop{
    

    
       [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark 注册的修改
/*
 //申请注册商家
 ZHJQHRegistrationBusinessViewController * registrationBusiness = [[ZHJQHRegistrationBusinessViewController alloc] init];
 
 [self.navigationController pushViewController:registrationBusiness animated:YES];
 */
- (BOOL)registrationBusinessIsMeetTheConditions{
    
    // 判断电话
    if([self isMobile:_telephotoField.text] == false){
        
        [self MBShow:@"电话" backview:self.view];
        
        return false;
        
    }
    
    // 判断验证码
    if([_validationField.text isEqualToString:@""]){
        
        [self MBShow:@"验证码错误" backview:self.view];
        
        return false;
        
    }
    
    // 判断俩次密码
    if (![_passTwoField.text isEqualToString:_passField.text]) {
        
        //俩次密码不一致
        
        [self MBShow:@"俩次密码不一致" backview:self.view];
        
        return false;
        
    }
    
    return true;
}

- (void)alertViewWithString:(NSString *)string withCancelString:(NSString *)str detarmine:(NSString*)tring{
    
    NSMutableArray * array = [NSMutableArray array];
    
    if (string != nil) {
        
        [array addObject:string];
    }
    if (str != nil) {
        
        [array addObject:str];
    }
    
    if (tring != nil) {
        
        [array addObject:tring];
    }
    
    HBHSheetView * sheetView = [[HBHSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withArray:array];
    
    [sheetView setChooseBlock:^(NSString * string) {
        
        NSLog(@"%@",string);
        
    }];
    
    [sheetView show];
    
    
    
    
}

#pragma mark 获取验证码
-(void)getCode:(NSString *)telPhone button:(UIButton *)sender{
    
    // 获取验证码 接口()
    
    if([self  isMobile:telPhone] == true){
        
        //接口
        
        [self codeRequset:telPhone button:sender];
        
    }else{
        
        // 电话号 为空 或者 不正确 的处理
    
        [self MBShow:@"请确保手机号的正确性" backview:self.view];
        
    }
    
    
}
#pragma mark 获取验证码网络请求
/**
 *  获取验证码
 *
 *  @param phone_num 电话号码
 */
-(void)codeRequset:(NSString * )phone_num button:(UIButton *)sender{
    
    NSDictionary * PhoneDic =@{@"phone":phone_num};
    
    [self MBPhudShow];
    
    [ZHJQHttpToll GET:LPCCODE parameters:PhoneDic success:^(id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
       
        
        if([[self headdic:dic] isEqualToString:@"0"]){
            
            [self MBShow:@"获取成功" backview:self.view];
            
           
            [sender  setBackgroundImage:[UIImage imageNamed:@"灰色圆角底部图"] forState:0];
            
            
             [sender startWithTime:60 title:@"点击重新获取" countDownTitle:@"s" mainColor:nil countColor:nil];
            
        }else{
            
            [self MBShow:[self head:dic] backview:self.view];
            
        }
        
    } failure:^(NSError *error) {
        
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
- (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobileNumbel];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobileNumbel];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobileNumbel];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}
@end
