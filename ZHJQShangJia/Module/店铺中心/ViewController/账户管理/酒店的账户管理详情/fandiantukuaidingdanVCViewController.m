//
//  fandiantukuaidingdanVCViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/9.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "fandiantukuaidingdanVCViewController.h"

@interface fandiantukuaidingdanVCViewController ()

@end

@implementation fandiantukuaidingdanVCViewController


// 未使用的详情
-(void)requset:(NSString *)oneortwo{
    //[self Creat_UI];
    
    _data_Arr = [NSMutableArray array];
    
    _data_Arr_shop = [NSMutableArray array];
    
    NSDictionary * dic  = [NSDictionary dictionary];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    if([oneortwo isEqualToString:@"1"]){
        
        // 单品
        
        dic = @{@"goodsType":@0 ,@"siId":user_id ,@"orderCode":_idString};
        
    }if([oneortwo isEqualToString:@"2"]){
        
        // 套餐
        
        dic = @{@"goodsType":@1 ,@"siId":user_id ,@"orderCode":_idString};
        
    }
    
    
    [ZHJQHttpToll GET:LPCFANDIANXIANGQIYE parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            if([_oneTwo isEqualToString:@"1"]){
                
                NSMutableArray * dataArr = dic_json[@"data"];
                
                _data_Arr = dataArr;
                
                [self Creat_UI];
                
            }if([_oneTwo isEqualToString:@"2"]){
                
                NSDictionary * dic_data = dic_json[@"data"];
                
                _data_DIc = dic_data[@"detail"];
                
                NSMutableArray * shop = dic_data[@"shopGoodsList"];
                
                _data_Arr_shop = shop;
                
                [self Creat_UI];
                
                
            }
            
            
            return ;
            
        }
        [self MBShow:@"请求失败" backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self nav_title:@"订单详情"];
    
    [self left];
    
    [self requset:_oneTwo];
    
    
    // 饭店订单已使用
    
    
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
    
    NSInteger  section = indexPath.section;
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    
    if([_oneTwo isEqualToString:@"1"]){
        
        
        if(row < _data_Arr.count ){
            
            NSDictionary  *dic = _data_Arr[row];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"describe_img"]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
            NSString * timeNum = [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]];
            
            timeLaebl.text =  [NSString stringWithFormat:@"%@ 数量 : %@",timeNum, dic[@"quantity"]];
            
            timeLaebl.numberOfLines = 0 ;
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 5];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
            
            allLable.text = @"总额 : ￥750";
            
            NSString * all = [ NSString stringWithFormat:@"%@", dic[@"real_price"] ];
            
            NSString * all_string = [ NSString stringWithFormat:@"总额 : ￥%@", dic[@"real_price"]];
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all_string];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, all.length + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            
            
            
            
            
            if(row == _data_Arr.count - 1){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                
                [button setTitle:@"同意退款" forState:0];
                
                [button addTarget:self action:@selector(fandianshenqingtuik:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                
              UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                [button_one addTarget:self action:@selector(fandiantuikuaishenqingbohui:) forControlEvents:UIControlEventTouchUpInside];
                
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                //[cell.contentView addSubview:button_one];
                
                
                
            }
            
        }
        
        if(row == _data_Arr.count){
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -20, 40)];
            
            label.textColor = [UIColor lightGrayColor];
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.text = @"订单信息";
            
            [cell.contentView addSubview:label];
            
        }
        if(row ==  _data_Arr.count  + 1){
            
            NSMutableArray * data_Arr  = [NSMutableArray array];
            
            NSDictionary * dic = _data_Arr[0];
            
            [data_Arr addObject:[NSString stringWithFormat:@"创建时间  : %@",dic[@"create_time"]]];
            
            [data_Arr addObject:[NSString stringWithFormat:@"付款时间  : %@",dic[@"pay_time"]]];
            
            if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"1"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"余额支付"]];
                
            }if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"2"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"支付宝支付"]];
                
            }if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"3"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"微信支付"]];
                
            }
            
            [data_Arr addObject:[NSString stringWithFormat:@"就餐时间  : %@",dic[@"eat_date"]]];
            
            
            [data_Arr addObject:[NSString stringWithFormat:@"联系电话  : %@",dic[@"telphone"]]];
            
            
            NSInteger all = 0;
            
            for(NSDictionary * dict in _data_Arr){
                
                NSInteger  string = [[NSString stringWithFormat:@"%@",dict[@"real_price"]]  integerValue];
                
                all =  all + string;
                
                
                
            }
            
            [data_Arr addObject:[NSString stringWithFormat:@" 总      额  : %ld",(long)all]];
            
            
            for(int i = 0 ; i < data_Arr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + i * 20 , SCREEN_WIDTH-20, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = data_Arr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                [cell.contentView addSubview:label];
                
                
                
            }
            
        }
        
        
    }if([_oneTwo isEqualToString:@"2"]){
        
        
        if(row ==0 ){
            
            NSDictionary  *dic = _data_DIc ;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"b1_tu1"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
            
            
            timeLaebl.numberOfLines = 0 ;
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 5];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
            
            allLable.text = @"总额 : ￥750";
            
            NSString * all = [ NSString stringWithFormat:@"%@", dic[@"real_price"] ];
            
            NSString * all_string = [ NSString stringWithFormat:@"总额 : ￥%@", dic[@"real_price"]];
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all_string];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, all.length + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            

                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
                
                [button setTitle:@"同意退款" forState:0];
                
                [button addTarget:self action:@selector(fandianshenqingtuik:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
            [button_one setBackgroundColor:[UIColor whiteColor]];
            
            [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
            
            [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
            
                [button_one addTarget:self action:@selector(fandiantuikuaishenqingbohui:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
            
                button_one.layer.cornerRadius = 7;
            
            button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
            
            button_one.layer.borderWidth = .5;
            
              //  [cell.contentView addSubview:button_one];

            
        }
        
        
        if(row == 1){
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -20, 40)];
            
            label.textColor = [UIColor lightGrayColor];
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.text = @"订单信息";
            
            [cell.contentView addSubview:label];
            
        }
        if(row ==  2){
            
            NSMutableArray * data_Arr  = [NSMutableArray array];
            
            NSDictionary * dic = _data_DIc;
            
            [data_Arr addObject:[NSString stringWithFormat:@"创建时间  : %@",dic[@"create_time"]]];
            
            [data_Arr addObject:[NSString stringWithFormat:@"付款时间  : %@",dic[@"pay_time"]]];
            
            if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"1"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"余额支付"]];
                
            }if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"2"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"支付宝支付"]];
                
            }if([[NSString stringWithFormat:@"%@",dic[@"pay_way"]] isEqualToString:@"3"]){
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"微信支付"]];
                
            }
            
            [data_Arr addObject:[NSString stringWithFormat:@"就餐时间  : %@",dic[@"eat_date"]]];
            
            
            [data_Arr addObject:[NSString stringWithFormat:@"联系电话  : %@",dic[@"telphone"]]];
            
            
            
            NSInteger  string = [[NSString stringWithFormat:@"%@",dic[@"real_price"]]  integerValue];
            
            
            
            [data_Arr addObject:[NSString stringWithFormat:@" 总      额  : %ld",(long)string]];
            
            
            for(int i = 0 ; i < data_Arr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + i * 20 , SCREEN_WIDTH-20, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = data_Arr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                [cell.contentView addSubview:label];
                
                
                
            }
            
        }
        if(row ==  3){
            
            cell.backgroundColor =[UIColor whiteColor];
            
            NSMutableArray * data_Arr  = [NSMutableArray array];
            
            [data_Arr addObject:@"套餐内容 :"];
            
            for(NSDictionary * dic in _data_Arr_shop){
                
                NSString * string = [self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_name"]]];
                
                NSString * string_one = [self getstring:[NSString stringWithFormat:@"%@",dic[@"quantity"]]];
                
                NSString * string_two = [self getstring:[NSString stringWithFormat:@"%@",dic[@"new_price"]]];
                
                [data_Arr addObject:[NSString stringWithFormat:@"%@     %@     %@",string ,string_one ,string_two]];
                
                
            }
            
            
            
            
            for(int i = 0 ; i < data_Arr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + i * 20 , SCREEN_WIDTH-20, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = data_Arr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                [cell.contentView addSubview:label];
                
                
            }
            
        }
        
    }
    
    
    
    
    return cell;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_oneTwo isEqualToString:@"1"]){
        
        return _data_Arr.count + 2;
        
    }
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([_oneTwo isEqualToString:@"1"]){
        
        if(indexPath.row < _data_Arr.count -1){
            
            return 120;
            
        }if(indexPath.row == _data_Arr.count -1){
            
            return 120 +44;
            
        }if(indexPath.row == _data_Arr.count){
            
            return 40;
            
        }if(indexPath.row == _data_Arr.count+1){
            
            return 140;
            
        }
        
    }
    
    if(indexPath.row ==0){
        
        return 120 +44;
        
    }if(indexPath.row == 1){
        
        return 40;
        
    }if(indexPath.row == 2){
        
        return 140;
        
    }if(indexPath.row == 3){
        
        return _data_Arr_shop.count  * 20 + 30;
        
    }
    
    
    
    return 140;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    view.backgroundColor = self.TableView.backgroundColor;
    
    
    if([_oneTwo isEqualToString:@"1"]){
        
        
        NSDictionary *dic = _data_Arr[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        imageView_one.image  =[UIImage imageNamed:@"d19_touxaing"];
        
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }else {
            
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"<null>"] && ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"(null)"] ){
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]];
            
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
    }
    if([_oneTwo isEqualToString:@"2"]){
        
        if(_data_DIc != nil){
            
            NSDictionary *dic = _data_DIc;
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
            
            
            orlderLabel.text = code_String;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [view  addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            imageView_one.image  =[UIImage imageNamed:@"d19_touxaing"];
            
            if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
                
                [imageView_one sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            }else {
                
                
                [imageView_one sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
                
            }
            
            imageView_one.layer.masksToBounds =true;
            
            imageView_one.layer.cornerRadius = 15;
            
            [view  addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"<null>"] && ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"(null)"] ){
                
                nameLabel_one.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]];
                
            }
            
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [view addSubview:nameLabel_one];
        }
 
    }
    
    
    return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if([_oneTwo isEqualToString:@"2"]){
        
        
        return 40;
        
    }
    
    
    return 40;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 饭店的申请退款
