
//
//  LPCOffViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCOffViewController.h"
#import "JIUDIANJINRImodel.h"
#import "fandianjinrimodel.h"
@interface LPCOffViewController ()<typededategele,jiudiandeshenhe,fandiantuikuaideshenhe,fandiandelegate,ClickReusetDelegate,cliclkSecyionDelegate>{
    
    LPCTabelVIewHieadView  * hieadView;
}


// 酒店的数据源
@property (nonatomic ,strong) NSMutableArray * jiudDataSouecArr;

//饭店的数据源
@property (nonatomic ,strong) NSMutableArray * fandianDataSouecArr;

// 商品的数据源
@property (nonatomic ,strong) NSMutableArray * shangpinDataSouecArr;
// 商品的数据源（配送额 和 总额 ）
@property (nonatomic ,strong) NSMutableArray * shangpinDataSouecArr_one;


@end

@implementation LPCOffViewController

-(void)loadrequesttwo{
    
    [_Tableview.mj_header beginRefreshing];
    
    //[SHARE_APP showHud];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSString * type_string = @"";
    
    NSString * type = [NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]];
    // 1 酒店 3特产 2 饭店 4 小吃
    
    if([type isEqualToString:@"1"]){
        
        type_string =@"1";
        
    }if([type isEqualToString:@"2"]){
        
        type_string =@"2";
        
    }if([type isEqualToString:@"3"]){
        
        type_string =@"3";
        
    }if([type isEqualToString:@"4"]){
        
        type_string =@"3";
    }
    
    NSDictionary * dic = @{@"siId":user_id,
                           @"type":type_string,
                           @"createTime":currentTime};
    
    
    [ZHJQHttpToll GET:LPCSHUJUTONGJI parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [_Tableview.mj_header endRefreshing];
        
        if([type isEqualToString:@"1"]){
            
            // 酒店
            
            _jiudDataSouecArr = [NSMutableArray array];
            
            JIUDIANJINRImodel * model = [JIUDIANJINRImodel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                _jiudDataSouecArr = [model.data.orderList mutableCopy];
                
                [SHARE_APP hideHud];
                
                [_Tableview reloadData];
                
                return ;
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }if([type isEqualToString:@"2"]){
            
            _fandianDataSouecArr = [NSMutableArray array];
            
            fandianjinrimodel * model = [fandianjinrimodel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                
                _fandianDataSouecArr = [model.data.orderList mutableCopy];
                
                [_Tableview reloadData];
                
                [SHARE_APP hideHud];
                
                return;
                
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
        }else if([type isEqualToString:@"3"]){
            
            // 商品
            _shangpinDataSouecArr = [NSMutableArray array];
            
            _shangpinDataSouecArr_one =[NSMutableArray array];
            
            shangpinjinriModel * model = [shangpinjinriModel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                
                for(NSMutableArray * data in  [model.data.orderList mutableCopy]){
                    
                    for(NSDictionary * dic_data in data){
                        
                        if([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"0"]){
                            
                            [_shangpinDataSouecArr addObject:dic_data];
                            
                            
                        }else if ([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"1"]){
                            
                            [_shangpinDataSouecArr_one addObject:dic_data];
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
                [SHARE_APP hideHud];
                
                [_Tableview reloadData];
                
                return ;
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }
        
        [SHARE_APP hideHud];
        
        [_Tableview reloadData];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];

    
}

/**
 *  酒店下拉的刷新
 */
-(void)loadNewData{
    
    [SHARE_APP showHud];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSString * type_string = @"";
    
    NSString * type = [NSString stringWithFormat:@"%@",[user objectForKey:@"shopId"]];
     // 1 酒店 3特产 2 饭店 4 小吃
    
    if([type isEqualToString:@"1"]){
        
        type_string =@"1";
        
    }if([type isEqualToString:@"2"]){
        
         type_string =@"2";
        
    }if([type isEqualToString:@"3"]){
        
         type_string =@"3";
        
    }if([type isEqualToString:@"4"]){
        
         type_string =@"3";
    }
    
    NSDictionary * dic = @{@"siId":user_id,
                           @"type":type_string,
                           @"createTime":currentTime};
    
    
    [ZHJQHttpToll GET:LPCSHUJUTONGJI parameters:dic success:^(id responseObject) {

        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if([type isEqualToString:@"1"]){
            
            // 酒店
            
            _jiudDataSouecArr = [NSMutableArray array];
            
            JIUDIANJINRImodel * model = [JIUDIANJINRImodel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                _jiudDataSouecArr = [model.data.orderList mutableCopy];
                
                [SHARE_APP hideHud];
                
                [_Tableview reloadData];
                
                return ;
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }if([type isEqualToString:@"2"]){
            
            _fandianDataSouecArr = [NSMutableArray array];
            
            fandianjinrimodel * model = [fandianjinrimodel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                
                _fandianDataSouecArr = [model.data.orderList mutableCopy];
                
                [_Tableview reloadData];
                
                [SHARE_APP hideHud];
                
                return;
                
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
        }else if([type isEqualToString:@"3"]){
            
            // 商品
            _shangpinDataSouecArr = [NSMutableArray array];
            
            _shangpinDataSouecArr_one =[NSMutableArray array];
            
            shangpinjinriModel * model = [shangpinjinriModel yy_modelWithJSON:dic_json];
            
            if(model.header.status == 0){
                
                hieadView.nowString = [NSString stringWithFormat:@"%ld",(long)model.data.today.realPrice];
                
                hieadView.allString = [NSString stringWithFormat:@"%ld",(long)model.data.today.count];
                
                
                for(NSMutableArray * data in  [model.data.orderList mutableCopy]){
                    
                    for(NSDictionary * dic_data in data){
                        
                        if([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"0"]){
                            
                            [_shangpinDataSouecArr addObject:dic_data];

                            
                        }else if ([[self getstring:[NSString stringWithFormat:@"%@",dic_data[@"is_deliver_fee"]]] isEqualToString:@"1"]){
                            
                            [_shangpinDataSouecArr_one addObject:dic_data];
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
                [SHARE_APP hideHud];
                
                [_Tableview reloadData];
                
                return ;
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }
        
        [SHARE_APP hideHud];
        
        [_Tableview reloadData];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}

-(void)arrOrstring{
    
    _dataArr = _dataSourceArr = [NSMutableArray array];
    
    _jiudDataSouecArr = [NSMutableArray array];
    
    _fandianDataSouecArr= [NSMutableArray array];
    
    _shangpinDataSouecArr = [NSMutableArray array];
    
    _shangpinDataSouecArr_one =[NSMutableArray array];
    
    _type = @"1";
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString * string =  [user objectForKey:@"KEY"];
    
    if([string isEqualToString:@"1"])
        
        _Mark = @"商品";
    
    if([string isEqualToString:@"2"])
        
        _Mark = @"酒店";
    
    if([string isEqualToString:@"3"])
        
        _Mark = @"饭店";
        
}

#pragma mark =============================================
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"数据统计"];
    
    [self left];
    
    // 页面布局
    [self Creat_UI];
    
    [self arrOrstring];
   
    [self loadNewData];
    
    // Do any additional setup after loading the view.
}
-(void)Creat_UI{
    
    if(!_Tableview)
    {
        _Tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _Tableview.delegate = self;
        
        _Tableview.dataSource = self;
        
        _Tableview.tableFooterView = [[UIView alloc]init];
        
        _Tableview.mj_header = [MJChiBaoZiHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadrequesttwo)];
        
        [self.view addSubview:_Tableview];
        

        
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        
        imageView.image = [UIImage imageNamed:@"d5_beijing"];
        
        UILabel * manyLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH - 120, 45)];
        
        manyLabel.backgroundColor = [UIColor whiteColor];
        
        manyLabel.layer.masksToBounds =true;
        
        manyLabel.layer.cornerRadius = 22.5;
        
        manyLabel.alpha = .8;
        
        manyLabel.tag = 11;
        
        manyLabel.text = [NSString stringWithFormat:@"累计已结算金额    ￥%@",@"160000"];
        
        manyLabel.font = [UIFont systemFontOfSize:manyLabel.font.pointSize - 6];

        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计已结算金额    ￥%@",@"160000"]];
        
        
        
        UIColor * color = COLOR(53, 163, 227, 1);

        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(11, 6 + 1)];
        
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:manyLabel.font.pointSize + 9]
         
                              range:NSMakeRange(12, 6)];
        
        manyLabel.attributedText = AttributedStr;
        
        manyLabel.adjustsFontSizeToFitWidth = true;
        
        manyLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [imageView addSubview:manyLabel];
        
        
       // [headView addSubview:imageView];
        
        _Tableview.tableHeaderView = headView;
        
        headView.userInteractionEnabled = true;
        
        hieadView = [[LPCTabelVIewHieadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        
        hieadView.allString = @"";
        
        hieadView.nowString = @"";
        
        hieadView.backgroundColor = [UIColor whiteColor];
        
        [headView addSubview:hieadView];
        
        __weak typeof(self) WeakSelf = self;
        
        hieadView.ShowType = ^(NSInteger index){
          
            if(index == 0){
                
                //  今日
                
                WeakSelf.type = @"1";
                
                [WeakSelf.Tableview reloadData];
                
                
            }else{
                
                WeakSelf.type = @"2";
                
                [WeakSelf.Tableview reloadData];
                
                // 总共
                
            }
            
        };
        
    }
    
}


-(void)viewDidLayoutSubviews {
    
    if ([self.Tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.Tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.Tableview respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.Tableview setLayoutMargins:UIEdgeInsetsZero];
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
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if([_Mark isEqualToString:@"饭店"]){
        
        
        
        NSMutableArray  * data_Arr = _fandianDataSouecArr[section];
        
        NSDictionary  *dic = data_Arr[row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        
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
            
            
            UILabel  * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.size.height  + allLable.frame.origin.y , SCREEN_WIDTH, .4)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            // 获取订单的状态值 以确定按钮的展示
            
            NSInteger  status = [[NSString stringWithFormat:@"%@",dic[@"order_state"]] integerValue];
            
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
            
            if(status == 2){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"验证核销" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                [button addTarget:self action:@selector(fandianyanzhenghexiao:) forControlEvents:UIControlEventTouchUpInside];
                
                
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
                
                
                [button_one addTarget:self action:@selector(dandianquxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                //[cell.contentView addSubview:button_one];

                
            } if(status == 3){
                
                // 申请退款
                
                if([[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] isEqualToString:@"1"]){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"同意退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    
                    [button addTarget:self action:@selector(fandiantongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                    
                    UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
                    
                    [button_one setBackgroundColor:[UIColor whiteColor]];
                    
                    [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
                    
                    [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                    
                    button_one.layer.masksToBounds = true;
                    
                    button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                    
                    button_one.tag = section;
                    
                    
                    [button_one addTarget:self action:@selector(dandianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button_one.layer.cornerRadius = 7;
                    
                    button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                    
                    button_one.layer.borderWidth = .5;
                    
                    //[cell.contentView addSubview:button_one];
                    
                }else {
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90 -30, 7 + allLable.frame.size.height + allLable.frame.origin.y, 100, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"单品不允许退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                 
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }
                
                
            } if(status == 4){
                
                // 已使用
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已使用" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            } if(status == 5){
                
                // 已过期
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已过期" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            } if(status == 6){
                
                // 申请退款成功
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"申请退款成功" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            } if(status == 7){
                
                //  申请退款失败
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"申请退款失败" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }
            
            
        }
        
        
    }
    if([_Mark isEqualToString:@"酒店"]){
        
        JiudianOrderlist * model = _jiudDataSouecArr[section];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model.order_code];
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        imageView_one.layer.masksToBounds = true;
        
        imageView_one.layer.cornerRadius =15;
        
        [imageView_one sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        
        [cell.contentView addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        nameLabel_one.text = model.nick_name;
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_one];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.origin.y + nameLabel_one.frame.size.height + 5, 110, 90)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel.text = model.goods_name;
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
        UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
        
        timeLaebl.textAlignment = NSTextAlignmentLeft;
        
        NSString * string_text  = [NSString stringWithFormat:@"房间数 : %ld  \n入住 : %@ \n离店 : %@   %ld晚",(long)model.quantity ,model.start_date ,model.end_date,(long)model.check_days ];
        
        timeLaebl.text = string_text;
        
        timeLaebl.numberOfLines = 0 ;
        
        timeLaebl.textColor = [UIColor lightGrayColor];
        
        timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
        
        [cell.contentView addSubview:timeLaebl];
        
        
        UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
        
        allLable.text =[NSString stringWithFormat:@"总额 : ￥%ld",(long)model.real_price];// @"总额 : 750";
        
        allLable.textColor = [UIColor blackColor];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总额 : ￥%ld",(long)model.real_price]];
        
        UIColor * color = COLOR(255, 70, 78, 1);
        
        NSString * zong = [NSString stringWithFormat:@"%ld",(long)model.real_price];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(5, zong.length + 1)];
        
        allLable.attributedText = AttributedStr;
        
        
        [cell.contentView addSubview:allLable];
        
        
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height, SCREEN_WIDTH, .4)];
        
        henglabel.backgroundColor = [UIColor lightGrayColor];

        [cell.contentView addSubview:henglabel];
        
        if(model.order_state == 1){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor  lightGrayColor]];
            
            [button setTitle:@"待支付" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
        
        if(model.order_state == 2){
            
            // 未使用
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"验证核销" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(yanzhenghexiao:) forControlEvents:UIControlEventTouchUpInside];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
            
            [button_one setBackgroundColor:[UIColor whiteColor]];
            
            [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
            
            [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
            
            button_one.layer.masksToBounds = true;
            
            button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
            
            [button_one addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
            
            button_one.tag = row;
            
            button_one.layer.cornerRadius = 7;
            
            button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
            
            button_one.layer.borderWidth = .5;
            
            //[cell.contentView addSubview:button_one];
            
        }
        
        if(model.order_state == 3){
            
            
            // 申请退款
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"同意退款" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            [button addTarget:self action:@selector(jiudiantongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            
            
            UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
            
            [button_one setBackgroundColor:[UIColor whiteColor]];
            
            [button_one setTitle:@"驳回申请" forState:UIControlStateNormal];
            
            [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
            
            button_one.layer.masksToBounds = true;
            
            button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
            
            [button_one addTarget:self action:@selector(jiudianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
            
            button_one.tag = row;
            
            button_one.layer.cornerRadius = 7;
            
            button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
            
            button_one.layer.borderWidth = .5;
            
           // [cell.contentView addSubview:button_one];
            
        }
        if(model.order_state == 4){
            
            
                // 已使用
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已使用" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = row;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
            
        }
        
        
        if(model.order_state == 5){
            
            
            // 已过期
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"已过期" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        } if(model.order_state == 6){
            
            
            // 申请退款成功
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"退款成功" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }if(model.order_state == 7){
            
            
            // 申请退款失败
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"申请退款失败" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }

        
      
    }if([_Mark  isEqualToString:@"商品"]){
        
        
        NSDictionary * moel = _shangpinDataSouecArr[section];
        
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
        
        if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
            
            
        }else {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:moel[@"describe_img"] ] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
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
        
        pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 2];
        
        NSString * numStreing  = [NSString stringWithFormat:@"%@",moel[@"goods_real_price"]];
        
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
        
        pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 4];
        
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
        
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.size.height +  allLabel.frame.origin.y, SCREEN_WIDTH, .4)];
        
        henglabel.backgroundColor = [UIColor  lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
      
        
        NSInteger  ststus = [[self getstring:[NSString stringWithFormat:@"%@",moel[@"order_state"]]] integerValue];
        
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
    
    
    LPCHoteEatDeleViewController * eatViewController = [[LPCHoteEatDeleViewController alloc]init];

    
    if([_Mark isEqualToString:@"饭店"]){
        
        LPCHotelYesViewController  * JDViewcontroller = [[LPCHotelYesViewController alloc]init];
        
        LPCHoteloverViewController  * overViewControllerr = [[LPCHoteloverViewController alloc]init];

        
        NSString  * idString = @"";
            
        NSMutableArray * data_Arr = _fandianDataSouecArr[indexPath.section];
            
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
        
            
       
        
    }if([_Mark isEqualToString:@"酒店"]){
        
        
         JiudianOrderlist * model = _jiudDataSouecArr[indexPath.section];
        
        
        LPCHotelNOViewController  * JDViewcontroller = [[LPCHotelNOViewController alloc]init];
        
        LPCHotelOkViewController  * OkViewController = [[LPCHotelOkViewController alloc]init];
        
        LPCHoteloverdueViewController * Viewcontroller = [[LPCHoteloverdueViewController alloc]init];
        
        LPCJDNoViewController * noviewcontroller = [LPCJDNoViewController new];
        
        
        if(model.order_state == 2){
            
            JDViewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
            
            JDViewcontroller.object = self;

            
            [self push:JDViewcontroller];
            
        } if(model.order_state == 4){
            
            OkViewController.idString = [NSString stringWithFormat:@"%@",model.order_code];
            
            [self push:OkViewController];
        
        }if(model.order_state == 5){
            
            Viewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
            
            [self push:Viewcontroller];
            
        }else {
            
            noviewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
            
            if(model.order_state == 6){
                
                noviewcontroller.okNostring =@"退款成功";
                
                [self push:noviewcontroller];
                
            }else if(model.order_state == 7) {
                
            
                noviewcontroller.okNostring =@"退款失败";
                
                [self push:noviewcontroller];
                
            }else if(model.order_state == 3){
                
                
                noviewcontroller.okNostring = @"全部";
                
                noviewcontroller.object  = self;
                
                [self push:noviewcontroller];
                
                
            }
            
            
        }
        

       
    }if([_Mark isEqualToString:@"商品"]){
        
        NSInteger section = indexPath.section;
        
        LPCGoodsDeliteViewController * ViewController = [[LPCGoodsDeliteViewController alloc]init];
        
        NSDictionary * dic_t = _shangpinDataSouecArr[indexPath.section];
        
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
            
            
            NSDictionary * dic_t = _shangpinDataSouecArr[0];
            
            
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
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_Mark isEqualToString:@"饭店"]){
    
        NSMutableArray * datasourceArr = _fandianDataSouecArr[section];
        
        return datasourceArr.count;
        
    }
    
    if([_Mark isEqualToString:@"酒店"]){
        
       return 1;
        
    }
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_Mark isEqualToString:@"饭店"]){
        
        NSMutableArray * arr = _fandianDataSouecArr[indexPath.section];
        
        if(indexPath.row == arr.count - 1){
            
            NSDictionary * dict_ = [arr lastObject];
            
            if([[self getstring:[NSString stringWithFormat:@"%@",dict_[@"goods_type"]]] isEqualToString:@"1"]){
                
                return 120 +44 ;
                
            }
            
            return  120 +44;
            
        }
        
        return 120 ;
        
    }
    

    return 120 +44*2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if([_Mark isEqualToString:@"饭店"]){
        
        return _fandianDataSouecArr.count;
        
    }if([_Mark isEqualToString:@"酒店"]){
        
        return   _jiudDataSouecArr.count ;
        
    }if([_Mark isEqualToString:@"商品"]){
        
        return _shangpinDataSouecArr.count;
        
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if([_Mark isEqualToString:@"饭店"]){
        
        
        return 40;
        
    }if([_Mark isEqualToString:@"酒店"]){
        
        
        return 5;
        
    }
    
        return 5;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if([_Mark isEqualToString:@"饭店"]){
        
        UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * label_one = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        
        label_one.backgroundColor = COLOR(237, 242, 249, 1);
        
        [view addSubview:label_one];

        
        NSMutableArray * data = _fandianDataSouecArr[section];
        
        NSDictionary *dic = data[0];

        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 + 5, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7 +5, 30, 30)];
        
        
        
        if([[NSString stringWithFormat:@"%@",dic[@"userHeadImg"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"userHeadImg"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"userHeadImg"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7 +5, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
        return view;
    }else{
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        
        view.backgroundColor =  COLOR(237, 243, 248, 1);
        
        return view;
        
    }
    
    return nil;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 酒店未使用的单子的协议
- (void)chooserefre:(NSString *)type{
    
    [self loadNewData];
    
}

#pragma mark 验证核销
-(void)yanzhenghexiao:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        JiudianOrderlist * model = _jiudDataSouecArr[sender.tag];

        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                [self loadNewData];
                
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

#pragma mark 取消订单
-(void)quxiaodingdan:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        JiudianOrderlist * model = _jiudDataSouecArr[sender.tag];
        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCQUXIAODINGDAN parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                [self loadNewData];
                
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
-(void)jiudiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{

        
        [SHARE_APP showHud];
        
        JiudianOrderlist * model = _jiudDataSouecArr[sender.tag];
        
        
        NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
        
        NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
        
        NSString * string_all = [NSString stringWithFormat:@"%ld",(long)model.real_price];
        
        NSString * string_id = [NSString stringWithFormat:@"%ld",(long)model.consumerId];
        
        NSString * string_userid = [NSString stringWithFormat:@"%@",[user  objectForKey:@"USERID"]];
        
        NSDictionary * dict = @{@"shopUserId":string_userid,
                                @"useId":string_id,
                                @"balance":string_all,
                                @"siId":user_id,
                                @"orderCode":model.order_code,
                                @"orderState":@6,
                                @"type":@"1"};
        
        [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dict success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [self MBShow:@"退款成功" backview:self.view];
                
                [self loadNewData];
                
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
#pragma mark 酒店驳回退款申请
-(void)jiudianbohuishenqing:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
       
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
        
        [SHARE_APP showHud];
        
        JiudianOrderlist * model = _jiudDataSouecArr[sender.tag];
        
        NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
        
        NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
        
        
        NSDictionary * dic_request = @{@"orderCode":model.order_code ,@"siId":user_id,@"orderState":@"7",@"type":@1};
        
        
        [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [self MBShow:@"驳回成功" backview:self.view];
                
                [self loadNewData];
                
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
#pragma mark 酒店待审核退款的协议
-(void)jiudiandeshenhetuikuai:(NSString *)type{
    
    [self loadNewData];
    
}


#pragma mark ======================================================================

#pragma mark 饭店的取消订单
-(void)dandianquxiaodingdan:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray * Arr = [NSMutableArray array];
            
            Arr = _fandianDataSouecArr[sender.tag];
            
            NSDictionary * dic_darr = Arr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"],@"siId":user_id};
            
            [ZHJQHttpToll GET:LPCFANDIANQUXIAODINGDN parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"取消订单成功" backview:self.view];
                    
                    [self loadNewData];
                    
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

#pragma mark 饭店的验证核销
-(void)fandianyanzhenghexiao:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray * Arr = [NSMutableArray array];
            
            Arr = _fandianDataSouecArr[sender.tag];
            
            NSDictionary * dic_darr = Arr[0];
            
            NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"]};
            
            [ZHJQHttpToll GET:LPCFANDIANYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"验证该订单成功" backview:self.view];
                    
                    [self loadNewData];
                    
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

#pragma mark 饭店的同意退款
-(void)fandiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray  * data_Arr = _fandianDataSouecArr[sender.tag];
            
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
                    
                    [self loadNewData];
                    
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
#pragma mark 饭店的驳回退款申请
-(void)dandianbohuishenqing:(UIButton *)sender{

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回申请该订单?" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                
                [SHARE_APP showHud];
                
                NSMutableArray  * data_Arr = _fandianDataSouecArr[sender.tag];
                
                NSDictionary  *dic = data_Arr[0];

                
                NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
                
                NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
                
                
                NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"siId":user_id,@"orderState":@"7",@"type":@2};
                
                
                [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                    
                    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    
                    if([[self headdic:dic_json] isEqualToString:@"0"]){
                        
                        [self MBShow:@"驳回成功" backview:self.view];
                        
                        [self loadNewData];
                        
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
    
    [self loadNewData];
    
}
#pragma mark饭店退款成功的协议
- (void)fandiantuikuaishenhe{
    
    [self loadNewData];
    
}



#pragma mark   ======================================================================

#pragma mark商品商家待收货
-(void)shangpindaishouhou:(UIButton *)sender{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认该订单收货?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSDictionary * dic = _shangpinDataSouecArr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            
            NSDictionary * dic_request = @{@"orderCode":[NSString stringWithFormat:@"%@",dic[@"order_code"]] ,@"shopInformationId":user_id,@"orderState":@8};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"收货成功" backview:self.view];
                    
                    [self loadNewData];
                    
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

#pragma mark 商品驳回退款请求
-(void)shangpinbohuituikuaiqingqiu:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否驳回退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary * dic = _shangpinDataSouecArr[sender.tag];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"shopInformationId":user_id,@"orderState":@10};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
                    [self loadNewData];
                    
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

#pragma mark 商品同意退款
-(void)shangpintongyituikuai:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary * dic = _shangpinDataSouecArr[sender.tag];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"shopInformationId":user_id,@"orderState":@7};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"审核成功" backview:self.view];
                    
                    [self loadNewData];
                    
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

#pragma mark 商品确认发货
-(void)shangpinquerenfahuo:(UIButton *)sender{
    
    NSDictionary * dict = _shangpinDataSouecArr[sender.tag];
    
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
                        
                        [self loadNewData];
                        
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
#pragma mark 商品的去退款
-(void)qutuikuai:(UIButton *)sender{
    
    NSDictionary * dict = _shangpinDataSouecArr[sender.tag];

    
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
                    
                    [self loadNewData];
                    
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
//确认发货的协议
- (void)chooseclick:(NSInteger )type_section{
    
    [self loadNewData];
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
