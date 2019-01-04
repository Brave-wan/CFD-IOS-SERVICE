//
//  LPCSearBarViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSearBarViewController.h"
#import "IQKeyboardManager.h"
#import "LPCsearchbarjiudianModel.h"
@interface LPCSearBarViewController ()<UITextFieldDelegate>



@end

@implementation LPCSearBarViewController

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
    
    
    
    [ZHJQHttpToll GET:LPCDINGDANSOUS  parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        self.dataSouceArr = [NSMutableArray array];
        
        NSDictionary * dic_list = dic_json[@"data"];
        
        if(![dic_list isEqual:[NSNull null]] && dic_list !=nil){
            
            NSMutableArray * dataS = dic_list[@"orderList"];
            
            if(dataS != nil && ![dataS isEqual:[NSNull null]] && dataS.count != 0){
                
                [SHARE_APP hideHud];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    for(NSMutableArray * arr in dataS){
                        

                            [self.dataSouceArr addObject:arr];

                        
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
     
        [self.MytableView.mj_header endRefreshing];

        
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
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    NSUInteger  section  = indexPath.section;
    
    NSMutableArray  * data_Arr = _dataSouceArr[section];
    
    
    NSDictionary  *dic = data_Arr[row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]] placeholderImage:[UIImage imageNamed:@"b1_tu1"]];
    
    
    [cell.contentView addSubview:imageView];
    
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
    
    NSString * shangpinname = [NSString stringWithFormat:@"%@",dic[@"goods_name"]];
    
    if([[self getstring:shangpinname] isEqualToString:@""]){
        
        nameLabel.text =@"" ;//model.name;
    }else {
        nameLabel.text =dic[@"goods_name"] ;//model.name;
        
    }
    
    
    
    
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    nameLabel.adjustsFontSizeToFitWidth = true;
    
    [cell.contentView addSubview:nameLabel];
    
    
    
    UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
    
    timeLaebl.textAlignment = NSTextAlignmentLeft;
    
    
    timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]];

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
    
    
    if( row == data_Arr.count-1 ){
        
        UILabel  * henLable = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.size.height + allLable.frame.origin.y, SCREEN_WIDTH, .4)];
        
        
        henLable.backgroundColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:henLable];

        
        
        NSInteger status = [[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_state"]]] integerValue];
        
        if(status == 1){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"待支付" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
        }
        
        // 订单状态（1确认订单，2未使用 3申请退款 4已使用 5已过期 6申请退款成功 7申请退款失败）
        if(status == 2){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"验证核销" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            [button addTarget:self action:@selector(yanzhenghexiao:) forControlEvents:UIControlEventTouchUpInside];
            
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            NSInteger status_danpin = [[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] integerValue];
            
            if(status_danpin == 1){
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
                
                
                [button_one addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
            }
            
           
            
        }
        if(status == 3){
            
            // 0 单品  1 套餐
            NSInteger   sttype =  [[self  getstring:[NSString  stringWithFormat:@"%@",dic[@"goods_type"]]] integerValue];

            
            if(sttype == 0){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90 -30, 7 + allLable.frame.size.height + allLable.frame.origin.y, 100, 30)];
                
                [button setBackgroundColor:[UIColor  lightGrayColor]];
                
                [button setTitle:@"单品不允许退款" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }if(sttype == 1){
                
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"同意退款" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                [button addTarget:self action:@selector(jiudianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
                
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"驳回请求" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
                
                
                [button_one addTarget:self action:@selector(jiudianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
            }
            
            
        }
        // 订单状态（1确认订单，2未使用 3申请退款 4已使用 5已过期 6申请退款成功 7申请退款失败）

        if(status == 4){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"已使用" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
        if(status == 5){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"已过期" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
        if(status == 6){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"退款成功" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
        if(status == 7){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"驳回退款" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
       
        
    }
    


    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPCHoteEatDeleViewController * eatViewController = [[LPCHoteEatDeleViewController alloc]init];

    
    LPCHotelYesViewController  * JDViewcontroller = [[LPCHotelYesViewController alloc]init];
    
    LPCHoteloverViewController  * overViewControllerr = [[LPCHoteloverViewController alloc]init];
    
    
    NSString  * idString = @"";
    
    NSMutableArray * data_Arr = _dataSouceArr[indexPath.section];
    
    NSDictionary * dic = data_Arr[0];
    
    // 获取订单的状态值 以确定按钮的展示
    
    NSInteger  status = [[NSString stringWithFormat:@"%@",dic[@"order_state"]] integerValue];
    
    if(status == 2){
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        eatViewController.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        eatViewController.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            eatViewController.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            eatViewController.oneTwo = @"2";
        }
        
        
        
        eatViewController.object = self;
        
        [self push:eatViewController];
        
    }if(status == 3){
        
        // 申请退款
        
        fandiantukuaidingdanVCViewController * oneViewconroller_fandian = [fandiantukuaidingdanVCViewController new];
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        oneViewconroller_fandian.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        oneViewconroller_fandian.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            oneViewconroller_fandian.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            oneViewconroller_fandian.oneTwo = @"2";
        }
        
        oneViewconroller_fandian.object = self;
        
        [self push:oneViewconroller_fandian];
        
        
    }if(status == 4){
        
        // 已使用
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        JDViewcontroller.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        JDViewcontroller.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            JDViewcontroller.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            JDViewcontroller.oneTwo = @"2";
        }
        
        [self push:JDViewcontroller];
        
    }if(status == 5){
        
        // 已过期
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        overViewControllerr.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        overViewControllerr.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            overViewControllerr.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            overViewControllerr.oneTwo = @"2";
        }
        
        [self push:overViewControllerr];
        
        
    }if(status == 6){
        
        // 退款成功
        
        
        LPCZHFDNoViewController * viewcontroller_one = [[LPCZHFDNoViewController alloc]init];
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        viewcontroller_one.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        viewcontroller_one.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            viewcontroller_one.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            viewcontroller_one.oneTwo = @"2";
        }
        
        viewcontroller_one.string_paye = @"退款成功";
        
        
        
        [self push:viewcontroller_one];
        
        
    }if(status == 7){
        
        // 退款失败
        
        LPCZHFDNoViewController * viewcontroller_one = [[LPCZHFDNoViewController alloc]init];
        
        idString = [NSString stringWithFormat:@"%@",dic[@"order_code"]];
        
        NSString * type_goods = [NSString stringWithFormat:@"%@",dic[@"goods_type"]];
        
        viewcontroller_one.imageUrl = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
        
        viewcontroller_one.idString = idString;
        
        if([type_goods isEqualToString:@"0"]){
            
            viewcontroller_one.oneTwo = @"1";
            
        }if([type_goods isEqualToString:@"1"]){
            
            viewcontroller_one.oneTwo = @"2";
        }
        
        viewcontroller_one.string_paye = @"退款失败";
        
        [self push:viewcontroller_one];
        
        
    }
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray * data = _dataSouceArr[section];
    
    return data.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *data = _dataSouceArr[indexPath.section];
    
    if(indexPath.row == data.count-2){
        
        return 120;
        
    }
    
    return 120 + 44 *1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return _dataSouceArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * backIEW = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    backIEW.backgroundColor = COLOR(237, 242, 249, 1);
    
    [view addSubview:backIEW];
    
    
    NSMutableArray * data = _dataSouceArr[section];
        
    NSDictionary *dic = data[0];
        
    UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 +5, SCREEN_WIDTH -10, 30)];
        
    orlderLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
    orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7+5, 30, 30)];
        
        
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7+5, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
    
    
    return view;
}

