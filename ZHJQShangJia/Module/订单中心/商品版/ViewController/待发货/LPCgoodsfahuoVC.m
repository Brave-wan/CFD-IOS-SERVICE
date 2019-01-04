//
//  LPCgoodsfahuoVC.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/25.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCgoodsfahuoVC.h"

@interface LPCgoodsfahuoVC ()

/**
 *  快递公司
 */
@property (nonatomic ,strong) UITextField * textFild;

/**
 *  快递单号
 */
@property (nonatomic ,strong) UITextField * numtextfild;


@end

@implementation LPCgoodsfahuoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"物流信息"];
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self  left];
    
    self.view.backgroundColor = RGBCOLOR(237, 243, 248);
    
    _textFild = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH -30, 40)];
    
    _textFild.layer.masksToBounds = true;
    
    _textFild.layer.borderWidth= 0.5f;
    
    _textFild.layer.borderColor = [UIColor grayColor].CGColor;
    
    _textFild.placeholder = @"请输入快递公司";

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text =@"快递公司";
    
    label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
    
    _textFild.font = label.font;
    
    label.textColor = [UIColor blackColor];
    
    _textFild.leftView = label;
    
    _textFild.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_textFild];
    
    
    _numtextfild = [[UITextField alloc]initWithFrame:CGRectMake(15, 15 + 55, SCREEN_WIDTH -30, 40)];
    
    _numtextfild.layer.masksToBounds = true;
    
    _numtextfild.layer.borderWidth= 0.5f;
    
    _numtextfild.layer.borderColor = [UIColor grayColor].CGColor;
    
    _numtextfild.placeholder = @"请输入快递单号";
    
    UILabel * labe_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    labe_num.textAlignment = NSTextAlignmentCenter;
    
    labe_num.text =@"快递单号";
    
    labe_num.font = [UIFont systemFontOfSize:labe_num.font.pointSize - 3];
    
    _numtextfild.font = labe_num.font;
    
    labe_num.textColor = [UIColor blackColor];
    
    _numtextfild.keyboardType = UIKeyboardTypeNumberPad;
    
    _numtextfild.leftView = labe_num;
    
    _numtextfild.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:_numtextfild];
    
    
    UIButton * buuton = [[UIButton alloc]initWithFrame:CGRectMake(15, 15 + 55*2, _numtextfild.frame.size.width, 40)];
    
    buuton.layer.masksToBounds = true;

    buuton.layer.cornerRadius = 10;
    
    [buuton setTitle:@"确认提交" forState:0];
    
    [buuton setTitleColor:[UIColor whiteColor] forState:0];
    
    [buuton setBackgroundColor:BLUECOLOR];
    
    [buuton addTarget:self action:@selector(buttinClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buuton];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 提交
-(void)buttinClick{
    
    
    if([_textFild.text isEqualToString:@""]){
        
        [self MBShow:@"请输入快递公司" backview:self.view];

        return;
        
    }
    if([_numtextfild.text isEqualToString:@""]){
        
        [self MBShow:@"请输入快递单号" backview:self.view];
        
        return;
        
    }
    
    [SHARE_APP showHud];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    
    NSDictionary *dic=@{@"orderState":@3,
                        @"orderCode":_idstring,
                        @"siId":user_id,
                        @"expressName":_textFild.text ,
                        @"expressCode":_numtextfild.text};
    
    
    [ZHJQHttpToll GET:LPCQUERENFAHUO parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
                
        [self MBShow:[self head:dic_json] backview:self.view];
        

        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
           [self performSelector:@selector(next) withObject:self afterDelay:1];
            
        }
        
    
    } failure:^(NSError *error) {
    
        [self MBShow:@"服务器繁忙,请重试" backview:self.view];
        
    }];
    
   
    
}

-(void)next{
    
    if([self.delegate respondsToSelector:@selector(chooseclick:)]){
        
        [self.delegate chooseclick:_section];
        
        [self.navigationController popToRootViewControllerAnimated:true];
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
