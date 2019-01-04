//
//  LPCSPTDViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSPTDViewController.h"

#import "LPCNOUseViewController.h"

#import "LPCExpiredViewController.h"
#import "XMGTitleButton.h"
#import "LPCAlearyUseViewController.h"
#import "LPCjiudianfandiantuijingModel.h"
#import "LPCRefundedViewController.h"
#import "LPCNOTwoModel.h"
#import "jiudiantuikuaidaishenhemodel.h"
#import "fandiandaituikuaishenheModel.h"

#import "JSONKit.h"


@interface LPCSPTDViewController ()<UITextFieldDelegate,jiudiandeshenhe,fandiantuikuaideshenhe>{
    
 
    
}


@end

@implementation LPCSPTDViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:false];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title =@"退款订单";
    
    [self left];
    
    _dataSoureArr = [NSMutableArray array];
    
    _fandianDataSourceArr = [NSMutableArray array];
    
    [self Creat_UI];
    
    _bageNum_Arr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];

    // Do any additional setup after loading the view.
}
-(void)request:(NSString *)lengtype zhuangtai:(NSString *)zhuangtai {
    
    [SHARE_APP showHud];

    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"]){
        
        _dataSoureArr =[NSMutableArray array];
        
        NSDictionary * dic = @{@"siId":user_id,@"type":lengtype};
        
        [ZHJQHttpToll  GET:LPCJIUDAIDAISHENHE parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
                //酒店
                jiudiantuikuaidaishenhemodel   * model = [jiudiantuikuaidaishenhemodel yy_modelWithJSON:dic_json];
                
                if (model.header.status == 0) {
                    
                    [SHARE_APP hideHud];
                    
                    _dataSoureArr = [model.data mutableCopy];
                    
                    [_MyTabelView reloadData];
                    
                    return ;
                }
            
             [_MyTabelView reloadData];
            
            [self MBShow:[self head:dic_json] backview:self.view];
    
            
        }failure:^(NSError *error) {
            
            [self  MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        
        
    }else if([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        
        _fandianDataSourceArr =[NSMutableArray array];
        
        NSDictionary * dic = @{@"siId":user_id,@"type":lengtype};
        
        [ZHJQHttpToll  GET:CFANDIANDAISHENHELIEBIAO  parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            //饭店
            fandiandaituikuaishenheModel   * model = [fandiandaituikuaishenheModel yy_modelWithJSON:dic_json];
            
            if (model.header.status == 0) {
                
                [SHARE_APP hideHud];
                
                NSMutableArray * data_soureArr = [model.data mutableCopy];
                
                for(NSMutableArray * data in data_soureArr){
                    
                    for(NSDictionary * dic in  data){
                        
                        if([[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] isEqualToString:@"1"]){
                            
                            [_fandianDataSourceArr addObject:dic];
                            
                        }
                        
                    }
    
                }
                
                
                [_MyTabelView reloadData];
                
                return ;
            }
             [_MyTabelView reloadData];
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }failure:^(NSError *error) {
            
             [_MyTabelView reloadData];
            
            [self  MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        
        
    }else {
        
        _shangpinDataSourceArr =[NSMutableArray array];
        
        NSDictionary * dic = @{@"siId":user_id,@"type":lengtype};
        
        [ZHJQHttpToll  GET:PCSHANGPINTUIKUAIDINGDAN  parameters:dic success:^(id responseObject) {
            
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            //饭店
            shangpintuikuaidingdanmodel   * model = [shangpintuikuaidingdanmodel yy_modelWithJSON:dic_json];
            
            if (model.header.status == 0) {
                
                [SHARE_APP hideHud];
                
                NSMutableArray * data_soureArr = [model.data.orderList mutableCopy];
                
                _shangpinDataSourceArr = data_soureArr;
                

            
                if([_shangpintype isEqualToString:@"待审核"]){
                    
                    _bageNum_Arr[0] = [NSString stringWithFormat:@"%ld",(long)model.data.orderCount];
                    
                }if([_shangpintype isEqualToString:@"收货中"]){
                    
                    _bageNum_Arr[1] = [NSString stringWithFormat:@"%ld",(long)model.data.orderCount];
                    
                }if([_shangpintype isEqualToString:@"已退款"]){
                    
                    _bageNum_Arr[2] = [NSString stringWithFormat:@"%ld",(long)model.data.orderCount];
                    
                }
                
                _segment.title_numLabelArr = _bageNum_Arr;
                
                
                [_MyTabelView reloadData];
                
                return ;
            }
            [_MyTabelView reloadData];
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
            
        }failure:^(NSError *error) {
            
            [_MyTabelView reloadData];
            
            [self  MBShow:@"服务器繁忙" backview:self.view];
            
        }];
   
        
    }
    
  
}
-(void)Creat_UI{
    
// shopId
    
    NSMutableArray * nameArr = [NSMutableArray array];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] || [[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        
        nameArr = [NSMutableArray arrayWithObjects:@"待审核",@"已退款", nil];
        
        if([[user  objectForKey:@"shopId"] isEqualToString:@"1"]){
            
            // 酒店
            
            [self request:@"1" zhuangtai:@"待审核" ];
            
            _jiudiantype =@"待审核";
            
        }if([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
            
            // 饭店
            
            [self request:@"1" zhuangtai:@"待审核" ];
            
            _fandiantype  =@"待审核";
            
        }
        
        
    }else {
        
        
         nameArr     = [NSMutableArray arrayWithObjects:@"待审核",@"收货中",@"已退款", nil];
        
        _shangpintype = @"待审核";
        
        [self request:@"1" zhuangtai:@"待审核" ];
    }
    
    
    _segment = [[LPCSegemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) name:nameArr];
    
    _segment.delegate = self;
    
    [self.view addSubview:_segment];
  
    
    if(!_MyTabelView){
        
        _MyTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT -State_HEIGHT -self.navigationController.navigationBar.frame.size.height - 40)];
        
        
        _MyTabelView.dataSource = self ;
        
        _MyTabelView.delegate = self;
        
        _MyTabelView.tableFooterView = [UIView new];
        
        [self.view addSubview:_MyTabelView];
        
        
        
    }
    
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark segment 协议
-(void)index:(NSInteger)segmentindex type:(NSString *)type{
   
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];

    // 酒店
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
    
        _jiudiantype = type;
        
        [self request:[NSString stringWithFormat:@"%ld",(long)segmentindex +1] zhuangtai:type];
   
    }
    
    // 饭店
    else if([[user  objectForKey:@"shopId"] isEqualToString:@"2"] ){
        
        _fandiantype = type;
        
        [self request:[NSString stringWithFormat:@"%ld",(long)segmentindex +1] zhuangtai:type];
        
    }else {
        
        _shangpintype = type;
        
         [self request:[NSString stringWithFormat:@"%ld",(long)segmentindex +1] zhuangtai:type];
        
    }
}

-(void)viewDidLayoutSubviews {
    
    if ([self.MyTabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MyTabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.MyTabelView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MyTabelView setLayoutMargins:UIEdgeInsetsZero];
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
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
    
        
        
        jiudiandaishenheData * model = _dataSoureArr[section];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model.order_code];
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        imageView_one.layer.masksToBounds = true;
        
        imageView_one.layer.cornerRadius = 15;
        
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
        
        
        henglabel.backgroundColor = [UIColor  lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
        
        
        if([_jiudiantype isEqualToString:@"待审核"]){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"同意退款" forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(jiudiantongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = indexPath.row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
            
            [button_one setBackgroundColor:[UIColor whiteColor]];
            
            [button_one setTitle:@"驳回请求" forState:UIControlStateNormal];
            
            [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
            
            [button_one addTarget:self action:@selector(jiudianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
            
            button_one.layer.masksToBounds = true;
            
            button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
            
            button_one.tag = indexPath.row;
            
            button_one.layer.cornerRadius = 7;
            
            button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
            
            button_one.layer.borderWidth = .5;
            
           // [cell.contentView addSubview:button_one];
            
        }
        if([_jiudiantype  isEqualToString:@"已退款"]){
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLable.frame.size.height + allLable.frame.origin.y + 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"已退款" forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(jiudiantongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = indexPath.row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
    }
   
    
    // 饭店
   else  if([[user  objectForKey:@"shopId"] isEqualToString:@"2"] ){
        

        
        NSDictionary  *dic = _fandianDataSourceArr[section];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [cell.contentView  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_one];
        
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.origin.y + nameLabel_one.frame.size.height + 14 , 110, 90)];
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel.text =[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_name"]]] ;
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
        UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width-30, 30)];
        
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
       
       UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height, SCREEN_WIDTH, .4)];
       
       
       henglabel.backgroundColor = [UIColor  lightGrayColor];
       
       [cell.contentView addSubview:henglabel];
       
 
            if([[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] isEqualToString:@"1"]){
                
                if([_fandiantype isEqualToString:@"待审核"]){
                    
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
                    
                   // [cell.contentView addSubview:button_one];
                
                }else {
                 
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"已退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];

                    
                }
                
            }
            
    }else {
        
        NSMutableArray * data_Arr = self.shangpinDataSourceArr[section];
        
        NSDictionary * moel = data_Arr[row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
        
        
        
        if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            
        }else {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:moel[@"describe_img"] ] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
        }
        
        
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel_sd.text = moel[@"goods_name"];
        
        nameLabel_sd.textAlignment = NSTextAlignmentLeft;
        
        nameLabel_sd.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel_sd];
        
        UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
        
        pirceLabel.text = @"￥120";
        
        pirceLabel.textAlignment  = NSTextAlignmentLeft;
        
        pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 3];
        
        NSString * numStreing  = [NSString stringWithFormat:@"%@",moel[@"goods_real_price"]];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%@",numStreing]];
        
        UIColor * color;
        
        color = COLOR(255, 70, 78, 1);
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(0, numStreing.length + 1)];
        
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 1]
         
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
        
        allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 4];
        NSString * String = [NSString stringWithFormat:@"总额 ￥%@           X %@",allString,allString_one];
        
        NSMutableAttributedString * AttributedSt = [[NSMutableAttributedString alloc]initWithString:String];
        
        
        allLabel.textColor = [UIColor lightGrayColor];
        
        
        [AttributedSt addAttribute:NSForegroundColorAttributeName
         
                             value:color
         
                             range:NSMakeRange(3, allString.length + 1)];
        
        
        [AttributedSt addAttribute:NSFontAttributeName
         
                             value:[UIFont systemFontOfSize:allLabel.font.pointSize + 0]
         
                             range:NSMakeRange(3, allString.length + 1)];
        
        
        allLabel.attributedText = AttributedSt;
        
        [cell.contentView addSubview:allLabel];
        
        
        
        
        
        if(row == data_Arr.count -1){
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.origin.y + allLabel.frame.size.height, SCREEN_WIDTH, .4)];
            
            
            henglabel.backgroundColor = [UIColor  lightGrayColor];
            
             [cell.contentView addSubview:henglabel];
            
            
            if([_shangpintype isEqualToString:@"待审核"]){
                
                 UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"去审核" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                [button addTarget:self action:@selector(qushenhe:) forControlEvents:UIControlEventTouchUpInside];
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];

                
            }if([_shangpintype isEqualToString:@"收货中"]){
                
                NSInteger status = [[self getstring:[NSString stringWithFormat:@"%@",moel[@"order_state"]]] integerValue];
              
                if(status == 7){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                    [button setTitle:@"待发货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                }else if(status == 8){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"去退款" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    [button addTarget:self action:@selector(qutuikuai:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }else if(status == 11){
                    
                    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button setTitle:@"确认收货" forState:UIControlStateNormal];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    button.layer.masksToBounds = true;
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                    
                    button.tag = section;
                    
                    [button addTarget:self action:@selector(shangpinquerenshouhuo:) forControlEvents:UIControlEventTouchUpInside];
                    
                    button.layer.cornerRadius = 7;
                    
                    [cell.contentView addSubview:button];
                    
                }
                
                
               
                
                
            }if([_shangpintype isEqualToString:@"已退款"]){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"已退款" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }
            
        }
        
    }


    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
  // 酒店
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
    
       jiudiandaishenheData * model = _dataSoureArr[indexPath.section];
        
       LPCJDNoViewController * noviewcontroller = [LPCJDNoViewController new];
        
        if([_jiudiantype isEqualToString:@"待审核"]){
            
            noviewcontroller.okNostring = @"全部";
            
            noviewcontroller.object  = self;
            
        }if([_jiudiantype isEqualToString:@"已退款"]){
            
            noviewcontroller.okNostring = @"已退款";
            
        }
        
        noviewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
        
        [self push:noviewcontroller];
        
    }else if([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
      
        if([_fandiantype isEqualToString:@"待审核"]){
            
            fandiantukuaidingdanVCViewController * oneViewconroller_fandian = [fandiantukuaidingdanVCViewController new];
            
            NSDictionary * dic = _fandianDataSourceArr[indexPath.row];
            
            NSString * type_goods = [self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]];
            
            oneViewconroller_fandian.imageUrl = [self getstring:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]];
            
            oneViewconroller_fandian.idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            if([type_goods isEqualToString:@"0"]){
                
                oneViewconroller_fandian.oneTwo = @"1";
                
            }if([type_goods isEqualToString:@"1"]){
                
                oneViewconroller_fandian.oneTwo = @"2";
            }
            
            oneViewconroller_fandian.object = self;
            
            [self push:oneViewconroller_fandian];

            
        }else {
            
            LPCZHFDNoViewController * viewcontroller_one_two = [[LPCZHFDNoViewController alloc]init];
            
            NSDictionary * dic = _fandianDataSourceArr[indexPath.row];

            viewcontroller_one_two.imageUrl = [self getstring:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]];
            
            viewcontroller_one_two.idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            if([[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] isEqualToString:@"0"]){
                
                viewcontroller_one_two.oneTwo = @"1";
                
            }if([[self getstring:[NSString stringWithFormat:@"%@",dic[@"goods_type"]]] isEqualToString:@"1"]){
                
                viewcontroller_one_two.oneTwo = @"2";
            }
            
            viewcontroller_one_two.string_paye = @"退款成功";

            
            [self push:viewcontroller_one_two];
            
        }
        
    }else {
        
        NSInteger section = indexPath.section;
        
        LPCGoodsDeliteViewController * ViewController = [[LPCGoodsDeliteViewController alloc]init];
        
        NSMutableArray * data_arr = _shangpinDataSourceArr[section];
        
        NSDictionary * dic_t = data_arr[0];
        
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
                
                
                NSMutableArray * data_arr = _shangpinDataSourceArr[section];
                
                NSDictionary * dic_t = data_arr[0];
                
                
                ViewController.string_id = [self getstring:[NSString stringWithFormat:@"%@",dic_t[@"order_code"]]];
                
                ViewController.object = self;
                
                ViewController.idstring = [self getstring:[NSString  stringWithFormat:@"%@",dic_t[@"order_code"]]];
                
                ViewController.section = section;
                
                
                  ViewController.object = self;
             
                
                
                [self push:ViewController];
                
            }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    // 酒店
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
    
    return 1;
        
    }
    
    // 饭店
    else if([[user  objectForKey:@"shopId"] isEqualToString:@"2"] ){
        
        return 1;
        
    }else {
        
        NSMutableArray * data = _shangpinDataSourceArr[section];
        
        return data.count;
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    // 酒店
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
        
        return 120 + 44 *2;
        
    }
    // 饭店
   else  if([[user  objectForKey:@"shopId"] isEqualToString:@"2"] ){
        
        
        return 120 +44*2;
   }else {
       
       NSMutableArray * dataArr = _shangpinDataSourceArr[indexPath.section];
       
       if(dataArr.count -1 == indexPath.row){
           
           return 120 + 44;
           
       }
       
   }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    // 酒店
    if([[user  objectForKey:@"shopId"] isEqualToString:@"1"] ){
        
        return _dataSoureArr.count;
        
    }
    if([[user  objectForKey:@"shopId"] isEqualToString:@"2"] ){
        
        return  _fandianDataSourceArr.count;
        
    }else {
        
        return _shangpinDataSourceArr.count;
        
    }
   
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    // shangpin
    if([[user  objectForKey:@"shopId"] isEqualToString:@"3"] ){
        
        
        return 40;
        
    }
    
    return 5;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    // 商品
    if([[user  objectForKey:@"shopId"] isEqualToString:@"3"] ){
        
        UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        
        view.backgroundColor = [UIColor whiteColor];
        

        UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        
        backView.backgroundColor = COLOR(237, 242, 249, 1);
        
        [view addSubview:backView];
        
        
        NSMutableArray * data = _shangpinDataSourceArr[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];

        
        return  view ;
        
    }else {
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        
        view.backgroundColor = COLOR(237, 243, 248, 1);
        
        return view ;
       
        
    }

    
    return nil;

}

