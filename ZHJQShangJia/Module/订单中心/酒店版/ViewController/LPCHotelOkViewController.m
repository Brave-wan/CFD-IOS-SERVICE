//
//  LPCHotelOkViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCHotelOkViewController.h"

@interface LPCHotelOkViewController ()

@end

@implementation LPCHotelOkViewController

#pragma mark请求详细数据
-(void)getidstring:(NSString *)idstring{
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSDictionary * dic = @{@"type":@1 ,@"orderCode":idstring,@"informationId":user_id};
    
    [ZHJQHttpToll  GET:LPCGOODSDELEUL parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){

            
            NSMutableArray * data_Arr = dic_json[@"data"];
            
            _data_dic = data_Arr[0];
            
            [self Creat_UI];
            
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙,请重试" backview:self.view];
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"订单详情"];
    
    [self left];
    
    // 酒店版 已使用
    
    
    [self getidstring:_idString];
    
    // Do any additional setup after loading the view.
}
#pragma mark 页面布局
-(void)Creat_UI{
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [UIView new];
        
        _TableView.backgroundColor = COLOR(237, 242, 249, 1);
        
        [self.view addSubview:_TableView];
        
    }
    
}

-(void)viewDidLayoutSubviews {
    
    if ([self.TableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.TableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.TableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.TableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    
    NSInteger  row =  indexPath.row ;
    
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    if(row == 0){
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * string_order = [NSString  stringWithFormat:@"%@",_data_dic[@"order_code"]];
        
        if(![string_order isEqualToString:@"(null)"] && ![string_order isEqualToString:@"<null>"]){
            
            orlderLabel.text =  [NSString stringWithFormat:@"订单号 : %@",string_order];//@"订单号 : 306954231";
            
        }else {
            
            orlderLabel.text = @"订单号 : ";
            
        }
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        imageView_one.layer.masksToBounds = true;
        
        imageView_one.layer.cornerRadius = 15;
        
        if([[NSString  stringWithFormat:@"%@",_data_dic[@"head_img"]] isEqualToString:@"<null>"] || [[NSString  stringWithFormat:@"%@",_data_dic[@"head_img"]] isEqualToString:@"(null)"]){
            
            [imageView_one  sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one  sd_setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",_data_dic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }
        
        
        [cell.contentView addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        if([[NSString  stringWithFormat:@"%@",_data_dic[@"nick_name"]] isEqualToString:@"<null>"] || [[NSString  stringWithFormat:@"%@",_data_dic[@"nick_name"]] isEqualToString:@"(null)"]){
            
            nameLabel_one.text = @"";
            
        }else {
            
            nameLabel_one.text = [NSString  stringWithFormat:@"%@",_data_dic[@"nick_name"]];
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_one];
        
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];
        
        if([[NSString  stringWithFormat:@"%@",_data_dic[@"describe_img"]] isEqualToString:@"<null>"] || [[NSString  stringWithFormat:@"%@",_data_dic[@"describe_img"]] isEqualToString:@"(null)"]){
            
            [imageView  sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
        }else {
            
            [imageView  sd_setImageWithURL:[NSURL URLWithString:[NSString  stringWithFormat:@"%@",_data_dic[@"describe_img"]]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
        }
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        if([[NSString  stringWithFormat:@"%@",_data_dic[@"goods_name"]] isEqualToString:@"<null>"] || [[NSString  stringWithFormat:@"%@",_data_dic[@"goods_name"]] isEqualToString:@"(null)"]){
            
            nameLabel.text = @"";
            
        }else {
            
            nameLabel.text = [NSString  stringWithFormat:@"%@",_data_dic[@"goods_name"]];
        }
        
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
        UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
        
        timeLaebl.textAlignment = NSTextAlignmentLeft;
        
        NSString * string = [NSString stringWithFormat:@"房间数 : %@间 \n入住 : %@ \n离店:%@   %@晚",_data_dic[@"quantity"], _data_dic[@"start_date"],_data_dic[@"end_date"],_data_dic[@"check_days"]];
        
        
        
        
        timeLaebl.text = string;
        
        timeLaebl.numberOfLines = 0 ;
        
        
        
        timeLaebl.textColor = [UIColor lightGrayColor];
        
        timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
        
        [cell.contentView addSubview:timeLaebl];
        
        
        UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
        
        
        NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%@",_data_dic[@"real_price"]
                          ];
        
        allLable.textColor = [UIColor blackColor];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
        
        UIColor * color = COLOR(255, 70, 78, 1);
        
        NSString * lengsyinh= [NSString stringWithFormat:@"%@",_data_dic[@"real_price"]];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(5, lengsyinh.length + 1)];
        
        allLable.attributedText = AttributedStr;
        
        
        [cell.contentView addSubview:allLable];
        
        
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor  lightGrayColor]];
        
        [button setTitle:@"交易完成" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
      
        
        
    }
    if(row == 1){
        
        UILabel  * nelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        nelabel.backgroundColor = [UIColor  whiteColor];
        
        nelabel.textColor = [UIColor lightGrayColor];
        
        nelabel.text = @"   订单信息:";
        
        nelabel.textAlignment  = NSTextAlignmentLeft;
        
        nelabel.font = [UIFont systemFontOfSize:nelabel.font.pointSize - 4];
        
        [cell.contentView addSubview:nelabel];
        
    }
    if(row == 2){
        
        NSMutableArray * data = [NSMutableArray array];
        
        
        NSString * string_start = [NSString stringWithFormat:@"  创建时间 : %@",_data_dic[@"create_time"]];
        
        [data addObject:string_start];
        
        NSString * string_pay = [NSString stringWithFormat:@"  付款时间 : %@",_data_dic[@"create_time"]];
        
        [data addObject:string_pay];
        
        NSString * pay_way = @"";
        
        if([[NSString stringWithFormat:@"%@",_data_dic[@"pay_way"]] isEqualToString:@"1"]){
            
            pay_way = @"  支付方式 : 余额";
            
        }if([[NSString stringWithFormat:@"%@",_data_dic[@"pay_way"]] isEqualToString:@"2"]){
            
            pay_way = @"  支付方式 : 支付宝";
            
        }if([[NSString stringWithFormat:@"%@",_data_dic[@"pay_way"]] isEqualToString:@"3"]){
            
            pay_way = @"  支付方式 : 微信";
            
        }
        
        [data addObject:pay_way];
        
        NSMutableArray * data_Arr = _data_dic[@"personName"];
        
        NSString * namestr = @"";
        
        if(data_Arr.count > 0){

        
        for(int i = 0 ; i < data_Arr.count ; i ++){
            
            NSString * name  = data_Arr[i];
            
            namestr = [NSString stringWithFormat:@"%@,%@",namestr,name];
            
            
        }
        
        namestr = [namestr substringFromIndex:1];
            
        }
        
        namestr = [NSString stringWithFormat:@"  入 住 人:%@",namestr];
        
        [data addObject:namestr];
        
        
        NSString * fangjianshu = [NSString  stringWithFormat:@"  房间数 :%@",_data_dic[@"quantity"]];
        
        [data addObject:fangjianshu];
        
        
        NSString * ruzhu = [NSString stringWithFormat:@"  入住时间 :%@",_data_dic[@"start_date"]];
        
        [data addObject:ruzhu];
        
        NSString * out_ = [NSString stringWithFormat:@"  离开时间 :%@",_data_dic[@"end_date"]];
        
        [data  addObject:out_];
        
        NSString * telString = [NSString stringWithFormat:@"  联系方式 :%@",_data_dic[@"telphone"]];
        
        [data addObject:telString];
        
        
        NSString * all = [NSString stringWithFormat:@"  总  额 :%@",_data_dic[@"real_price"]];
        
        [data addObject:all];
        
        
        for(int i = 0 ; i < data.count ; i ++){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 , SCREEN_WIDTH, 20)];
            
            label.textColor = [UIColor lightGrayColor];
            
            label.text = data[i];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
            
            [cell.contentView addSubview:label];
            
        }
        
        
    }
    
    
    
    return cell;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        return 120+44*2;
    }
    if(indexPath.row == 1){
        
        return 44;
    }
    if(indexPath.row == 2){
        
        return 190;
    }
    
    
    return 120+44*2;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = self.TableView.backgroundColor;
    
    return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    
    return 5;
    
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
