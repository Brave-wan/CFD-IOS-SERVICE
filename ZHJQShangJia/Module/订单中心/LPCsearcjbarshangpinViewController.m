//
//  LPCsearcjbarshangpinViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/10.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCsearcjbarshangpinViewController.h"

@interface LPCsearcjbarshangpinViewController ()<typededategele,jiudiandeshenhe,fandiantuikuaideshenhe,fandiandelegate,ClickReusetDelegate,cliclkSecyionDelegate,UITextFieldDelegate>

@end

@implementation LPCsearcjbarshangpinViewController

-(void)chooserefre:(NSString *)type{
    
    [self  request:1];
}

-(void)jiudiandeshenhetuikuai:(NSString *)type{
    
    [self request:1];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self left];
    
    // 饭店
    
    _searchBar = [[LPCCustomTextFild alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH -100, 30)];
    
    _searchBar.placeholder = @"  订单号(须不少于8位)、下单人";
    
    [_searchBar setValue:COLOR(61, 162, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    _searchBar.returnKeyType= UIReturnKeySearch;
    
    [_searchBar setValue:[UIFont systemFontOfSize:_searchBar.font.pointSize -4] forKeyPath:@"_placeholderLabel.font"];
    
    _searchBar.font = [UIFont systemFontOfSize:_searchBar.font.pointSize - 4];
    
    [_searchBar setBackgroundColor:COLOR(26, 122, 187, 1)];
    
    _searchBar.layer.masksToBounds = true;
    
    _searchBar.delegate = self;
    
    _searchBar.layer.cornerRadius = _searchBar.frame.size.height/2;
    
    _searchBar.leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, _searchBar.frame.size.height)];
    
    _searchBar.textColor = [UIColor whiteColor];
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView * rihgt = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, _searchBar.frame.size.height)];
    
    rihgt.image = [UIImage imageNamed:@"a2_sousuo"];
    
    rihgt.contentMode = UIViewContentModeCenter;
    
    rihgt.userInteractionEnabled = true;
    
    UITapGestureRecognizer* singleRecognizer;
    
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    
    singleRecognizer.numberOfTapsRequired = 1;
    
    [rihgt addGestureRecognizer:singleRecognizer];
    
    
    _searchBar.rightView = rihgt;
    
    _searchBar.rightViewMode = UITextFieldViewModeAlways;
    
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    self.navigationItem.titleView = _searchBar;
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([self stringisPureNull:textField.text] == true){
        
        _string_search = _searchBar.text ;
        
        if([self isPureNumandCharacters:textField.text] == true){
            
            _isNumber = YES;
            
            [self request:textField.text type:@"数字" isfrese:1];
            
        }else {
            
            _isNumber = NO;
            
            [self request:textField.text type:@"字符串" isfrese:1];
            
        }
        
    }else {
        
        
        [self MBShow:@"请填写下单人、订单号" backview:self.view];
        
    }
    
    return true;
    
}