#pragma mark 酒店的同意退款
-(void)jiudiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
 
        jiudiandaishenheData * model = _dataSoureArr[sender.tag];
        
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
                
                 [self request:@"1" zhuangtai:@"待审核"];
                
                return ;
                
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
        } failure:^(NSError *error) {
            
            [self MBShow:@"服务器繁忙" backview:self.view];
        }];
        
        
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
        
        [SHARE_APP showHud];
        
        jiudiandaishenheData * model = _dataSoureArr[sender.tag];
        
        NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
        
        NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
        
        
        NSDictionary * dic_request = @{@"orderCode":model.order_code ,@"siId":user_id,@"orderState":@"7",@"type":@1};
        
        
        [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [self MBShow:@"驳回成功" backview:self.view];
                
                [self request:@"1" zhuangtai:@"待审核"];
                
                return ;
                
            }
            
            [self MBShow:[self head:dic_json] backview:self.view];
            
        } failure:^(NSError *error) {
            
            [self MBShow:@"服务器繁忙" backview:self.view];
        }];
        
        
    }];
    
    [alertController addAction:okAction];
    
    UIAlertAction *canleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:canleAction];
    
    
    [self presentViewController:alertController animated:true completion:nil];
    
    
}
#pragma mark 酒店待审核退款的协议
-(void)jiudiandeshenhetuikuai:(NSString *)type{
    
    [self request:@"1" zhuangtai:@"待审核"];
    
}
#pragma mark =========================================================================
#pragma mark 饭店的同意退款
-(void)fandiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSDictionary  *dic = _fandianDataSourceArr[sender.tag];
            
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
            
            
            NSDictionary  *dic = _fandianDataSourceArr[sender.tag];
            
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"siId":user_id,@"orderState":@"7",@"type":@2};
            
            
            [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"驳回成功" backview:self.view];
                    
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