#pragma mark  ======================= 酒店 验证、取消、申请退款、驳回退款 （开始）==================
#pragma mark 验证
-(void)yanzhenghexiao:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray * Arr = [NSMutableArray array];
            
            Arr = _dataSouceArr[sender.tag];
            
            NSDictionary * dic_darr = Arr[0];
            
            NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"]};
            
            [ZHJQHttpToll GET:LPCFANDIANYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"验证该订单成功" backview:self.view];
                    
                    [self request:1];
                    
                    return ;
                }
                
                [self MBShow:@"验证该订单失败,请重试" backview:self.view];
                
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
#pragma mark ============ 取消订单

-(void)quxiaodingdan:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray * Arr = [NSMutableArray array];
            
            Arr = _dataSouceArr[sender.tag];
            
            NSDictionary * dic_darr = Arr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"],@"siId":user_id};
            
            [ZHJQHttpToll GET:LPCFANDIANQUXIAODINGDN parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"取消订单成功" backview:self.view];
                    
                    [self request:1];
                    
                    return ;
                }
                
                [self MBShow:@"取消订单失败,请重试" backview:self.view];
                
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
#pragma mark 酒店的同意退款
-(void)jiudiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray  * data_Arr = _dataSouceArr[sender.tag];
            
            NSDictionary  *dic = data_Arr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * string_all = [self getstring:[NSString stringWithFormat:@"%@",dic[@"real_price"]]];
            
            NSString * string_id = [self getstring:[NSString stringWithFormat:@"%@",dic[@"userId"]]];
            
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
                    
                    [self request:1];
                    
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
#pragma mark 饭店驳回退款申请
-(void)jiudianbohuishenqing:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray  * data_Arr = _dataSouceArr[sender.tag];
            
            NSDictionary  *dic = data_Arr[0];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"siId":user_id,@"orderState":@"7",@"type":@2};
            
            
            [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self request:1];
                    
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
