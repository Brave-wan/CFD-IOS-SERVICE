//
//  LPCGoodsDeliteViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCGoodsDeliteViewController.h"
#import "LPCDINGDANXIANGQImodel.h"
#import "LPCgoodsfahuoVC.h"



@interface LPCGoodsDeliteViewController ()

@end

@implementation LPCGoodsDeliteViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    
    _data_weifahuoArr = [NSMutableArray array];
    
    _data_weifahuoArr_two = [NSMutableArray array];
    
    _data_yifahuoArr = [NSMutableArray array];
    
    _data_yifahuoArr_two = [NSMutableArray array];
    
    _data_wanfahuoArr = [NSMutableArray array];
    
    _data_wanfahuoArr_two = [NSMutableArray array];
    
    //  0 基本设置
    
    [self nav_title:@"订单详情"];
    
    [self left];
    
    [self Creat_UI];
    
    //  商品版未完成
    
    if([_string isEqualToString:@"2"] ||[_string isEqualToString:@"3"] || [_string isEqualToString:@"4"] ){
        
        [self request:_string_id goods:@"3"];
    }
    
    
    // Do any additional setup after loading the view.
}
#pragma mark 订单详情的网络请求
/**
 *  订单详情的网络请求
 *
 *  @param request 订单号
 */
