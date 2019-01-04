//
//  JPushShangPinViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/16.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "JPushShangPinViewController.h"
#import "JPushshangpinModel.h"


@interface JPushShangPinViewController (){
    
    JPushShangPinExpress * Express;
}

@end

@implementation JPushShangPinViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:false];
}
-(void)click_nav{
    
    if(_type_root == 1){
        
        // 切换跟试图
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        if([[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]]] isEqualToString:@""]){
            
            [SHARE_APP chageViewController];
            
        }else {
            
            [SHARE_APP  changeRootViewController:[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]]]];
            
        }
        
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
    
    self.navigationItem.title = @"订单详情";
    
     self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    [self left_nav];
    
    [self Creat_UI];
    
    _dataSourceArr = [NSMutableArray array];
    
    [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Creat_UI{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.frame.size.height - State_HEIGHT)];
    
    _myTableView.dataSource = self ;
    
    _myTableView.delegate = self;
    
    _myTableView.tableFooterView = [UIView new];
    
    _myTableView.backgroundColor = COLOR(237, 242, 249, 1);

    [self.view addSubview:_myTableView];
    
    
}
#pragma mark  商品详情
-(void)request{
    
    [SHARE_APP showHud];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSDictionary * dic = @{@"type":@3 ,@"orderCode":_orderCode,@"informationId":user_id};
    
    
    [ZHJQHttpToll GET:LPCGOODSDELEUL parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        JPushshangpinModel * model = [JPushshangpinModel yy_modelWithJSON:dic_json];
        
        [SHARE_APP hideHud];
        
        if(model.header.status == 0){
         
            Express = model.data.express;

            _dataSourceArr = [model.data.map mutableCopy];
            
            NSMutableArray * data = [NSMutableArray array];
            
            _dataSourceArr_isPicker = [NSMutableArray array];
            
            for (JPushShangPinMap * mapModel in _dataSourceArr) {
                
                if(mapModel.is_deliver_fee == 1){
                    
                    [_dataSourceArr_isPicker addObject:mapModel];
                    
                }else {
                    
                    [data addObject:mapModel];
                    
                }
                
            }
            
            _dataSourceArr = data;
            
            [_myTableView reloadData];
            
            [SHARE_APP hideHud];
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}


-(void)viewDidLayoutSubviews {
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    NSInteger  row = indexPath.row;
    
    if(self.dataSourceArr.count > 0){
        
        if(row <= self.dataSourceArr.count - 1){
            
            JPushShangPinMap * mapmodel = _dataSourceArr[row];
            
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
            
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 8];
            
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
            
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 8];
            
            
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
            
            allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 8];
            
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
            

            
            if(row == _dataSourceArr.count -1){
                
                if(mapmodel.order_state == 2){
                    
                    
                     UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"确认发货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(button_click:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];

                    
                }if(mapmodel.order_state == 3){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已发货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 4){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已使用" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state ==5){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已完成" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 6){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"申请退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(shenshangpintuikuai:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                    
                    
                    UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90 -70 -10, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button_one setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
                    
                    [button_one setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button_one addTarget:self action:@selector(bohuishenshangpintuikuai:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button_one.layer.masksToBounds = true;
                    
                    button_one.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button_one.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button_one];
                    
                    
                }if(mapmodel.order_state == 7){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"待发货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 8){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"去退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(qutuikuaishangpin:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 9){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"退款成功" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 10){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 100, 30)];
                    
                    [button setBackgroundColor:[UIColor  lightGrayColor]];
                    
                    [button setTitle:@"已驳回退款申请" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }if(mapmodel.order_state == 11){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"确认收货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(shangpinquerenshouhuo:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                }
                
                
                
            }
            
        }if(row == _dataSourceArr.count){
            
            JPushShangPinMap * mapModel = _dataSourceArr_isPicker[0];
            
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
    
    
    return cell;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(![Express isEqual:[NSNull null]] && Express != nil && ![Express.express_name isEqualToString:@""]){
        
        return 3;
        
    }

    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_dataSourceArr.count -1 == indexPath.row){
        
        return 120 + 44;
        
    } if(_dataSourceArr.count  == indexPath.row){
        
        return 215+7*4;
        
    }if(_dataSourceArr.count +1  == indexPath.row){
        
        return 100;
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = self.myTableView.backgroundColor;
    
    if(_dataSourceArr.count > 0){
        
        JPushShangPinMap  * dic = _dataSourceArr[0];
        
        
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
#pragma mark 商品====商品====商品====商品====商品====商品====商品====商品====商品====商品====
#pragma mark 商家确认发货
-(void)button_click:(UIButton *)sender{
    
    JPushShangPinMap * map = [_dataSourceArr_isPicker firstObject];
    
    if(map.is_pickup == 1){
        
        // 自提商品
       
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认该订单收货?" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                
                // 自提
                NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
                
                NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
                
                NSDictionary * dic_request = @{@"orderCode":[NSString  stringWithFormat:@"%@",map.order_code] ,@"siId":user_id,@"orderState":@"3",@"type":@3};
                
                [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                    
                    
                    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    if([[self headdic:dic_json] isEqualToString:@"0"]){
                        
                        
                        [self MBShow:@"自提成功" backview:self.view];
                        
                        [self request];
                        
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
        
        LPCgoodsfahuoVC * Vc = [LPCgoodsfahuoVC new];
        
        Vc.delegate = self;
        
        Vc.ord_type = [self getstring:[NSString stringWithFormat:@"%ld",(long)map.order_state]];
        
        Vc.idstring = map.order_code;
                
        [self push:Vc];
        
    }
    
    
}

#pragma mark 发物流的回调
- (void)chooseclick:(NSInteger )type_section{
    
    [self request];
    
}


#pragma mark 商品申请退款
-(void)shenshangpintuikuai:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            JPushShangPinMap * map = [_dataSourceArr firstObject];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":map.order_code ,@"shopInformationId":user_id,@"orderState":@7};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"审核成功" backview:self.view];
                    
                    [self request];
                    
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
#pragma mark 商品的去退款
-(void)qutuikuaishangpin:(UIButton *)sender{
    
    
    JPushShangPinMap * mapmodel = [_dataSourceArr firstObject];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * user_user = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dic_request = @{@"orderCode":mapmodel.order_code
                                           ,@"shopUserId":user_user,
                                           @"orderState":@"9",
                                           @"type":@"3",
                                           @"useId":[NSString stringWithFormat:@"%lld",mapmodel.user_id],
                                           @"balance":[NSString stringWithFormat:@"%ld",(long)mapmodel.real_price],
                                           @"siId":user_id
                                           };
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self request];
                    
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

#pragma mark 商品的确认收货
-(void)shangpinquerenshouhuo:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认该订单收货?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            JPushShangPinMap * mapmodel = [_dataSourceArr firstObject];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            
            NSDictionary * dic_request = @{@"orderCode":mapmodel.order_code ,@"shopInformationId":user_id,@"orderState":@8};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"收货成功" backview:self.view];
                    
                    [self request];
                    
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

#pragma mark 商品驳回申请

-(void)bohuishenshangpintuikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            JPushShangPinMap * map = [_dataSourceArr firstObject];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":map.order_code ,@"shopInformationId":user_id,@"orderState":@10};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self request];
                    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
