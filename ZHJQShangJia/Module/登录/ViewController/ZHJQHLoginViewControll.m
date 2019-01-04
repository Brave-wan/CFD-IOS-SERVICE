//
//  ZHJQHLoginViewControll.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHLoginViewControll.h"

#import "ZHJQHRegistViewController.h" //注册

#import "ZHJQHForgetViewController.h" //忘记密码

#import "ZHJQHRegistrationBusinessViewController.h"


@interface ZHJQHLoginViewControll ()<UIScrollViewDelegate>

{
    
    UITextField * _telephotoField;
    
    UITextField * _passwordField;
    
    UIView * _vc;
    
    UIPageControl * pageControl;
    
    UIScrollView * scrollVie;
    
}

@end

@implementation ZHJQHLoginViewControll

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
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
       
        scrollVie=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        
        scrollVie.delegate =self;
        
        
        scrollVie.pagingEnabled=YES;
        
        NSMutableArray * arr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"商家端引导页1_2208.jpg"],[UIImage imageNamed:@"商家端引导页2_2208.jpg"],[UIImage imageNamed:@"商家端引导页3_2208.jpg"], nil];
        
        for(int i = 0 ; i < 3 ; i ++){
            
            UIImageView  * ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            ImageView.image = arr[i];
            
            [scrollVie addSubview:ImageView];
            
            if(i == 2){
                scrollVie.userInteractionEnabled = true;
                
                ImageView.userInteractionEnabled = true;
                
                UIButton * buuton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH /2 - 558/3/2), SCREEN_HEIGHT - 2 * (170/3), 558/3, 170/3)];
                
                [buuton setImage:[UIImage imageNamed:@"shangjia_anniu"] forState:UIControlStateNormal];
                
                [buuton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                
                [ImageView addSubview:buuton];
                
                
                
            }
            
        }
        
        [SHARE_APP addView:scrollVie];
        
        
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 20)];
        pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        
        pageControl.numberOfPages = 3;
        
        [SHARE_APP addPage: pageControl];
        
        scrollVie.showsHorizontalScrollIndicator = false;
        
        scrollVie.showsVerticalScrollIndicator = false;
        
        [scrollVie setContentSize:CGSizeMake(SCREEN_WIDTH * 3,  SCREEN_HEIGHT)];
        
        scrollVie.bounces = false;
        
        
    }
    
  
    
    [self setUI];
    
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x / bounds.size.width];
   
}
-(void)buttonclick:(UIButton *)sender{
    
    [SHARE_APP remoPage:pageControl];
    
    [SHARE_APP remoView:scrollVie];
    
}