-(void)request:(NSString *)request goods:(NSString *)goods{
    

    [SHARE_APP showHud];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSDictionary * dic = @{@"type":goods ,@"orderCode":request,@"siId":user_id};
    
    [ZHJQHttpToll GET:LPCGOODSQIEHUAN parameters:dic success:^(id responseObject) {
        
         NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        LPCDINGDANXIANGQImodel  * model = [LPCDINGDANXIANGQImodel yy_modelWithJSON:dic_json];
        
        
        if(model.header.status == 0){
            
            [SHARE_APP hideHud];
            _express = model.data.express;
            
            _cause = model.data.refundCause;

            // 未发货的情况
            if([_string isEqualToString:@"2"]){
            
            _data_weifahuoArr = [model.data.map mutableCopy];
            
            _data_weifahuoArr_two = _data_weifahuoArr;
            
            
            NSMutableArray * yesArr = [NSMutableArray array];
            
            NSMutableArray * noArr = [NSMutableArray array];
            
            for(LPCqingdanxiangMap * map in _data_weifahuoArr){
                
                if(map.is_deliver_fee == 0){
                    
                    [yesArr addObject:map];
                    
                }else {
                    
                   
                    
                    [noArr addObject:map];
                }
                
            }
            
            _data_weifahuoArr = yesArr;
            
            _data_weifahuoArr_two = noArr;
            
            [_TableView reloadData];
            }
            
            // 已发货的情况
            if([_string isEqualToString:@"3"]){
                
                _data_yifahuoArr = [model.data.map mutableCopy];
                
                _data_yifahuoArr_two = _data_yifahuoArr;
                
                
                NSMutableArray * yesArr = [NSMutableArray array];
                
                NSMutableArray * noArr = [NSMutableArray array];
                
                for(LPCqingdanxiangMap * map in _data_yifahuoArr){
                    
                    if(map.is_deliver_fee == 0){
                        
                        [yesArr addObject:map];
                        
                    }else {
                        
                        
                        [noArr addObject:map];
                    }
                    
                }
                
                _data_yifahuoArr = yesArr;
                
                _data_yifahuoArr_two = noArr;
                
                [_TableView reloadData];
                
            
                
            }
            
            
            
            // 已完成
            if([_string isEqualToString:@"4"]){
                
                
                    _data_wanfahuoArr = [model.data.map mutableCopy];
                    
                    _data_wanfahuoArr_two = _data_wanfahuoArr;
                    
                    
                    NSMutableArray * yesArr = [NSMutableArray array];
                    
                    NSMutableArray * noArr = [NSMutableArray array];
                    
                    for(LPCqingdanxiangMap * map in _data_wanfahuoArr){
                        
                        if(map.is_deliver_fee == 0){
                            
                            [yesArr addObject:map];
                            
                        }else {
                            
                            [noArr addObject:map];
                        }
                        
                    }
                    
                    _data_wanfahuoArr = yesArr;
                    
                    _data_wanfahuoArr_two = noArr;
                    
              [_TableView reloadData];
            }
            
            
            
            return ;
            
        }
        
        [self MBShow:model.header.msg backview:self.view];
     
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if([self.string isEqualToString:@"2"]){
        
        if(row <= self.data_weifahuoArr.count-1){
          
            LPCqingdanxiangMap * mapmodel = _data_weifahuoArr[row];
    
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:mapmodel.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            [cell.contentView addSubview:imageView];
                
                
            
            UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
                
            nameLabel_sd.text = mapmodel.goods_name;
            
            nameLabel_sd.textAlignment = NSTextAlignmentLeft;
                
            nameLabel_sd.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_sd];
            
            UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
                
            pirceLabel.text = @"￥120";
                
            pirceLabel.textAlignment  = NSTextAlignmentLeft;
                
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 2];
                
            NSString * numStreing  = [NSString stringWithFormat:@"%ld",(long)mapmodel.price];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",numStreing]];
                
            UIColor * color;
                
            color = COLOR(255, 70, 78, 1);
                
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                 
                                      value:color
                 
                                      range:NSMakeRange(0, numStreing.length + 1)];
                

            [AttributedStr addAttribute:NSFontAttributeName
                 
                                      value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 3]
                 
                                      range:NSMakeRange(0, numStreing.length + 1)];
                
                
                
            
            pirceLabel.attributedText = AttributedStr;
                
            
            [cell.contentView addSubview:pirceLabel];
            
            
            
            UILabel * pirceLabel_other = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x + pirceLabel.frame.size.width, nameLabel_sd.frame.origin.y + 30 + 7.5, nameLabel_sd.frame.size.width/3 * 2 + 15, 30)];
                

            pirceLabel_other.text = @"";
                
            
            pirceLabel_other.textAlignment  = NSTextAlignmentLeft;
 
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 3];
            
            
            NSString * PIstring = [NSString stringWithFormat:@"￥%ld    配送费:￥%ld",(long)mapmodel.oldPrice,(long)mapmodel.deliver_fee];
            
            NSString *linString = [NSString stringWithFormat:@"%ld",(long)mapmodel.oldPrice];
            
            
            NSMutableAttributedString *AttributedStr_ = [[NSMutableAttributedString alloc]initWithString:PIstring];
                
                
            
            [AttributedStr_ addAttribute:NSForegroundColorAttributeName
                 
                                       value:[UIColor lightGrayColor]
                 
                                       range:NSMakeRange(0, AttributedStr_.length)];
                
                
                
            
            [AttributedStr_ addAttribute:NSStrikethroughStyleAttributeName
                 
                                       value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                 
                                       range:NSMakeRange(0, linString.length + 1)];
                
            
            pirceLabel_other.attributedText = AttributedStr_;
                
            
            [cell.contentView addSubview:pirceLabel_other];
                
                

                
            UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x , pirceLabel.frame.origin.y + pirceLabel.frame.size.height + 5, nameLabel_sd.frame.size.width  , 30)];
                
            NSString * allString = [NSString stringWithFormat:@"%ld",(long)mapmodel.real_price];
                
            NSString * allString_one = [NSString stringWithFormat:@"%ld",(long)mapmodel.quantity];
            
            allLabel.textAlignment  = NSTextAlignmentLeft;
                
            allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 2];
            
            NSString * String = [NSString stringWithFormat:@"总额 ￥%@           X %@",allString,allString_one];
                
            
            NSMutableAttributedString * AttributedSt = [[NSMutableAttributedString alloc]initWithString:String];
                
                
            
            allLabel.textColor = [UIColor lightGrayColor];
                
                
            
            [AttributedSt addAttribute:NSForegroundColorAttributeName
                 
                                     value:color
                 
                                     range:NSMakeRange(3, allString.length + 1)];
                
                
            
            [AttributedSt addAttribute:NSFontAttributeName
                 
                                     value:[UIFont systemFontOfSize:allLabel.font.pointSize + 3]
                 
                                     range:NSMakeRange(3, allString.length + 1)];
                
                
            
            allLabel.attributedText = AttributedSt;
                
            
            [cell.contentView addSubview:allLabel];
                
                
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                
                
                if(row == _data_weifahuoArr.count -1){
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"确认发货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(button_click) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }
            
        }if(row == _data_weifahuoArr.count){
            
            LPCqingdanxiangMap * mapModel = _data_weifahuoArr_two[0];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
            label.text = @"  订单信息";
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.textColor = [UIColor lightGrayColor];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
            
            [cell.contentView addSubview:label];
            
            
        
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44+5, 39/3, 66/3)];
            
            imageView.image = [UIImage imageNamed:@"c2_ditu"];
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5+44, SCREEN_WIDTH - 30, 15)];
            
            NSString * string_name = [NSString stringWithFormat:@"收货人 :    %@",mapModel.user_name];
            
            if(![string_name isEqualToString:@"收货人 :    (null)"] && ![ string_name isEqualToString:@"收货人 :    <null>"]){
                
                namelabel.text = string_name;
                
            }
            
            namelabel.textAlignment = NSTextAlignmentLeft;
            
            namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
            
            [cell.contentView addSubview:namelabel];
            
            UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 44+5, SCREEN_WIDTH - 35, 15)];
            
            telLabel.text = mapModel.telphone;

            telLabel.textAlignment = NSTextAlignmentRight;
            
            telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
            
            [cell.contentView addSubview:telLabel];
            
            
            UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
            
            NSString *add_string = [NSString stringWithFormat:@"%@%@",mapModel.place_address,mapModel.detail_address];
            
            if(![add_string isEqualToString:@"(null)(null)"]){
                
                  addressLabel.text = add_string;
            }
            
            
            addressLabel.textColor = [UIColor lightGrayColor];
            
            addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
            
            addressLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:addressLabel];
            
            
            NSMutableArray * dataArr = [NSMutableArray array];
            
            [dataArr addObject:[NSString stringWithFormat:@"  创建时间 :  %@",mapModel.create_time]];
            
             [dataArr addObject:[NSString stringWithFormat:@"  付款时间 :  %@",mapModel.pay_time]];
          
        
            
            NSString * string_paywasy = @"";
            
            if(mapModel.pay_way == 0){
                
                string_paywasy = @"未支付";
                
                
                
            }
            if(mapModel.pay_way == 1){
                
                string_paywasy = @"余额";
                
            }
            if(mapModel.pay_way == 2){
                
                string_paywasy = @"支付宝";
                
            }
            if(mapModel.pay_way == 3){
                
                string_paywasy = @"微信";
                
            }
            
            [dataArr addObject:[NSString stringWithFormat:@"  支付方式 :  %@",string_paywasy]];
            
              [dataArr addObject:[NSString stringWithFormat:@"  数      量 : %ld",(long)mapModel.quantity]];
            
            
            NSString * string_fangshi = @"";
            
            if(mapModel.is_deliver_fee == 1){
                
                if(mapModel.is_pickup == 0){
                    
                    string_fangshi = @"快递";
                    
                }else {
                    
                     string_fangshi = @"自提";
                    
                }
                
                
            }
            
             [dataArr addObject:[NSString stringWithFormat:@"  配送方式 : %@",string_fangshi]];
            
             [dataArr addObject:[NSString stringWithFormat:@"   配 送 费 :￥%ld",(long)mapModel.deliver_fee]];
            
               [dataArr addObject:[NSString stringWithFormat:@"  总      额  : ￥%ld",(long)mapModel.real_price]];
        
            
          
            
            for(int i = 0 ; i < dataArr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 + addressLabel.frame.size.height + addressLabel.frame.origin.y , SCREEN_WIDTH, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = dataArr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                
                [cell.contentView addSubview:label];
            
        
           }
        
        
        }
        
        
    }
    
    
