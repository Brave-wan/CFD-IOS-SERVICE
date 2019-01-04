//
//  JPushJiuDianViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/16.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "JPushJiuDianViewController.h"

@interface JPushJiuDianViewController (){
    
    JPushJiuDianData * jpshModel;
    
}

@end

@implementation JPushJiuDianViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:false];
}
-(void)click_nav{
    
    if(_type_root == 1){
        
        // 切换跟试图
        
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
    
    [self left_nav];
    
    self.navigationItem.title = @"订单详情";
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    [self requset];
    // Do any additional setup after loading the view.
}

-(void)requset{
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSDictionary * dic = @{@"type":@1 ,@"orderCode":_orderCode,@"informationId":user_id};
    
    [ZHJQHttpToll  GET:LPCGOODSDELEUL parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            
            JPushJiuDianModel * model = [JPushJiuDianModel yy_modelWithJSON:dic_json];
            
            NSMutableArray * data = [model.data mutableCopy];
            
            jpshModel = [data firstObject];
            
            [self Creat_UI];
            
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙,请重试" backview:self.view];
        
    }];
    
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
    
    if(jpshModel != nil){
        
        if(row == 0){
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            orlderLabel.text = jpshModel.order_code;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [cell.contentView addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            imageView_one.layer.cornerRadius = 15;
            
            imageView_one.layer.masksToBounds = true;
            
           [imageView_one  sd_setImageWithURL:[NSURL URLWithString:jpshModel.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
            [cell.contentView addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            nameLabel_one.text = jpshModel.nick_name;;
           
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_one];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];

            [imageView  sd_setImageWithURL:[NSURL URLWithString:jpshModel.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
          
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
             nameLabel.text = jpshModel.goods_name;
         
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            NSString * string = [NSString stringWithFormat:@"房间数 : %ld间 \n入住 : %@ \n离店:%@   %ld晚",(long)jpshModel.quantity, jpshModel.start_date,jpshModel.end_date,(long)jpshModel.check_days];
            
            
            
            
            timeLaebl.text = string;
            
            timeLaebl.numberOfLines = 0 ;
            
            
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
            
            
            NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%ld",(long)jpshModel.real_price];
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            NSString * lengsyinh= [ NSString  stringWithFormat:@"￥%ld",(long)jpshModel.real_price];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, lengsyinh.length )];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            
            
            if(jpshModel.order_state == 2){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"验证核销" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(jiudian_button_yanzheng:) forControlEvents:UIControlEventTouchUpInside];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                [button_one addTarget:self action:@selector(jiudian_button_clanel:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = row;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
            }if(jpshModel.order_state == 3){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已使用" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }if(jpshModel.order_state == 4){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }if(jpshModel.order_state == 5){
                
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"同意退款" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(jiudian_button_shentongtuikuai:) forControlEvents:UIControlEventTouchUpInside];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                [button_one addTarget:self action:@selector(jiudian_button_bohui:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = row;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
                
            }if(jpshModel.order_state == 6){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"退款失败" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }if(jpshModel.order_state == 7){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"退款成功" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }if(jpshModel.order_state == 8){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已过期" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];

                
            }if(jpshModel.order_state == 9){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已作废" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                
            }
            
            
           
            
            
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
            
            
            NSString * string_start = [NSString stringWithFormat:@"  创建时间 : %@",jpshModel.create_time];
            
            [data addObject:string_start];
            
            NSString * string_pay = [NSString stringWithFormat:@"  付款时间 : %@",jpshModel.pay_time];
            
            [data addObject:string_pay];
            
            NSString * pay_way = @"";
            
            if([[NSString stringWithFormat:@"%ld",(long)jpshModel.pay_way] isEqualToString:@"1"]){
                
                pay_way = @"  支付方式 : 余额";
                
            }if([[NSString stringWithFormat:@"%ld",(long)jpshModel.pay_way] isEqualToString:@"2"]){
                
                pay_way = @"  支付方式 : 支付宝";
                
            }if([[NSString stringWithFormat:@"%ld",(long)jpshModel.pay_way] isEqualToString:@"3"]){
                
                pay_way = @"  支付方式 : 微信";
                
            }
            
            [data addObject:pay_way];
            
            NSMutableArray * data_Arr = [jpshModel.personName mutableCopy];
            
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
            
            
            NSString * fangjianshu = [NSString  stringWithFormat:@"  房间数 :%ld",(long)jpshModel.quantity];
            
            [data addObject:fangjianshu];
            
            
            NSString * ruzhu = [NSString stringWithFormat:@"  入住时间 :%@",jpshModel.start_date];
            
            [data addObject:ruzhu];
            
            NSString * out_ = [NSString stringWithFormat:@"  离开时间 :%@",jpshModel.end_date];
            
            [data  addObject:out_];
            
            NSString * telString = [NSString stringWithFormat:@"  联系方式 :%@",jpshModel.telphone];
            
            [data addObject:telString];
            
            
            NSString * all = [ NSString  stringWithFormat:@"  总    额  : ￥%ld",(long)jpshModel.real_price];
            
            [data addObject:all];
            
            
            for(int i = 0 ; i < data.count ; i ++){
                
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 30 , SCREEN_WIDTH, 30)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = data[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];

                
                if(i == 3){
                    
                    label.numberOfLines = 0;
                    
                    label.adjustsFontSizeToFitWidth = true;
                
                }
                
                label.numberOfLines = 0;
                
                
                [cell.contentView addSubview:label];
                
               
            }
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
        
        return 9 * 30;
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
    
    
    
    return 5;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   

    // Dispose of any resources that can be recreated.
}


#pragma mark 酒店的验证核销
-(void)jiudian_button_yanzheng:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        
        
        NSDictionary  *  dic = @{@"orderCode":_orderCode};
        
        [ZHJQHttpToll GET:LPCYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                [self requset];
                
                return ;
            }
            
            [self MBShow:@"验证核销··失败,请重试" backview:self.view];
            
        } failure:^(NSError *error) {
            
            [self MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark 酒店的取消订单
-(void)jiudian_button_clanel:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        NSDictionary  *  dic = @{@"orderCode":_orderCode};
        
        [ZHJQHttpToll GET:LPCQUXIAODINGDAN parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                _TableView.hidden = true;
                
                return ;
            }
            
            [self MBShow:@"取消订单失败,请重试" backview:self.view];
            
        } failure:^(NSError *error) {
            
            [self MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}
#pragma mark 酒店的同意退款
-(void)jiudian_button_shentongtuikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            
            [SHARE_APP showHud];
            
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * string_all = [NSString stringWithFormat:@"%ld",(long)jpshModel.real_price];
            
            NSString * string_id = [NSString stringWithFormat:@"%ld",(long)jpshModel.user_id];
            
            NSString * string_userid = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dict = @{@"shopUserId":string_userid,
                                    @"useId":string_id,
                                    @"balance":string_all,
                                    @"siId":user_id,
                                    @"orderCode":_orderCode,
                                    @"orderState":@6,
                                    @"type":@"1"};
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dict success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self requset];
                    
                    return ;
                    
                }
                
                [self MBShow:[self head:dic_json] backview:self.view];
                
            } failure:^(NSError *error) {
                
                [self MBShow:@"服务器繁忙" backview:self.view];
            }];
            
        });
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark 酒店的驳回请求
-(void)jiudian_button_bohui:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":_orderCode ,@"siId":user_id,@"orderState":@"7",@"type":@1};
            
            
            [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self requset];
                    
                    return ;
                    
                }
                
                [self MBShow:[self head:dic_json] backview:self.view];
                
            } failure:^(NSError *error) {
                
                [self MBShow:@"服务器繁忙" backview:self.view];
            }];
            
        });
        
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

#pragma mark label 计算高度
/**
 *  label 计算高度
 *
 *  @param contentLabel 当前的label ---- 需要计算的
 *  @param poit         字体大小----- 当前的字体大小-(self)
 *  @param string       text
 *  @param roadLabel    根据某个label 创建的当前的label
 *
 *  @return height/width
 */
-(CGRect)gethegitLabel:(UILabel *)contentLabel sizepoit:(int)poit textString:(NSString *)string newLbale:(UILabel *)roadLabel{
    
    UIFont * tfont = [UIFont systemFontOfSize:contentLabel.font.pointSize];
    
    contentLabel.font = tfont;
    
    contentLabel.lineBreakMode =NSLineBreakByTruncatingTail ;
    
    contentLabel.text = string ;
    
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    
    CGSize size =CGSizeMake(roadLabel.frame.size.width,MAXFLOAT);
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    contentLabel.frame =CGRectMake(contentLabel.frame.origin.x , contentLabel.frame.origin.y, contentLabel.frame.size.width, actualsize.height + 10);
    
    return contentLabel.frame;
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