-(void)fandianshenqingtuik:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary *dic = [NSDictionary dictionary];

            
            if(_data_Arr.count == 0){
                
                dic = _data_DIc;
                
            }else{
                
                dic = _data_Arr[0];
                
            }
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * string_all = [self getstring:[NSString stringWithFormat:@"%@",dic[@"real_price"]]];
            
            NSString * string_id = [self getstring:[NSString stringWithFormat:@"%@",dic[@"user_id"]]];
            
            NSString * string_userid = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dict = @{@"shopUserId":string_userid,
                                    @"useId":string_id,
                                    @"balance":string_all,
                                    @"siId":user_id,
                                    @"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]],
                                    @"orderState":@6,
                                    @"type":@"2"};
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dict success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self performSelector:@selector(pop) withObject:self afterDelay:.5];
                    
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
#pragma mark 饭店的申请退款的驳回
-(void)fandiantuikuaishenqingbohui:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary *dic = [NSDictionary dictionary];
            
            
            if(_data_Arr.count == 0){
                
                dic = _data_DIc;
                
            }else{
                
                dic = _data_Arr[0];
                
            }
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"siId":user_id,@"orderState":@"7",@"type":@2};
            
            
            [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self performSelector:@selector(pop) withObject:self afterDelay:.5];
                    
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


-(void)pop{
    
    if([self.object respondsToSelector:@selector(fandiantuikuaishenhe)]){
        
        [self.object fandiantuikuaishenhe];
        
        [self.navigationController popViewControllerAnimated:true];
        
    }

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