#pragma mark 已发货
    
    if([self.string isEqualToString:@"3"]){
        
        if(row <= self.data_yifahuoArr.count-1){
            
            LPCqingdanxiangMap * mapmodel = _data_yifahuoArr[row];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:mapmodel.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            [cell.contentView addSubview:imageView];
            
            
            
            UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel_sd.text = mapmodel.informationName;
            
            nameLabel_sd.textAlignment = NSTextAlignmentLeft;
            
            nameLabel_sd.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_sd];
            
            UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
            
            pirceLabel.text = @"￥120";
            
            pirceLabel.textAlignment  = NSTextAlignmentLeft;
            
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 2];
            
            NSString * numStreing  = [NSString stringWithFormat:@"%ld",(long)mapmodel.newPrice];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",numStreing]];
            
            UIColor * color;
            
            color = COLOR(255, 70, 78, 1);
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(0, numStreing.length + 1)];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 3]
             
                                  range:NSMakeRange(0, numStreing.length + 1)];
            
            
            
            
            pirceLabel.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:pirceLabel];
            
            
            
            UILabel * pirceLabel_other = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x + pirceLabel.frame.size.width, nameLabel_sd.frame.origin.y + 30 + 7.5, nameLabel_sd.frame.size.width/3 * 2 + 15, 30)];
            
            
            pirceLabel_other.text = @"";
            
            
            pirceLabel_other.textAlignment  = NSTextAlignmentLeft;
            
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 3];
            
            
            NSString * PIstring = [NSString stringWithFormat:@"￥%ld    配送费:￥%ld",(long)mapmodel.oldPrice,(long)mapmodel.deliver_fee];
            
            NSString *linString = [NSString stringWithFormat:@"%ld",(long)mapmodel.oldPrice];
            
            
            NSMutableAttributedString *AttributedStr_ = [[NSMutableAttributedString alloc]initWithString:PIstring];
            
            
            
            [AttributedStr_ addAttribute:NSForegroundColorAttributeName
             
                                   value:[UIColor lightGrayColor]
             
                                   range:NSMakeRange(0, AttributedStr_.length)];
            
            
            
            
            [AttributedStr_ addAttribute:NSStrikethroughStyleAttributeName
             
                                   value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
             
                                   range:NSMakeRange(0, linString.length + 1)];
            
            
            pirceLabel_other.attributedText = AttributedStr_;
            
            
            [cell.contentView addSubview:pirceLabel_other];
            
            
            
            
            UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x , pirceLabel.frame.origin.y + pirceLabel.frame.size.height + 5, nameLabel_sd.frame.size.width  , 30)];
            
            NSString * allString = [NSString stringWithFormat:@"%ld",(long)mapmodel.real_price];
            
            NSString * allString_one = [NSString stringWithFormat:@"%ld",(long)mapmodel.quantity];
            
            allLabel.textAlignment  = NSTextAlignmentLeft;
            
            allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 3];
            
            NSString * String = [NSString stringWithFormat:@"总额 ￥%@           X %@",allString,allString_one];
            
            
            NSMutableAttributedString * AttributedSt = [[NSMutableAttributedString alloc]initWithString:String];
            
            
            
            allLabel.textColor = [UIColor lightGrayColor];
            
            
            
            [AttributedSt addAttribute:NSForegroundColorAttributeName
             
                                 value:color
             
                                 range:NSMakeRange(3, allString.length + 1)];
            
            
            
            [AttributedSt addAttribute:NSFontAttributeName
             
                                 value:[UIFont systemFontOfSize:allLabel.font.pointSize + 3]
             
                                 range:NSMakeRange(3, allString.length + 1)];
            
            
            
            allLabel.attributedText = AttributedSt;
            
            
            [cell.contentView addSubview:allLabel];
            
            
            
            if(row == _data_yifahuoArr.count -1){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];

                NSString * title_string = @"";
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];

                
                if(mapmodel.order_state ==3 || mapmodel.order_state ==4){
                    
                    title_string = @"已发货";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];

                    
                }if(mapmodel.order_state ==5){
                    
                    title_string = @"已完成";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                }if(mapmodel.order_state ==6){
                    
                    title_string = @"同意退款";
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button addTarget:self action:@selector(qushenhe:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    
                    UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                    
                    
                    
                    [button_one setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
                    
                    
                    [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                    
                    
                    button_one.layer.masksToBounds = true;
                    
                    
                    button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                    
                    
                    [button_one addTarget:self action:@selector(shangpinbohuituikuaiqingqiu:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    button_one.tag = row;
                    
                    
                    button_one.layer.cornerRadius = 7;
                    
                    
                    button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                    
                    
                    button_one.layer.borderWidth = .5;
                    
                    
                    [cell.contentView addSubview:button_one];
                    
                }if(mapmodel.order_state == 7 ){
                    
                    title_string = @"待发货";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                }
                if(mapmodel.order_state == 11 ){
                    
                    title_string = @"确认收货";
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button addTarget:self action:@selector(shouhuo:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                if( mapmodel.order_state ==8){
                    
                    title_string = @"去退款";
                   
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    
                    [button addTarget:self action:@selector(qutuikuai:) forControlEvents:UIControlEventTouchUpInside];

                    
                }
                
                if(mapmodel.order_state ==10 ){
                    
                    title_string = @"已驳回";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                }
                if(mapmodel.order_state ==9 ){
                    
                    title_string = @"已退款";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                }
                
                
                
                [button setTitle:title_string  forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
              
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }
            
        }if(row == _data_yifahuoArr.count + 1){
            
            if(![_express.express_name isEqualToString:@""]){
                
                
              
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
                
                label.text = @"  快递信息";
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.textColor = [UIColor lightGrayColor];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
                
                [cell.contentView addSubview:label];
                
                
                UILabel * numlabe=  [[UILabel alloc]initWithFrame:CGRectMake(0, 30 + 5, SCREEN_WIDTH, 30)];
                
                numlabe.tag = 1000;
                
                numlabe.textColor = [UIColor lightGrayColor];
                
                numlabe.text =[NSString stringWithFormat:@"  快递公司:%@",_express.express_name];
                
                numlabe.font = [UIFont systemFontOfSize:numlabe.font.pointSize - 4];
                
                [cell.contentView addSubview:numlabe];
                
                
                UILabel * numlabe_ine =  [[UILabel alloc]initWithFrame:CGRectMake(0, 70 , SCREEN_WIDTH, 30)];
                
                numlabe_ine.tag = 1001;
                
                numlabe_ine.textColor = [UIColor lightGrayColor];
                
                numlabe_ine.text = [NSString stringWithFormat:@"  运单号:%ld",(long)_express.express_code];
                
                numlabe_ine.font = [UIFont systemFontOfSize:numlabe_ine.font.pointSize - 4];
                
                [cell.contentView addSubview:numlabe_ine];
                
            }else {
                
                LPCqingdanxiangMap * mapModel = _data_yifahuoArr_two[0];
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                
                label.text = @"  订单信息";
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.textColor = [UIColor lightGrayColor];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
                
                [cell.contentView addSubview:label];
                
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44+5, 39/3, 66/3)];
                
                imageView.image = [UIImage imageNamed:@"c2_ditu"];
                
                [cell.contentView addSubview:imageView];
                
                
                UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5+44, SCREEN_WIDTH - 30, 15)];
                
                NSString * string_name = [NSString stringWithFormat:@"收货人 :    %@",mapModel.user_name];
                
                if(![string_name isEqualToString:@"收货人 :    (null)"] && ![ string_name isEqualToString:@"收货人 :    <null>"]){
                    
                    namelabel.text = string_name;
                    
                }
                
                namelabel.textAlignment = NSTextAlignmentLeft;
                
                namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
                
                [cell.contentView addSubview:namelabel];
                
                UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 44+5, SCREEN_WIDTH - 35, 15)];
                
                telLabel.text = mapModel.telphone;
                
                telLabel.textAlignment = NSTextAlignmentRight;
                
                telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
                
                [cell.contentView addSubview:telLabel];
                
                
                UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
                
                NSString *add_string = [NSString stringWithFormat:@"%@%@",mapModel.place_address,mapModel.detail_address];
                
                if(![add_string isEqualToString:@"(null)(null)"]){
                    
                    addressLabel.text = add_string;
                }
                
                
                addressLabel.textColor = [UIColor lightGrayColor];
                
                addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
                
                addressLabel.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:addressLabel];
                
                
                NSMutableArray * dataArr = [NSMutableArray array];
                
                [dataArr addObject:[NSString stringWithFormat:@"  创建时间 :  %@",mapModel.create_time]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  付款时间 :  %@",mapModel.pay_time]];
                
                
                
                NSString * string_paywasy = @"";
                
                if(mapModel.pay_way == 0){
                    
                    string_paywasy = @"未支付";
                    
                    
                    
                }
                if(mapModel.pay_way == 1){
                    
                    string_paywasy = @"余额";
                    
                }
                if(mapModel.pay_way == 2){
                    
                    string_paywasy = @"支付宝";
                    
                }
                if(mapModel.pay_way == 3){
                    
                    string_paywasy = @"微信";
                    
                }
                
                [dataArr addObject:[NSString stringWithFormat:@"  支付方式 :  %@",string_paywasy]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  数      量 : %ld",(long)mapModel.quantity]];
                
                
                NSString * string_fangshi = @"";
                
                if(mapModel.is_deliver_fee == 1){
                    
                    if(mapModel.is_pickup == 0){
                        
                        string_fangshi = @"快递";
                        
                    }else {
                        
                        string_fangshi = @"自提";
                        
                    }
                    
                    
                }
                
                [dataArr addObject:[NSString stringWithFormat:@"  配送方式 : %@",string_fangshi]];
                
                [dataArr addObject:[NSString stringWithFormat:@"   配 送 费 :￥%ld",(long)mapModel.deliver_fee]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  总      额  : ￥%ld",(long)mapModel.real_price]];
                
                
                
                
                for(int i = 0 ; i < dataArr.count ; i ++){
                    
                    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 + addressLabel.frame.size.height + addressLabel.frame.origin.y , SCREEN_WIDTH, 20)];
                    
                    label.textColor = [UIColor lightGrayColor];
                    
                    label.text = dataArr[i];
                    
                    label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                    
                    [cell.contentView addSubview:label];
                    
                    
                }

                
            }
            
            
            
        }if(row == _data_yifahuoArr.count ){
            
            if([_cause.userName isEqualToString:@""] || _cause == nil){
                
                LPCqingdanxiangMap * mapModel = _data_yifahuoArr_two[0];
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
                
                label.text = @"  订单信息";
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.textColor = [UIColor lightGrayColor];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
                
                [cell.contentView addSubview:label];
                
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44+5, 39/3, 66/3)];
                
                imageView.image = [UIImage imageNamed:@"c2_ditu"];
                
                [cell.contentView addSubview:imageView];
                
                
                UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5+44, SCREEN_WIDTH - 30, 15)];
                
                NSString * string_name = [NSString stringWithFormat:@"收货人 :    %@",mapModel.user_name];
                
                if(![string_name isEqualToString:@"收货人 :    (null)"] && ![ string_name isEqualToString:@"收货人 :    <null>"]){
                    
                    namelabel.text = string_name;
                    
                }
                
                namelabel.textAlignment = NSTextAlignmentLeft;
                
                namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
                
                [cell.contentView addSubview:namelabel];
                
                UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 44+5, SCREEN_WIDTH - 35, 15)];
                
                telLabel.text = mapModel.telphone;
                
                telLabel.textAlignment = NSTextAlignmentRight;
                
                telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
                
                [cell.contentView addSubview:telLabel];
                
                
                UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
                
                NSString *add_string = [NSString stringWithFormat:@"%@%@",mapModel.place_address,mapModel.detail_address];
                
                if(![add_string isEqualToString:@"(null)(null)"]){
                    
                    addressLabel.text = add_string;
                }
                
                
                addressLabel.textColor = [UIColor lightGrayColor];
                
                addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
                
                addressLabel.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:addressLabel];
                
                
                NSMutableArray * dataArr = [NSMutableArray array];
                
                [dataArr addObject:[NSString stringWithFormat:@"  创建时间 :  %@",mapModel.create_time]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  付款时间 :  %@",mapModel.pay_time]];
                
                
                
                NSString * string_paywasy = @"";
                
                if(mapModel.pay_way == 0){
                    
                    string_paywasy = @"未支付";
                    
                    
                    
                }
                if(mapModel.pay_way == 1){
                    
                    string_paywasy = @"余额";
                    
                }
                if(mapModel.pay_way == 2){
                    
                    string_paywasy = @"支付宝";
                    
                }
                if(mapModel.pay_way == 3){
                    
                    string_paywasy = @"微信";
                    
                }
                
                [dataArr addObject:[NSString stringWithFormat:@"  支付方式 :  %@",string_paywasy]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  数      量 : %ld",(long)mapModel.quantity]];
                
                
                NSString * string_fangshi = @"";
                
                if(mapModel.is_deliver_fee == 1){
                    
                    if(mapModel.is_pickup == 0){
                        
                        string_fangshi = @"快递";
                        
                    }else {
                        
                        string_fangshi = @"自提";
                        
                    }
                    
                    
                }
                
                [dataArr addObject:[NSString stringWithFormat:@"  配送方式 : %@",string_fangshi]];
                
                [dataArr addObject:[NSString stringWithFormat:@"   配 送 费 :￥%ld",(long)mapModel.deliver_fee]];
                
                [dataArr addObject:[NSString stringWithFormat:@"  总      额  : ￥%ld",(long)mapModel.real_price]];
                
                
                
                
                for(int i = 0 ; i < dataArr.count ; i ++){
                    
                    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 + addressLabel.frame.size.height + addressLabel.frame.origin.y , SCREEN_WIDTH, 20)];
                    
                    label.textColor = [UIColor lightGrayColor];
                    
                    label.text = dataArr[i];
                    
                    label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                    
                    [cell.contentView addSubview:label];
                    
                    
                }
                
            }else {
                
                // 退款原因
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
                
                label.text = @"  退款信息";
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.textColor = [UIColor lightGrayColor];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
                
                [cell.contentView addSubview:label];
                
                
                UILabel * numlabe=  [[UILabel alloc]initWithFrame:CGRectMake(0, 20 + 5, SCREEN_WIDTH, 30)];
                
                numlabe.tag = 1000;
                
                numlabe.textColor = [UIColor lightGrayColor];
                
                numlabe.text =[NSString stringWithFormat:@"  姓名:%@",_cause.userName];
                
                numlabe.font = [UIFont systemFontOfSize:numlabe.font.pointSize - 4];
                
                [cell.contentView addSubview:numlabe];
                
                
                UILabel * numlabe_ine =  [[UILabel alloc]initWithFrame:CGRectMake(0, 70-10 , SCREEN_WIDTH, 30)];
                
                numlabe_ine.tag = 1001;
                
                numlabe_ine.textColor = [UIColor lightGrayColor];
                
                numlabe_ine.text = [NSString stringWithFormat:@"  手机号:%ld",(long)_cause.userPhone];
                
                
                numlabe_ine.font = [UIFont systemFontOfSize:numlabe_ine.font.pointSize - 4];
                
                [cell.contentView addSubview:numlabe_ine];
                
                
                UILabel * numlabe_ine_ine =  [[UILabel alloc]initWithFrame:CGRectMake(0, 90 , SCREEN_WIDTH, 30)];
                
                numlabe_ine_ine.tag = 1001;
                
                numlabe_ine_ine.textColor = [UIColor lightGrayColor];
                
                numlabe_ine_ine.text = [NSString stringWithFormat:@"  退款原因:%@",_cause.cause];
                
                numlabe_ine_ine.font = [UIFont systemFontOfSize:numlabe_ine_ine.font.pointSize - 4];
                
                [cell.contentView addSubview:numlabe_ine_ine];
                
            }
                
            
            
        }if(row ==_data_yifahuoArr.count  + 2 ){
            
            LPCqingdanxiangMap * mapModel = _data_yifahuoArr_two[0];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
            label.text = @"  订单信息";
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.textColor = [UIColor lightGrayColor];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
            
            [cell.contentView addSubview:label];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44+5, 39/3, 66/3)];
            
            imageView.image = [UIImage imageNamed:@"c2_ditu"];
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5+44, SCREEN_WIDTH - 30, 15)];
            
            NSString * string_name = [NSString stringWithFormat:@"收货人 :    %@",mapModel.user_name];
            
            if(![string_name isEqualToString:@"收货人 :    (null)"] && ![ string_name isEqualToString:@"收货人 :    <null>"]){
                
                namelabel.text = string_name;
                
            }
            
            namelabel.textAlignment = NSTextAlignmentLeft;
            
            namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
            
            [cell.contentView addSubview:namelabel];
            
            UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 44+5, SCREEN_WIDTH - 35, 15)];
            
            telLabel.text = mapModel.telphone;
            
            telLabel.textAlignment = NSTextAlignmentRight;
            
            telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
            
            [cell.contentView addSubview:telLabel];
            
            
            UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
            
            NSString *add_string = [NSString stringWithFormat:@"%@%@",mapModel.place_address,mapModel.detail_address];
            
            if(![add_string isEqualToString:@"(null)(null)"]){
                
                addressLabel.text = add_string;
            }
            
            
            addressLabel.textColor = [UIColor lightGrayColor];
            
            addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
            
            addressLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:addressLabel];
            
            
            NSMutableArray * dataArr = [NSMutableArray array];
            
            [dataArr addObject:[NSString stringWithFormat:@"  创建时间 :  %@",mapModel.create_time]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  付款时间 :  %@",mapModel.pay_time]];
            
            
            
            NSString * string_paywasy = @"";
            
            if(mapModel.pay_way == 0){
                
                string_paywasy = @"未支付";
                
                
                
            }
            if(mapModel.pay_way == 1){
                
                string_paywasy = @"余额";
                
            }
            if(mapModel.pay_way == 2){
                
                string_paywasy = @"支付宝";
                
            }
            if(mapModel.pay_way == 3){
                
                string_paywasy = @"微信";
                
            }
            
            [dataArr addObject:[NSString stringWithFormat:@"  支付方式 :  %@",string_paywasy]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  数      量 : %ld",(long)mapModel.quantity]];
            
            
            NSString * string_fangshi = @"";
            
            if(mapModel.is_deliver_fee == 1){
                
                if(mapModel.is_pickup == 0){
                    
                    string_fangshi = @"快递";
                    
                }else {
                    
                    string_fangshi = @"自提";
                    
                }
                
                
            }
            
            [dataArr addObject:[NSString stringWithFormat:@"  配送方式 : %@",string_fangshi]];
            
            [dataArr addObject:[NSString stringWithFormat:@"   配 送 费 :￥%ld",(long)mapModel.deliver_fee]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  总      额  : ￥%ld",(long)mapModel.real_price]];
            
            
            
            
            for(int i = 0 ; i < dataArr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 + addressLabel.frame.size.height + addressLabel.frame.origin.y , SCREEN_WIDTH, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = dataArr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                
                [cell.contentView addSubview:label];
                
                
            }
            

            
        }
    }
    
    
#pragma mark 已完成
    
    if([self.string isEqualToString:@"4"]){
        
        if(row <= self.data_wanfahuoArr.count-1){
            
            LPCqingdanxiangMap * mapmodel = _data_wanfahuoArr[row];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:mapmodel.describe_img] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
            [cell.contentView addSubview:imageView];
            
            
            
            UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel_sd.text = mapmodel.informationName;
            
            nameLabel_sd.textAlignment = NSTextAlignmentLeft;
            
            nameLabel_sd.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_sd];
            
            UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
            
            pirceLabel.text = @"￥120";
            
            pirceLabel.textAlignment  = NSTextAlignmentLeft;
            
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 2];
            
            NSString * numStreing  = [NSString stringWithFormat:@"%ld",(long)mapmodel.price];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",numStreing]];
            
            UIColor * color;
            
            color = COLOR(255, 70, 78, 1);
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(0, numStreing.length + 1)];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 3]
             
                                  range:NSMakeRange(0, numStreing.length + 1)];
            
            
            
            
            pirceLabel.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:pirceLabel];
            
            
            
            UILabel * pirceLabel_other = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x + pirceLabel.frame.size.width, nameLabel_sd.frame.origin.y + 30 + 7.5, nameLabel_sd.frame.size.width/3 * 2 + 15, 30)];
            
            
            pirceLabel_other.text = @"";
            
            
            pirceLabel_other.textAlignment  = NSTextAlignmentLeft;
            
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 3];
            
            
            NSString * PIstring = [NSString stringWithFormat:@"￥%ld      配送费:￥%ld",(long)mapmodel.oldPrice,(long)mapmodel.deliver_fee];
            
            NSString *linString = [NSString stringWithFormat:@"%ld",(long)mapmodel.oldPrice];
            
            
            NSMutableAttributedString *AttributedStr_ = [[NSMutableAttributedString alloc]initWithString:PIstring];
            
            
            
            [AttributedStr_ addAttribute:NSForegroundColorAttributeName
             
                                   value:[UIColor lightGrayColor]
             
                                   range:NSMakeRange(0, AttributedStr_.length)];
            
            
            
            
            [AttributedStr_ addAttribute:NSStrikethroughStyleAttributeName
             
                                   value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
             
                                   range:NSMakeRange(0, linString.length + 1)];
            
            
            pirceLabel_other.attributedText = AttributedStr_;
            
            
            [cell.contentView addSubview:pirceLabel_other];
            
            
            
            
            UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x , pirceLabel.frame.origin.y + pirceLabel.frame.size.height + 5, nameLabel_sd.frame.size.width  , 30)];
            
            NSString * allString = [NSString stringWithFormat:@"%ld",(long)mapmodel.real_price];
            
            NSString * allString_one = [NSString stringWithFormat:@"%ld",(long)mapmodel.quantity];
            
            allLabel.textAlignment  = NSTextAlignmentLeft;
            
            allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 3];
            
            NSString * String = [NSString stringWithFormat:@"总额 ￥%@       X %@",allString,allString_one];
            
            
            NSMutableAttributedString * AttributedSt = [[NSMutableAttributedString alloc]initWithString:String];
            
            
            
            allLabel.textColor = [UIColor lightGrayColor];
            
            
            
            [AttributedSt addAttribute:NSForegroundColorAttributeName
             
                                 value:color
             
                                 range:NSMakeRange(3, allString.length + 1)];
            
            
            
            [AttributedSt addAttribute:NSFontAttributeName
             
                                 value:[UIFont systemFontOfSize:allLabel.font.pointSize + 3]
             
                                 range:NSMakeRange(3, allString.length + 1)];
            
            
            
            allLabel.attributedText = AttributedSt;
            
            
            [cell.contentView addSubview:allLabel];
            
            
            if(row == _data_wanfahuoArr.count -1){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }
            
        }if(row == _data_wanfahuoArr.count){
            
            LPCqingdanxiangMap * mapModel = _data_wanfahuoArr_two[0];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
            label.text = @"  订单信息";
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.textColor = [UIColor lightGrayColor];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
            
            [cell.contentView addSubview:label];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44+5, 39/3, 66/3)];
            
            imageView.image = [UIImage imageNamed:@"c2_ditu"];
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5+44, SCREEN_WIDTH - 30, 15)];
            
            NSString * string_name = [NSString stringWithFormat:@"收货人 :    %@",mapModel.user_name];
            
            if(![string_name isEqualToString:@"收货人 :    (null)"] && ![ string_name isEqualToString:@"收货人 :    <null>"]){
                
                namelabel.text = string_name;
                
            }
            
            namelabel.textAlignment = NSTextAlignmentLeft;
            
            namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
            
            [cell.contentView addSubview:namelabel];
            
            UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 44+5, SCREEN_WIDTH - 35, 15)];
            
            telLabel.text = mapModel.telphone;
            
            telLabel.textAlignment = NSTextAlignmentRight;
            
            telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
            
            [cell.contentView addSubview:telLabel];
            
            
            UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
            
            NSString *add_string = [NSString stringWithFormat:@"%@%@",mapModel.place_address,mapModel.detail_address];
            
            if(![add_string isEqualToString:@"(null)(null)"]){
                
                addressLabel.text = add_string;
            }
            
            
            addressLabel.textColor = [UIColor lightGrayColor];
            
            addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
            
            addressLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:addressLabel];
            
            
            NSMutableArray * dataArr = [NSMutableArray array];
            
            [dataArr addObject:[NSString stringWithFormat:@"  创建时间 :  %@",mapModel.create_time]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  付款时间 :  %@",mapModel.pay_time]];
            
            
            
            NSString * string_paywasy = @"";
            
            if(mapModel.pay_way == 0){
                
                string_paywasy = @"未支付";
                
                
                
            }
            if(mapModel.pay_way == 1){
                
                string_paywasy = @"余额";
                
            }
            if(mapModel.pay_way == 2){
                
                string_paywasy = @"支付宝";
                
            }
            if(mapModel.pay_way == 3){
                
                string_paywasy = @"微信";
                
            }
            
            [dataArr addObject:[NSString stringWithFormat:@"  支付方式 :  %@",string_paywasy]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  数      量 : %ld",(long)mapModel.quantity]];
            
            
            NSString * string_fangshi = @"";
            
            if(mapModel.is_deliver_fee == 1){
                
                if(mapModel.is_pickup == 0){
                    
                    string_fangshi = @"快递";
                    
                }else {
                    
                    string_fangshi = @"自提";
                    
                }
                
                
            }
            
            [dataArr addObject:[NSString stringWithFormat:@"  配送方式 : %@",string_fangshi]];
            
            [dataArr addObject:[NSString stringWithFormat:@"   配 送 费 :￥%ld",(long)mapModel.deliver_fee]];
            
            [dataArr addObject:[NSString stringWithFormat:@"  总      额  : ￥%ld",(long)mapModel.real_price]];
            
            
            
            
            for(int i = 0 ; i < dataArr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 + addressLabel.frame.size.height + addressLabel.frame.origin.y , SCREEN_WIDTH, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = dataArr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                
                [cell.contentView addSubview:label];
                
                
            }
            
            
        }if(row == _data_wanfahuoArr.count + 1){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            
            label.text = @"  快递信息";
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.textColor = [UIColor lightGrayColor];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
            
            [cell.contentView addSubview:label];
            
            
            UILabel * numlabe=  [[UILabel alloc]initWithFrame:CGRectMake(0, 30 + 5, SCREEN_WIDTH, 30)];
            
            numlabe.tag = 1000;
            
            numlabe.textColor = [UIColor lightGrayColor];
            
            numlabe.text =[NSString stringWithFormat:@"  快递公司:%@",_express.express_name];
            
            numlabe.font = [UIFont systemFontOfSize:numlabe.font.pointSize - 4];
            
            [cell.contentView addSubview:numlabe];
            
            
            UILabel * numlabe_ine =  [[UILabel alloc]initWithFrame:CGRectMake(0, 70 , SCREEN_WIDTH, 30)];
            
            numlabe_ine.tag = 1001;
            
            numlabe_ine.textColor = [UIColor lightGrayColor];
            
            numlabe_ine.text = [NSString stringWithFormat:@"  运单号:%ld",(long)_express.express_code];
            
            numlabe_ine.font = [UIFont systemFontOfSize:numlabe_ine.font.pointSize - 4];
            
            [cell.contentView addSubview:numlabe_ine];
            
            
        }
        
        
    }
    
    
    
    return cell;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
 
    if([_string isEqualToString:@"2"]){
        
        if(_data_weifahuoArr.count ==0 ){
            
            return _data_weifahuoArr.count;
            
        }
        
        return _data_weifahuoArr.count + 2;
    }
    
    if([_string isEqualToString:@"3"]){
        
        if(_data_yifahuoArr.count ==0 ){
            
            return _data_yifahuoArr.count;
            
        }
        
        
        if(_express.express_name !=nil && ![_express.express_name isEqualToString:@""] && ![_express isEqual:[NSNull null]] && _express !=nil ){
            
            return _data_yifahuoArr.count + 3;
        }
       
        
        if([_cause.userName isEqualToString:@""] || _cause == nil){
            
            return _data_yifahuoArr.count + 1;
            
        }
        
        return _data_yifahuoArr.count + 2;
        
    }
    
    if([_string isEqualToString:@"4"]){
        
        if(_data_wanfahuoArr.count ==0 ){
            
            return _data_wanfahuoArr.count;
            
        }
        if(_express.express_name !=nil && ![_express.express_name isEqualToString:@""] && ![_express isEqual:[NSNull null]] && _express !=nil){
            
            return _data_wanfahuoArr.count + 3;
        }
       
        return _data_wanfahuoArr.count + 2;
        
    }
        
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_string isEqualToString:@"2"]){
        
        if(_data_weifahuoArr.count ==0 ){
            
            return 0;
            
        }
        if(_data_weifahuoArr.count -1 == indexPath.row){
            
            return 120 + 44;
            
        } if(_data_weifahuoArr.count  == indexPath.row){
            
            return 215+7*4;
            
        }if(_data_weifahuoArr.count +1  == indexPath.row){
            
            return 100;
            
        }

        
        
    }
    
    if([_string isEqualToString:@"3"]){
        
        if(_data_yifahuoArr.count ==0 ){
            
            return 0;
            
        }
        if(_data_yifahuoArr.count -1 == indexPath.row){
            
            return 120 + 44;
            
        } if(_data_yifahuoArr.count  == indexPath.row){
            
            if([_cause.userName isEqualToString:@""] || _cause == nil){
                
                return 215+7*4;
            }else {
                
                  return 120;
                
            }
            
          
            
        }if(_data_yifahuoArr.count +1  == indexPath.row){
            
            if([_express.express_name isEqualToString:@""]){
                
                return 215+7*4;
                
            }else {
                
                
                
                return 100;

                
            }
            
            
        }if(_data_yifahuoArr.count +2  == indexPath.row){
            
            return 215+7*4;
            
        }
        
    }
    
    
    if([_string isEqualToString:@"4"]){
        
        if(_data_wanfahuoArr.count ==0 ){
            
            return 0;
            
        }
        if(_data_wanfahuoArr.count -1 == indexPath.row){
            
            return 120 + 44;
            
        } if(_data_wanfahuoArr.count  == indexPath.row){
            
            return 215+7*4;
            
        }if(_data_wanfahuoArr.count +1  == indexPath.row){
            
            return 100;
            
        }
        
        
        
    }
    
    
    return 120;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = self.TableView.backgroundColor;
    
    
    if([_string isEqualToString:@"2"]){
        
        if(self.data_weifahuoArr.count == 0){
            
            return view;
        }
        
        
        LPCqingdanxiangMap  * dic = _data_weifahuoArr[0];
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",dic.order_code];
        
        orlderLabel.text = orderSreing;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
        
        

        
        [imageView_sd sd_setImageWithURL:[NSURL URLWithString:dic.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        
        
        [view addSubview:imageView_sd];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        nameLabel.text = dic.nick_name;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel];
        
        
        
    }
    
    if([_string isEqualToString:@"3"]){
        
        if(self.data_yifahuoArr.count == 0){
            
            return view;
        }
        
        
        LPCqingdanxiangMap  * dic = self.data_yifahuoArr[0];
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",dic.order_code];
        
        orlderLabel.text = orderSreing;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        
        [imageView_sd sd_setImageWithURL:[NSURL URLWithString:dic.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        
        
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
        
        [view addSubview:imageView_sd];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        nameLabel.text = dic.nick_name;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel];
        
        
        
    }
    
    
    if([_string isEqualToString:@"4"]){
        
        if(self.data_wanfahuoArr.count == 0){
            
            return view;
        }
        
        
        LPCqingdanxiangMap  * dic = _data_wanfahuoArr[0];
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",dic.order_code];
        
        orlderLabel.text = orderSreing;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
        
        [imageView_sd sd_setImageWithURL:[NSURL URLWithString:dic.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        
        
        [view addSubview:imageView_sd];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        nameLabel.text = dic.nick_name;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel];

    }
    
    return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
    
}


#pragma mark 确认完成
-(void)button_OK{
    
    
}

#pragma mark 确认发货
-(void)button_click{
    
    LPCgoodsfahuoVC * viewContrller = [LPCgoodsfahuoVC new];
    
    viewContrller.delegate = _object;
    
    viewContrller.idstring = _idstring;
    
    viewContrller.section = _section;
    
    
     if([_is_pickup_string isEqualToString:@"1"]){
     
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否确认发货该订单?" preferredStyle:UIAlertControllerStyleAlert];
         
         
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
             
             dispatch_after(0.2, dispatch_get_main_queue(), ^{
                 
                 [SHARE_APP showHud];
                 // 自提
                 NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
                 
                 NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
                 
                 
                 NSDictionary * dic_request = @{@"orderCode":_idstring ,@"siId":user_id,@"orderState":@"3",@"type":@3};
                 
                 [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                     
                     
                     NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                     
                     if([[self headdic:dic_json] isEqualToString:@"0"]){
                         
                         
                         [self MBShow:@"自提成功" backview:self.view];
                         
                         [self performSelector:@selector(next_one) withObject:self afterDelay:.5];
                         
                         return ;
                     }
                     
                     [self MBShow:@"自提失败,请重新确认" backview:self.view];
                     
                 } failure:^(NSError *error) {
                     
                     [self MBShow:@"服务器繁忙" backview:self.view];
                     
                 }];
                 

                 
                 
             });
             
             
         }];
         
         [alertController addAction:okAction];
         
         UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
         
         [alertController addAction:canleAction];
         
         
         [self presentViewController:alertController animated:true completion:nil];
         
         
      
     }else {
     
     [self push:viewContrller];
     
     }

   
    
}