-(void)handleSingleTapFrom{
    
    if([self stringisPureNull:_searchBar.text] == true){
        
        _string_search = _searchBar.text ;
        
        if([self isPureNumandCharacters:_searchBar.text] == true){
            
            _isNumber = YES;
            
            [self request:_searchBar.text type:@"数字" isfrese:1];
            
            
        }else {
            
            _isNumber = YES;
            
            [self request:_searchBar.text type:@"字符串" isfrese:1];
            
        }
        
    }else {
        
        [self MBShow:@"请填写下单人、订单号" backview:self.view];
        
    }
    
}
#pragma mark 网络请求
-(void)request:(NSString *)string type:(NSString *)type isfrese:(int)isfrese{
    
    [_searchBar resignFirstResponder];
    
    [SHARE_APP showHud];
    
    NSDictionary * dict = [NSDictionary dictionary];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    if([type isEqualToString:@"数字"]){
        
        dict  = @{@"siId":user_id,
                  
                  @"orderCode":string,
                  
                  @"type":[user  objectForKey:@"shopId"],
                  
                  @"name":@""
                  
                  };
        
    }if([type isEqualToString:@"字符串"]){
        
        dict  = @{@"siId":user_id,
                  
                  @"orderCode":@"",
                  
                  @"type":[user  objectForKey:@"shopId"],
                  
                  @"name":string
                  
                  };
        
    }
    
    _dataSouceArr_one  = [NSMutableArray array];
    
    _dataSouceArr  = [NSMutableArray array];
    
    
    [ZHJQHttpToll GET:LPCDINGDANSOUS  parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary * dic_list = dic_json[@"data"];
        
        if(![dic_list isEqual:[NSNull null]] && dic_list !=nil){
            
            NSMutableArray * dataS = dic_list[@"orderList"];
            
            if(dataS != nil && ![dataS isEqual:[NSNull null]] && dataS.count != 0){
                
                [SHARE_APP hideHud];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
            
                    for(NSMutableArray * arr in dataS){
                        
                        for(NSDictionary * dic_data in arr){
                            
                            if([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"0"]){
                                
                                [_dataSouceArr addObject:dic_data];
                                
                                
                            }else if ([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"1"]){
                                
                                [_dataSouceArr_one addObject:dic_data];
                                
                            }
                            
                        }
                        
                    }

                    if(isfrese == 2){
                        
                        [self.MytableView.mj_header endRefreshing];
                        
                    }
                    
                    [_MytableView reloadData];
                    
                    return ;
                }
                
                [self MBShow:@"暂无数据" backview:self.view];
                
                return;
            }
            [self MBShow:@"暂无数据" backview:self.view];
            
            return;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Creat_UI{
    
    if(_MytableView == nil){
        
        _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height )];
        
        _MytableView.delegate = self;
        
        _MytableView.dataSource = self;
        
        _MytableView.tableFooterView = [UIView new];
        
        _MytableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
            
            [_MytableView.mj_header beginRefreshing];
            
            [self request:2];
            
        }];
        
        
        
        [self.view addSubview:_MytableView];
        
    }
    
    
    
    
    _dataSouceArr =[NSMutableArray array];
    
    _dataSouceArr_one =[NSMutableArray array];
}



