//
//  LPCPersonauthenticationViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCPersonauthenticationViewController.h"

#import "UIImageView+WebCache.h"


@interface LPCPersonauthenticationViewController ()<UITextFieldDelegate>

@end

@implementation LPCPersonauthenticationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
}
#pragma mark 获取实名信息
/**
 *  获取实名信息
 */
-(void)getUserinformation{
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    _nameString = [user objectForKey:@"name"];
    
    _SexString = [user objectForKey:@"sex"];
    
    if([_SexString isEqualToString:@"0"]){
        
        _SexString = @"男";
        
    }else {
        
        
        _SexString = @"女";
    }
   
    _NoString = [user objectForKey:@"code"];
    
    _image_one_string = [user objectForKey:@"IDCARD"];
    
    _image_two_string = [user objectForKey:@"IDCARDYES"];
    
    _imeage_three_string = [user objectForKey:@"IDCARDNO"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"实名认证详情"];
    
    [self left];
    
    [self getUserinformation];
    
    self.view.backgroundColor = COLOR(237, 243, 248, 1);
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}

-(void)Creat_UI{
    
    if(!_TabelView){
        
        _TabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TabelView.delegate = self;
        
        _TabelView.dataSource = self;
        
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        
       _TabelView.backgroundColor = footView.backgroundColor = self.view.backgroundColor;
        
        UILabel * lbael = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        
        lbael.text = @"隐私声明:我们承诺此信息仅用于核实商家信息,不做任何其他用途!";
        
        lbael.backgroundColor = [UIColor clearColor];
        
        lbael.textAlignment = NSTextAlignmentCenter;
        
        lbael.textColor = [UIColor lightGrayColor];
        
        lbael.font = [UIFont systemFontOfSize:lbael.font.pointSize - 2];
        
        lbael.adjustsFontSizeToFitWidth = true;
        
        [footView addSubview:lbael];
        
        _TabelView.tableFooterView = footView;
        
        [self.view addSubview:_TabelView];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews {
    
    if ([self.TabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.TabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.TabelView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.TabelView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    // 0 基本设置
    
    NSInteger  section = indexPath.section;
    

        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
            NSInteger  row = indexPath.row;
    
    if(section == 0){
        
        NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"店主姓名",@"店主性别",@"身份证号", nil];
        
      //  NSMutableArray * arr_name = [NSMutableArray arrayWithObjects:@"姓名",@"性别",@"身份证号", nil];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 80, 44-14)];
        
        label.text = arr[row];
        
        [cell.contentView addSubview:label];

        
        UILabel  * nametextfild = [[UILabel alloc]initWithFrame:CGRectMake(100, 7, SCREEN_WIDTH - 110, 30)];
        
        //nametextfild.text = arr_name[row];
        
        if(row == 0){
            
            nametextfild.text = _nameString;
            
        }if(row == 1){
            
            nametextfild.text = _SexString;
            
        }if(row == 2){
            
            nametextfild.text = _NoString;
            
        }
        
       // nametextfild.tag = row;
        
        
        [cell.contentView addSubview:nametextfild];
        
        
    }
    
    if(section == 1){
        
        NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"手持身份证",@"身份证正面",@"身份证反面", nil];
        
        NSMutableArray * images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d27_tu1"],[UIImage imageNamed:@"d27_tu2"],[UIImage imageNamed:@"d27_tu3"], nil];
        
        for (int i =0 ; i < images.count ; i ++ ) {
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 * (i + 1) + i * 100, SCREEN_WIDTH, 30)];
            
            label.text = arr[i];
            
            label.textAlignment = NSTextAlignmentCenter;
            
            [cell.contentView addSubview:label];

            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75/2, label.frame.origin.y  + label.frame.size.height , 75, 75)];
            
            if(i == 0){
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:_image_one_string] placeholderImage:images[0]];
                
            }
            if(i == 1){
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:_image_two_string] placeholderImage:images[1]];
                
            }
            if(i == 2){
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:_imeage_three_string] placeholderImage:images[2]];
                
            }
            
            [cell.contentView addSubview:imageView];
            
        
        }
        
    }
   
    
    return cell;
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 3;
        
    }
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        return 44;
        
    }
    
    return 355;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        
        label.text = @"请上传证件照片";
        
        label.textColor = [UIColor redColor];
        
        return label;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    
    return 30;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == 0 ){
        
        _nameString = textField.text;
        
    }if(textField.tag == 1 ){
        
        _SexString = textField.text;
        
    }if(textField.tag == 2 ){
        
        _NoString = textField.text;
        
    }
    
    
}

@end