-(void)next_one{
    
    if([self.object respondsToSelector:@selector(chooserefre:)]){
        
        [self.object chooserefre:@"待发货"];
        
        [self.navigationController popViewControllerAnimated:true];
    }
    
}
#pragma mark 字典初始化
/**
 *  字典初始化
 *
 *  @param dict 字典
 */
-(void)dictalloc:(NSMutableDictionary *)dict{
    
   
    
}
#pragma mark 驳回退款请求
-(void)shangpinbohuituikuaiqingqiu:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            LPCqingdanxiangMap  * dic = _data_yifahuoArr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":dic.order_code ,@"shopInformationId":user_id,@"orderState":@10};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self performSelector:@selector(next) withObject:self afterDelay:1];
                    
                    return ;
                }
                
                [self MBShow:@"驳回失败,请重新审核" backview:self.view];
                
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
#pragma mark 去审核
-(void)qushenhe:(UIButton *)sender{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
           
            LPCqingdanxiangMap  * dic = _data_yifahuoArr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":dic.order_code ,@"shopInformationId":user_id,@"orderState":@7};
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"审核成功" backview:self.view];
                    
                    [self performSelector:@selector(next) withObject:self afterDelay:1];
                    
                    return ;
                }
                
                [self MBShow:@"审核失败,请重新审核" backview:self.view];
                
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