-(void)viewDidLayoutSubviews {
    
    if ([self.MytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MytableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.MytableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MytableView setLayoutMargins:UIEdgeInsetsZero];
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

    if(_dataSouceArr.count > 0){
        
        NSDictionary * moel = _dataSouceArr[row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:moel[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        
        
        if([[NSString stringWithFormat:@"%@",moel[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",moel[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: moel[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [cell.contentView  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",moel[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",moel[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",moel[@"nick_name"]] ;
        }
        
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_one];
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.origin.y + nameLabel_one.frame.size.height+ 14, 110, 90)];
        
        if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"describe_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"describe_img"]] isEqualToString:@"<null>"]){
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
            
            
        }else {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:moel[@"describe_img"] ] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
        }
        
        
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel_sd.text = [self getstring:[NSString stringWithFormat:@"%@",moel[@"goods_name"]]];
        
        nameLabel_sd.textAlignment = NSTextAlignmentLeft;
        
        nameLabel_sd.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_sd];
        
        UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
        
        pirceLabel.text = @"￥120";
        
        pirceLabel.textAlignment  = NSTextAlignmentLeft;
        
        pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 4];
        
        NSString * numStreing  = [NSString stringWithFormat:@"%@",moel[@"real_price"]];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",numStreing]];
        
        UIColor * color;
        
        color = COLOR(255, 70, 78, 1);
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(0, numStreing.length + 1)];
        
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 2]
         
                              range:NSMakeRange(0, numStreing.length + 1)];
        
        
        
        pirceLabel.attributedText = AttributedStr;
        
        [cell.contentView addSubview:pirceLabel];
        
        UILabel * pirceLabel_other = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x + pirceLabel.frame.size.width, nameLabel_sd.frame.origin.y + 30 + 7.5, nameLabel_sd.frame.size.width/3 * 2 + 15, 30)];
        
        pirceLabel_other.text = @"";
        
        pirceLabel_other.textAlignment  = NSTextAlignmentLeft;
        
        pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 5];
        
        NSString * PIstring= [NSString stringWithFormat:@"￥%@      配送费:￥%@",moel[@"goods_price"],moel[@"deliver_fee"]];
        
        NSString *linString = [NSString stringWithFormat:@"%@",moel[@"goods_price"]];
        
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
        
        NSString * allString = [NSString stringWithFormat:@"%@",moel[@"real_price"]];
        
        NSString * allString_one = [NSString stringWithFormat:@"%@",moel[@"quantity"]];
        
        allLabel.textAlignment  = NSTextAlignmentLeft;
        
        allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 4];
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
        
        
        NSInteger  ststus = [[self getstring:[NSString stringWithFormat:@"%@",moel[@"order_state"]]] integerValue];
        
        
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.origin.y + allLabel.frame.size.height, SCREEN_WIDTH, .5)];
        
        henglabel.backgroundColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
        
        if(ststus == 1){
            
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"未支付" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            
            
            
        }
        
        
        if(ststus == 2){
            
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"确认发货" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            [button addTarget:self action:@selector(shangpinquerenfahuo:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        if(ststus == 3 || ststus == 4){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"已发货" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        
        
        if(ststus == 5){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"已完成" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        
        
        if(ststus == 6){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"同意退款" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            [button addTarget:self action:@selector(shangpintongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            
            
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
            
            
            
        }
        
        
        if( ststus == 7){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"退款中" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        } if(ststus == 8){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"去退款" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            [button addTarget:self action:@selector(qutuikuai:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        
        if(ststus == 9){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"退款成功" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        
        
        if(ststus == 10){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"已驳回退款" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
        
        if(ststus == 11){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.size.height + allLabel.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"待收货" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            [button addTarget:self action:@selector(shangpindaishouhou:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
        }
        
    }
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    LPCGoodsDeliteViewController * ViewController = [[LPCGoodsDeliteViewController alloc]init];
    
    NSDictionary * dic_t = _dataSouceArr[indexPath.row];
    
    NSInteger status = [[self getstring:[NSString stringWithFormat:@"%@",dic_t[@"order_state"]]] integerValue];
    
    
    // 未完成 (状态值需要数据返回)
    if(status == 2){
        
        
        // 发货
        ViewController .string = @"2";
        
        
        ViewController.string_id = [NSString stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.object = self;
        
        ViewController.is_pickup_string = [NSString stringWithFormat:@"%@",dic_t[@"is_pickup"]];
        
        ViewController.idstring = [NSString  stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.section = section;
        
        
        [self push:ViewController];
        
    } else
        if(status == 4){
            
            
            // 完成
            ViewController .string = @"4";
            
            
            ViewController.string_id = [NSString stringWithFormat:@"%@",dic_t[@"order_code"]];
            
            ViewController.object = self;
            
            ViewController.idstring = [NSString  stringWithFormat:@"%@",dic_t[@"order_code"]];
            
            ViewController.section = section;
            
            
            [self push:ViewController];
            
            
        }else  {
            
            
            // 发货
            ViewController .string = @"3";
            
            
            
            
            ViewController.string_id = [self getstring:[NSString stringWithFormat:@"%@",dic_t[@"order_code"]]];
            
            ViewController.object = self;
            
            ViewController.idstring = [self getstring:[NSString  stringWithFormat:@"%@",dic_t[@"order_code"]]];
            
            ViewController.section = section;
            
            if([[self getstring:[NSString  stringWithFormat:@"%@",dic_t[@"order_state"]]] isEqualToString:@"6"] ||[[self getstring:[NSString  stringWithFormat:@"%@",dic_t[@"order_state"]]] isEqualToString:@"11"] ){
                
                
                ViewController.object = self;
                
            }
            
            
            [self push:ViewController];
            
        }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataSouceArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 + 44 *2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * backIEW = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, .5)];
    
    backIEW.backgroundColor = [UIColor grayColor];
    
    [view addSubview:backIEW];
    
    
    
    return view;
}

#pragma mark  ======================= 商品 确认发货、（开始）==================
#pragma mark 商品确认发货
-(void)shangpinquerenfahuo:(UIButton *)sender{
    
    NSDictionary * dict = _dataSouceArr[sender.tag];
    
    LPCgoodsfahuoVC * Vc = [LPCgoodsfahuoVC new];
    
    Vc.delegate = self;
    
    Vc.ord_type = [self getstring:[NSString stringWithFormat:@"%@",dict[@"order_state"]]];
    
    Vc.idstring = [self getstring:[NSString  stringWithFormat:@"%@",dict[@"order_code"]]];
    
    Vc.section = sender.tag;
    
    
    if([[self getstring:[NSString stringWithFormat:@"%@",dict[@"is_pickup"]]] isEqualToString:@"1"]){
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"该订单确认发货?" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                
                [SHARE_APP showHud];
                
                // 自提
                NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
                
                NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
                
                
                NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dict[@"order_code"]]] ,@"siId":user_id,@"orderState":@"3",@"type":@3};
                
                [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                    
                    
                    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    if([[self headdic:dic_json] isEqualToString:@"0"]){
                        
                        
                        [self MBShow:@"自提成功" backview:self.view];
                        
                        [self request:1];
                        
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
        
        [self push:Vc];
    }
    
    
}
#pragma mark 商品同意退款
-(void)shangpintongyituikuai:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary * dic = _dataSouceArr[sender.tag];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"shopInformationId":user_id,@"orderState":@7};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"审核成功" backview:self.view];
                    
                    [self request:1];
                    
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

#pragma mark 商品驳回退款请求
-(void)shangpinbohuituikuaiqingqiu:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary * dic = _dataSouceArr[sender.tag];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"shopInformationId":user_id,@"orderState":@10};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self request:1];
                    
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
#pragma mark 商品的去退款
-(void)qutuikuai:(UIButton *)sender{
    
    NSDictionary * dict = _dataSouceArr[sender.tag];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * user_user = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dict[@"order_code"]]]
                                           ,@"shopUserId":user_user,
                                           @"orderState":@"9",
                                           @"type":@"3",
                                           @"useId":[self getstring:[NSString stringWithFormat:@"%@",dict[@"userId"]]],
                                           @"balance":[self getstring:[NSString stringWithFormat:@"%@",dict[@"real_price"]]],//real_price
                                           @"siId":user_id
                                           };
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self request:1];
                    
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

#pragma 商品商家待收货
-(void)shangpindaishouhou:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认该订单收货?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSDictionary * dic = _dataSouceArr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            
            NSDictionary * dic_request = @{@"orderCode":[NSString stringWithFormat:@"%@",dic[@"order_code"]] ,@"shopInformationId":user_id,@"orderState":@8};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"收货成功" backview:self.view];
                    
                    [self request:1];
                    
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
//确认发货的协议
- (void)chooseclick:(NSInteger )type_section{
    
    [self request:1];
}
#pragma mark 饭店的未使用的协议
-(void)fandianhuidiao:(NSString *)type one:(NSString *)onetwo{
    
    [self request:1];
    
}
#pragma mark饭店退款成功的协议
- (void)fandiantuikuaishenhe{
    
    [self request:1];
    
}

-(void)request:(int)isfrese{
    
    if(_isNumber == true){
        
        //数字
        [self request:_string_search type:@"数字" isfrese:isfrese];
        
    }else {
        
        // 字符串
        [self request:_string_search type:@"字符串" isfrese:isfrese];
    }
    
}
#pragma mark  ======================= 酒店 验证、取消、申请退款、驳回退款 （结束）==================

/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的值
 *
 *  @return YES ? NO
 */
-(BOOL)stringisPureNull:(NSString *)string{
    
    if([string isEqualToString:@""]){
        
        return false;
        
    }
    
    return true;
    
}

/**
 * 判断字符串是否是纯数字
 *
 *  @param string 需要判断的值
 *
 *  @return YES ? NO
 */
-(BOOL)isPureNumandCharacters:(NSString *)string
{
    // 得到的字符串 为汉字
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    
    if(string.length > 0)
    {
        return NO;
    }else {
        
                
        
        return YES;
    }
    
    
    return NO;
}

@end
