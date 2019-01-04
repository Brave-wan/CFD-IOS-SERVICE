//
//  JPushFandianViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/12.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "JPushFandianViewController.h"
#import "JPushFanDianModel.h"

@interface JPushFandianViewController ()

@property (nonatomic ,strong) JPushFanDianTaoCanDetail * detailModel;

@end

@implementation JPushFandianViewController

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
    
    [self left_nav];
    
    [self Creat_UI];
    
    self.navigationItem.title = @"订单详情";
    
    [self request];
    
    // 0 单品  1 套餐
    
    _dataSourceArr_danpin = [NSMutableArray array];
    
    _dataSourceArr_taocan = [NSMutableArray array];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

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
    
    NSDictionary * dic  = [NSDictionary dictionary];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];

    dic = @{@"goodsType":_goodsType ,@"siId":user_id ,@"orderCode":_orderCode};
    

    [ZHJQHttpToll GET:LPCFANDIANXIANGQIYE parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            if([_goodsType isEqualToString:@"0"]){
                
                // 单品
                
                JPushFanDianModel * model = [JPushFanDianModel yy_modelWithJSON:dic_json];
                
                _dataSourceArr_danpin = [model.data mutableCopy];
                
                
            }if([_goodsType isEqualToString:@"1"]){
                
                // 套餐
                
                JPushFanDianTaoCanModel * model = [JPushFanDianTaoCanModel yy_modelWithJSON:dic_json];
                
                _dataSourceArr_taocan = [model.data.shopGoodsList mutableCopy];
                
                _detailModel = model.data.detail;
                
            }
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

    NSInteger row = indexPath.row;
    
    NSInteger section = indexPath.section;
    
    // 0 单品 没有退款
    if([_goodsType isEqualToString:@"0"]){
        
        
        if(_dataSourceArr_danpin.count > 0){
            
            if(row < _dataSourceArr_danpin.count ){
                
                JPushFanDianData *model = _dataSourceArr_danpin[row];
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
                
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.describe_img] placeholderImage:[UIImage imageNamed:@"b1_tu1"]];
                
                
                [cell.contentView addSubview:imageView];
                
                
                UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
                
                nameLabel.text = model.name;//model.name;
                
                
                nameLabel.textAlignment = NSTextAlignmentLeft;
                
                nameLabel.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:nameLabel];
                
                
                
                UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
                
                timeLaebl.textAlignment = NSTextAlignmentLeft;
                
                
                timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:model.eat_date];
                
                timeLaebl.numberOfLines = 0 ;
                
                timeLaebl.textColor = [UIColor lightGrayColor];
                
                timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 5];
                
                [cell.contentView addSubview:timeLaebl];
                
                
                UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
                
                allLable.text = @"总额 : ￥750";
                
                NSString * all = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.real_price]];
                
                NSString * all_string = [self getstring:[NSString stringWithFormat:@"总额 : ￥%ld",(long)model.real_price]];
                
                allLable.textColor = [UIColor blackColor];
                
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all_string];
                
                UIColor * color = COLOR(255, 70, 78, 1);
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                 
                                      value:color
                 
                                      range:NSMakeRange(5, all.length + 1)];
                
                allLable.attributedText = AttributedStr;
                
                
                [cell.contentView addSubview:allLable];
                

                
                if(row == _dataSourceArr_danpin.count - 1){
                    
                    NSString * string = [NSString stringWithFormat:@"%ld",(long)model.order_state];
                    
                    
                    
                    if([string intValue] == 2){
                        
                        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                        
                        [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                        
                        [button setTitle:@"验证核销" forState:UIControlStateNormal];
                        
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        [button addTarget:self action:@selector(danpin_buton_yanzheng:) forControlEvents:UIControlEventTouchUpInside];
                        
                        
                        button.layer.masksToBounds = true;
                        
                        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                        
                        button.tag = section;
                        
                        button.layer.cornerRadius = 7;
                        
                        [cell.contentView addSubview:button];
                        
                        
                       
                        
                    }if([string intValue] == 3){
                        
                        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                        
                        [button setBackgroundColor:[UIColor lightGrayColor]];
                        
                        [button setTitle:@"已使用" forState:UIControlStateNormal];
                        
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        button.layer.masksToBounds = true;
                        
                        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                        
                        button.tag = section;
                        
                        button.layer.cornerRadius = 7;
                        
                        [cell.contentView addSubview:button];
                        
                    }
                    if([string intValue] == 4){
                        
                        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                        
                        [button setBackgroundColor:[UIColor lightGrayColor]];
                        
                        [button setTitle:@"已完成" forState:UIControlStateNormal];
                        
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        button.layer.masksToBounds = true;
                        
                        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                        
                        button.tag = section;
                        
                        button.layer.cornerRadius = 7;
                        
                        [cell.contentView addSubview:button];
                        
                        
                    }if([string intValue] == 5){
                        
                        
                    }if([string intValue] == 6){
                        
                        
                    }if([string intValue] == 7){
                        
                        
                    }if([string intValue] == 8){
                        
                        
                        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                        
                        [button setBackgroundColor:[UIColor lightGrayColor]];
                        
                        [button setTitle:@"已过期" forState:UIControlStateNormal];
                        
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        button.layer.masksToBounds = true;
                        
                        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                        
                        button.tag = section;
                        
                        button.layer.cornerRadius = 7;
                        
                        [cell.contentView addSubview:button];
                        
                    }
                    
                    
                }
                
            }
            
            if(row == _dataSourceArr_danpin.count){
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -20, 40)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.textAlignment = NSTextAlignmentLeft;
                
                label.text = @"订单信息";
                
                [cell.contentView addSubview:label];
                
            }
            if(row ==  _dataSourceArr_danpin.count  + 1){
                
                NSMutableArray * data_Arr  = [NSMutableArray array];
                
                JPushFanDianData * dic_modle = _dataSourceArr_danpin[0];
                
                [data_Arr addObject:[NSString stringWithFormat:@"创建时间  : %@",dic_modle.create_time]];
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款时间  : %@",dic_modle.pay_time]];
                
                if([[NSString stringWithFormat:@"%ld",(long)dic_modle.pay_way] isEqualToString:@"1"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"余额支付"]];
                    
                }if([[NSString stringWithFormat:@"%ld",(long)dic_modle.pay_way] isEqualToString:@"2"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"支付宝支付"]];
                    
                }if([[NSString stringWithFormat:@"%ld",(long)dic_modle.pay_way] isEqualToString:@"3"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"微信支付"]];
                    
                }
                
                [data_Arr addObject:[NSString stringWithFormat:@"就餐时间  : %@",dic_modle.eat_date]];
                
                
                [data_Arr addObject:[NSString stringWithFormat:@"联系电话  : %@",dic_modle.telphone]];
                
                
                NSInteger all = 0;
                
                for(JPushFanDianData * dict in _dataSourceArr_danpin){
                    
                    NSInteger  string = [[NSString stringWithFormat:@"%ld",(long)dict.real_price]  integerValue];
                    
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
            
            
        }
        
    }else {
        
        
        if(_detailModel != nil){
            
            if(row ==0 ){
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
                
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.goodsImg] placeholderImage:[UIImage imageNamed:@"b1_tu1"]];
                
                
                [cell.contentView addSubview:imageView];
                
                
                UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
                
                nameLabel.text = _detailModel.name;
                
                
                nameLabel.textAlignment = NSTextAlignmentLeft;
                
                nameLabel.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:nameLabel];
                
                
                
                UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
                
                timeLaebl.textAlignment = NSTextAlignmentLeft;
                
                
                timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:_detailModel.eat_date];
                
                
                timeLaebl.numberOfLines = 0 ;
                
                timeLaebl.textColor = [UIColor lightGrayColor];
                
                timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 5];
                
                [cell.contentView addSubview:timeLaebl];
                
                
                UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
                
                allLable.text = @"总额 : ￥750";
                
                NSString * all = [ NSString stringWithFormat:@"%ld", (long)_detailModel.real_price ];
                
                NSString * all_string = [ NSString stringWithFormat:@"总额 : ￥%ld", (long)_detailModel.real_price];
                
                allLable.textColor = [UIColor blackColor];
                
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all_string];
                
                UIColor * color = COLOR(255, 70, 78, 1);
                
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                 
                                      value:color
                 
                                      range:NSMakeRange(5, all.length + 1)];
                
                allLable.attributedText = AttributedStr;
                
                
                [cell.contentView addSubview:allLable];
                
                
                if(_detailModel.order_state == 2){
  
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"验证核销" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(danpin_buton_yanzheng:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                    UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                    
                    [button_one setBackgroundColor:[UIColor whiteColor]];
                    
                    [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                    
                    [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                    
                    button_one.layer.masksToBounds = true;
                    
                    button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                    
                    button_one.tag = section;
                    
                    [button_one addTarget:self action:@selector(taocan_button_clanle:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button_one.layer.cornerRadius = 7;
                    
                    button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                    
                    button_one.layer.borderWidth = .5;
                    
                    [cell.contentView addSubview:button_one];
                    
                }if(_detailModel.order_state == 3){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已使用" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];

                    
                }if(_detailModel.order_state == 4){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已完成" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }if(_detailModel.order_state == 5){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"同意退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    [button addTarget:self action:@selector(taocan_buton_tongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
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
                    
                    [button_one addTarget:self action:@selector(taocan_button_bohuiqingqiu:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button_one.layer.cornerRadius = 7;
                    
                    button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                    
                    button_one.layer.borderWidth = .5;
                    
                    [cell.contentView addSubview:button_one];
                    
                }if(_detailModel.order_state == 6){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"退款失败" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }if(_detailModel.order_state == 7){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"退款成功" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }if(_detailModel.order_state == 8){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已过期" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }if(_detailModel.order_state == 9){
                    
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已作废" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }

                
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
                
                [data_Arr addObject:[NSString stringWithFormat:@"创建时间  : %@",_detailModel.create_time]];
                
                [data_Arr addObject:[NSString stringWithFormat:@"付款时间  : %@",_detailModel.pay_time]];
                
                if([[NSString stringWithFormat:@"%ld",(long)_detailModel.pay_way] isEqualToString:@"1"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"余额支付"]];
                    
                }if([[NSString stringWithFormat:@"%ld",(long)_detailModel.pay_way] isEqualToString:@"2"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"支付宝支付"]];
                    
                }if([[NSString stringWithFormat:@"%ld",(long)_detailModel.pay_way] isEqualToString:@"3"]){
                    
                    [data_Arr addObject:[NSString stringWithFormat:@"付款方式  : %@",@"微信支付"]];
                    
                }
                
                [data_Arr addObject:[NSString stringWithFormat:@"就餐时间  : %@",_detailModel.eat_date]];
                
                
                [data_Arr addObject:[NSString stringWithFormat:@"联系电话  : %@",_detailModel.telphone]];
                
                
                
                NSInteger  string = [[NSString stringWithFormat:@"%ld",(long)_detailModel.real_price]  integerValue];
                
                
                
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
                
                for(JPushFanDianTaoCanShopgoodslist * listModel in _dataSourceArr_taocan){
                    
                    NSString * string = listModel.goods_name;
                    
                    NSString * string_one = [self getstring:[NSString stringWithFormat:@"%ld",(long)listModel.quantity]];
                    
                    NSString * string_two = [self getstring:[NSString stringWithFormat:@"%ld",(long)listModel.new_price]];
                    
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

        
    }
    
    
    
    return cell;

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_goodsType isEqualToString:@"0"]){
        
        return _dataSourceArr_danpin.count + 2;
        
    }
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([_goodsType isEqualToString:@"0"]){
        // 单品
        
        if(indexPath.row < _dataSourceArr_danpin.count -1){
            
            return 120;
            
        }if(indexPath.row == _dataSourceArr_danpin.count -1){
            
            return 120 +44;
            
        }if(indexPath.row == _dataSourceArr_danpin.count){
            
            return 40;
            
        }if(indexPath.row == _dataSourceArr_danpin.count+1){
            
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
        
        return  _dataSourceArr_taocan.count  * 20 + 30;
        
    }
    
    
    
    return 140;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    view.backgroundColor = self.myTableView.backgroundColor;
    

    if([_goodsType isEqualToString:@"0"]){
        
        if(_dataSourceArr_danpin.count > 0){
            
            JPushFanDianData *dic = _dataSourceArr_danpin[0];
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            NSString * code_String = [@"订单号 : " stringByAppendingString:dic.order_code];
            
            
            orlderLabel.text = code_String;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [view  addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            imageView_one.image  =[UIImage imageNamed:@"d19_touxaing"];
            
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString:dic.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
            
            imageView_one.layer.masksToBounds =true;
            
            imageView_one.layer.cornerRadius = 15;
            
            [view  addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            
            nameLabel_one.text = dic.nick_name;
            
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [view addSubview:nameLabel_one];
      
        }

    }else {
        
        if(_detailModel != nil){
            
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            NSString * code_String = [@"订单号 : " stringByAppendingString:_detailModel.order_code];
            
            
            orlderLabel.text = code_String;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [view  addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            imageView_one.image  =[UIImage imageNamed:@"d19_touxaing"];
            
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString:_detailModel.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
            
            imageView_one.layer.masksToBounds =true;
            
            imageView_one.layer.cornerRadius = 15;
            
            [view  addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            
            nameLabel_one.text = _detailModel.nick_name;
            
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [view addSubview:nameLabel_one];
            
        }
        
        
    }
        

    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
  
    return 40;
    
}

#pragma mark  饭店单品 饭店单品 饭店单品 饭店单品 饭店单品 饭店单品 饭店单品
#pragma mark 饭店单品的验证核销
-(void)danpin_buton_yanzheng:(UIButton *)sender{
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary  * dic = [NSDictionary dictionary];
            
            if([_goodsType isEqualToString:@"0"]){
                
               JPushFanDianData * model_danpin = [_dataSourceArr_danpin firstObject];
                
                
                dic = @{@"orderCode":model_danpin.order_code};
                
            }else {
                
                dic = @{@"orderCode":_detailModel.order_code};
                
            }
            
            
          
            
           
            
            [ZHJQHttpToll GET:LPCFANDIANYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [SHARE_APP  hideHud];
                    
                    [self request];
                    
                    
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

#pragma mark 套餐的取消订单
-(void)taocan_button_clanle:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
           
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSDictionary  *  dic = @{@"orderCode":_orderCode,@"siId":user_id};
            
            [ZHJQHttpToll GET:LPCFANDIANQUXIAODINGDN parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"取消该订单成功" backview:self.view];
                    
                    _myTableView.hidden = true ;
                    
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

#pragma mark 套餐的同意退款
-(void)taocan_buton_tongyituikuai:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
   
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSString * string_all = [self getstring:[NSString stringWithFormat:@"%ld",(long)_detailModel.real_price]];
            
            NSString * string_id = [self getstring:[NSString stringWithFormat:@"%lld",_detailModel.user_id]];
            
            NSString * string_userid = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
            
            NSDictionary * dict = @{@"shopUserId":string_userid,
                                    @"useId":string_id,
                                    @"balance":string_all,
                                    @"siId":user_id,
                                    @"orderCode":_orderCode,
                                    @"orderState":@6,
                                    @"type":@"2"};
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dict success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self request];
                    
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
#pragma mark 套餐驳回退款申请
-(void)taocan_button_bohuiqingqiu:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];

            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":_orderCode ,@"siId":user_id,@"orderState":@"7",@"type":@2};
            
            
            [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self request];
                    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