- (void)setUI {
    
    //设置背景图片
    UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    bottomView.image = [UIImage imageNamed:@"登录背景图片"];
    
    [self.view addSubview:bottomView];
//标题
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 30, 30, 60, 30)];
    
    title.text      = @"登录";
    
    title.textColor = [UIColor whiteColor];
    
    title.font      = [UIFont systemFontOfSize:20];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:title];
    
    //账号密码
    _telephotoField = [[UITextField alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2 - 150, SCREEN_WIDTH - 40, 20)];
    
    _telephotoField.placeholder = @"请输入手机号";
    
    _telephotoField.tintColor = [UIColor whiteColor];
    
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
    
    [self.view addSubview:_telephotoField];
    
    UIView * viewLine = [[UIView alloc] initWithFrame:CGRectMake(20, _telephotoField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine];
    
    //密码
    //账号密码
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, viewLine.frame.origin.y + 30, SCREEN_WIDTH - 40, 20)];
    
    _passwordField.placeholder = @"请输入密码";
    
    _passwordField.tintColor = [UIColor whiteColor];
    
    _passwordField.secureTextEntry = true;
    
    UIView * rightPass = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton * imagePass = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    
    [imagePass setImage:[UIImage imageNamed:@"白色密码锁"] forState:UIControlStateNormal];
    
    rightPass.userInteractionEnabled = imagePass.userInteractionEnabled = true;
    
    [rightPass addSubview:imagePass];
    
    _passwordField.leftView = rightPass;
    
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    [_passwordField setValue:COLOR(166, 209, 242, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_passwordField setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    _passwordField.textColor = [UIColor whiteColor];
    
    [self.view addSubview:_passwordField];
    
    UIView * viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(20, _passwordField.frame.origin.y + 30, SCREEN_WIDTH - 40, 1)];
    
    viewLine1.backgroundColor = COLOR(209, 215, 229, 1);
    
    [self.view addSubview:viewLine1];

    UIButton * registBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    registBotton.frame = CGRectMake(_passwordField.frame.origin.x, viewLine1.frame.origin.y + 30, 100, 25);
    
    [registBotton setTitle:@"立即注册" forState:UIControlStateNormal];
    
    [registBotton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [registBotton addTarget:self action:@selector(registBottonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    registBotton.tag = 2;
    
    [self.view addSubview:registBotton];
    

    UIButton * forgetPassWordBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    forgetPassWordBotton.frame = CGRectMake(_passwordField.frame.origin.x + _passwordField.frame.size.width - 100, viewLine1.frame.origin.y + 30, 100, 25);
    
    [forgetPassWordBotton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    
    [forgetPassWordBotton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [forgetPassWordBotton addTarget:self action:@selector(registBottonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    forgetPassWordBotton.tag = 3;
    
    [self.view addSubview:forgetPassWordBotton];

    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    loginButton.frame = CGRectMake(_passwordField.frame.origin.x, forgetPassWordBotton.frame.origin.y + 80 + 30, _passwordField.frame.size.width, 50);
    
    [loginButton setTitle:@"商家登录" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"登录白色圆角框"] forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(registBottonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    loginButton.tag = 4;
    
    [self.view addSubview:loginButton];

    
}
//注册
- (void)registBottonClick:(id)sender {

    UIButton * butt = (UIButton *)sender;
    
    switch (butt.tag) {
        case 2:
        {
            //注册
            ZHJQHRegistViewController * registVC = [[ZHJQHRegistViewController alloc] init];
            
            [self.navigationController pushViewController:registVC animated:YES];
            
        }
            break;
        case 3:
        {
            //忘记密码
            
            ZHJQHForgetViewController  * forgetVC = [[ZHJQHForgetViewController alloc] init];
            
            [self.navigationController pushViewController:forgetVC animated:YES];
            
        }
            break;
        case 4:
        {
            //登录
            
            if([_telephotoField.text isEqualToString:@""]){
                
                [self MBShow:@"电话为空" backview:self.view];
                
            }else if([_passwordField.text isEqualToString:@""]){
                
                 [self MBShow:@"密码为空" backview:self.view];
                
            }else {
                
                [self login:_telephotoField.text passWord:_passwordField.text];
 
            }
            
            
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark 登录的点击事件
/**
 *  登录的点击事件
 *
 *  @param telString  手机号
 *  @param passString 密码
 */
-(void)login:(NSString *)telString  passWord:(NSString *)passString{
    
    // 网络请求   传入的值 用来判断 是 商户， 饭店 ， 酒店的标示
    // 登录后填写注册信息
 
    
    if([[self valiMobile:telString] isEqualToString:@""] && ![passString isEqualToString:@""]){
        
        if([passString isEqualToString:@""]){
            
            [self login:telString passWord:passString];
            
        }else{
            
            [self longinRequset:telString passWord:passString];

        }
        
        
    }else{
        
        
        [self MBShow:[self valiMobile:telString] backview:self.view];
        
    }
    
    
    
    
   /*
    if ([self.delegate respondsToSelector:@selector(chooseRootViewController:)]) {
        
        [self.delegate chooseRootViewController:_telephotoField.text];
        
    }
*/
}

#pragma mark 请求的方法 1.注册成功后没有实名认证 2.实名认证审核中 3 实名认证未通过审核 4.实名认证通过审核
/**
 *  请求的方法 1.注册成功后没有实名认证 2.实名认证审核中 3 实名认证未通过审核 4.实名认证通过审核
 *
 *  @param telString 电话号
 *  @param password  密码
 */
-(void)longinRequset:(NSString *)telString passWord:(NSString * )password{
    
    [self MBPhudShow];
    
    NSDictionary * dic = @{@"telPhone":telString , @"passWord":password};
    
    [ZHJQHttpToll GET:LPCLOGINURL parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

     //   NSString * string = [dic JSONString];
        
        
        if([[self headdic:dic] isEqualToString:@"0"]){
        
            [self MBhudhud];// shopmessage
            
            LPCloginModel * model = [LPCloginModel yy_modelWithJSON:dic];
            
            NSString *str = [NSString stringWithFormat:@"%lld",model.data.userId];
            
            [SHARE_APP jPushtags:str];
            
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:str forKey:@"USERID"];
            
            [user setObject:model.data.token forKey:@"TOKEN"];
            
            [user synchronize];
            
            if(model.data.state == 0){
                
                
                [self showHint:@"审核中,请稍候登录"];
                
            }else if (model.data.state == 2 ){
                
                [self showHint:@"审核失败,请重新填写"];
                
                [self user:model];
                
                
                [self pushViewController];
                
            }else if (model.data.state == 1){
                
                
                [self user:model];
                
                NSUserDefaults  * user =  [NSUserDefaults standardUserDefaults];
                
                [user setObject:model.data.shopMessge.shopId forKey:@"shopId"];
                
                [user synchronize];
                
                if ([self.delegate respondsToSelector:@selector(chooseRootViewController:)]) {
                    // 1 酒店 3特产 2 饭店 4 小吃
                    [self.delegate chooseRootViewController:model.data.shopMessge.shopId];

                }
                
            }else if (model.data.state == 6){
                
                
                [self pushViewController];
                
            }else if(model.data.state == 4){
                
                 [self showHint:@"您尚未注册"];
                
            }
    
            
        }else{
            
            [self MBShow:[self head:dic] backview:self.view];
            
        }
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙,请稍后在尝试" backview:self.view];
        
    }];
    
}
#pragma mark 存储上次提交的数据
-(void)user:(LPCloginModel *)model{
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:[NSString stringWithFormat:@"%lld",model.data.shopMessge.ID] forKey:@"Shop_id_LPC"];
    

    [user setObject: model.data.shopMessge.realName forKey:@"name"];
    
    [user setObject: model.data.shopMessge.sex forKey:@"sex"];
    
    [user setObject: model.data.shopMessge.idCard forKey:@"code"];
    
    [user setObject: model.data.shopMessge.holdCardImg forKey:@"IDCARD"];

    [user setObject: model.data.shopMessge.faceCardImg forKey:@"IDCARDYES"];
    
    [user setObject: model.data.shopMessge.backCardImg forKey:@"IDCARDNO"];

    [user setObject: model.data.shopMessge.licenseImg forKey:@"yingyezhizhao"];
    
    [user setObject: model.data.shopMessge.otherImg1 forKey:@"zhengshu"];
    
    [user setObject: model.data.shopMessge.otherImg2 forKey:@"zhengshuqita"];

    [user setObject:model.data.shopMessge.name forKey:@"shangjianame"];
    
    if([model.data.shopMessge.shopId  isEqualToString:@"1"]){
        
        [user setObject:@"酒店" forKey:@"dianpuleixing"];
        
    }else if([model.data.shopMessge.name  isEqualToString:@"2"]){
        
        [user setObject:@"特产" forKey:@"dianpuleixing"];
        
    }else if([model.data.shopMessge.name  isEqualToString:@"3"]){
        
        [user setObject:@"饭店" forKey:@"dianpuleixing"];
        
    }else if([model.data.shopMessge.name  isEqualToString:@"4"]){
        
        [user setObject:@"小吃" forKey:@"dianpuleixing"];
        
    }
    
    
    [user setObject:model.data.shopMessge.businessScope forKey:@"jingyingchanpin"];
    
    
    if([model.data.shopMessge.accountType  isEqualToString:@"0"]){
        
        [user setObject:@"对公" forKey:@"zhanghaoleixing"];

    }else{
        
         [user setObject:@"个人" forKey:@"zhanghaoleixing"];
        
    }
  
    [user setObject:model.data.shopMessge.accountName forKey:@"zhanghumingcheng"];
    
    [user setObject:model.data.shopMessge.bankCard forKey:@"yihangzhanghu"];
    
    [user setObject:model.data.shopMessge.accountBank forKey:@"kaihuahang"];
    
    
    
    if([model.data.shopMessge.isLicense  isEqualToString:@"0"]){
        

        [user setObject:@"否" forKey:@"shifouyouyingyezhizhaobiaoshi"];
        
    }else{
        
        [user setObject:@"是" forKey:@"shifouyouyingyezhizhaobiaoshi"];
        
    }
    
    [user synchronize];
    
    
}
#pragma mark 审核失败 以及 没有填写审核信息
-(void)pushViewController{
    
    ZHJQHRegistrationBusinessViewController  * ViewController = [[ZHJQHRegistrationBusinessViewController alloc]init];
    
    [self.navigationController pushViewController:ViewController animated:true];
    
}
-(NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11 && mobile.length > 0)
    {
        return @"手机号长度只能是11位";
        
    } if(mobile.length ==0 ){
        
        return @"请输入手机号";
        
        
    }else{
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        
        return [regextestmobile evaluateWithObject:mobile]? @"":@"请输入正确的手机号码";
    }
    return @"";
}
@end