-(void)fandiantuikuaishenhe{
    
     [self request:@"1" zhuangtai:@"待审核" ];

}
- (void)chooserefre:(NSString *)type{
    
    if([_shangpintype isEqualToString:@"待审核"]){
        
         [self request:@"1" zhuangtai:_shangpintype];
    }
    if([_shangpintype isEqualToString:@"收货中"]){
        
        [self request:@"2" zhuangtai:_shangpintype];
        
    }if([_shangpintype isEqualToString:@"已退款"]){
        
        [self request:@"3" zhuangtai:_shangpintype];
        
    }
}

#pragma mark 商品去审核
-(void)qushenhe:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            NSMutableArray * arr = _shangpinDataSourceArr[sender.tag];
            
            NSDictionary * dic = arr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            NSDictionary * dic_request = @{@"orderCode":[self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]] ,@"shopInformationId":user_id,@"orderState":@7};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"审核成功" backview:self.view];
                    
                    [self request:@"1" zhuangtai:@"待审核"];

                    
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
-(void)shangpinquerenshouhuo:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认该订单收货?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
            [SHARE_APP showHud];
            
            
            NSMutableArray * data  = _shangpinDataSourceArr[sender.tag];
            
            NSDictionary * dic = data[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            
            
            NSDictionary * dic_request = @{@"orderCode":[NSString stringWithFormat:@"%@",dic[@"order_code"]] ,@"shopInformationId":user_id,@"orderState":@8};
            
            
            [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [self MBShow:@"收货成功" backview:self.view];
                    
                    [self request:@"2" zhuangtai:_shangpintype];
                    
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

#pragma mark 商品的去退款
-(void)qutuikuai:(UIButton *)sender{
    
    NSMutableArray * data = _shangpinDataSourceArr[sender.tag];
    
    NSDictionary *  dict = data[0];
    
    LPCGoodsDeliteViewController * ViewController = [[LPCGoodsDeliteViewController alloc]init];
    
    // 发货
    ViewController .string = @"3";
    
    
    
    ViewController.string_id = [self getstring:[NSString stringWithFormat:@"%@",dict[@"order_code"]]];
    
    ViewController.object = self;
    
    ViewController.idstring = [self getstring:[NSString  stringWithFormat:@"%@",dict[@"order_code"]]];
    
    ViewController.section = sender.tag;
    
    
    ViewController.object = self;
    
    
    
    [self push:ViewController];
    
    /*
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
                                           @"balance":[self getstring:[NSString stringWithFormat:@"%@",dict[@"real_price"]]],
                                           @"siId":user_id
                                           };
            
            [ZHJQHttpToll GET:LPCJIUDIANDAISHENHETONGYI parameters:dic_request success:^(id responseObject) {
                
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    
                    [self MBShow:@"退款成功" backview:self.view];
                    
                    [self request:@"2" zhuangtai:_shangpintype];
                    
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
    
    */
    
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