#pragma mark 确认收货
-(void)shouhuo:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否确认收货该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            LPCqingdanxiangMap  * dic = _data_yifahuoArr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":dic.order_code ,@"shopInformationId":user_id,@"orderState":@8};
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"收货成功" backview:self.view];
                    
                    [self performSelector:@selector(next) withObject:self afterDelay:1];
                    
                    return ;
                }
                
                [self MBShow:@"收货失败,请重新收货" backview:self.view];
                
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

#pragma mark 去退款
#pragma mark 商品的去退款
-(void)qutuikuai:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            LPCqingdanxiangMap  * dic = _data_yifahuoArr[0];

            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * user_user = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dic_request = @{@"orderCode":dic.order_code
                                           ,@"shopUserId":user_user,
                                           @"orderState":@"9",
                                           @"type":@"3",
                                           @"useId":[NSNumber numberWithLongLong:dic.user_id],
                                           @"balance":[NSNumber numberWithLongLong:dic.real_price],//real_price
                                           @"siId":user_id
                                           };
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self next];
                    
                    return ;
                }
                
                [self MBShow:@"退款失败,请重新确认" backview:self.view];
                
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
-(void)next{
    
    if([self.object respondsToSelector:@selector(chooserefre:)]){
        
        [self.object chooserefre:@"已发货"];
        
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
