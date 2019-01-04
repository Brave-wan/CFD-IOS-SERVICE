//
//  LPCNOUseViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCNOUseViewController.h"
#import "LPCjiudianfandiantuijingModel.h"
#import "LPCNOTwoModel.h"
#import "JSONKit.h"


@interface LPCNOUseViewController ()

@property (nonatomic,strong)LPCNOTwoModel * model;

@end

@implementation LPCNOUseViewController

-(void)request:(NSString *)type{
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    NSDictionary * dic = @{@"siId":user_id,@"type":type};
    
    [ZHJQHttpToll  GET:LPCTUIJINGKUAI parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        
        if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
            //酒店
            _model = [LPCNOTwoModel yy_modelWithJSON:dic_json];
            
            if (_model.header.status == 0) {
                
                if([_type isEqualToString:@"1"]){
                    
                    _dataSourceArr = [_model.data mutableCopy];
                    
                }
                
                
                [self.MyTableView reloadData];
            }
            
        }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
            //饭店
            
            _model = [LPCNOTwoModel yy_modelWithJSON:dic_json];
            
            if (_model.header.status == 0) {
                
                if([_type isEqualToString:@"1"]){
                    
                      _dataSourceArr = [_model.data mutableCopy];
                
                }

                
                [self.MyTableView reloadData];
                
            }
            
           
        }else{
            
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        [_MyTableView reloadData];
        
        [self  MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
    
}
-(void)rege{
    
    _type = @"1";
    
    [self request:_type];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _MyTableView                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height - 40)];
    
    _MyTableView.tableFooterView = [UIView new];
    
    _MyTableView.delegate        = self;
    
    _MyTableView.dataSource      = self;
    
    _MyTableView.backgroundColor = COLOR(237, 242, 249, 1);
    
    [self.view addSubview:_MyTableView];
    
    _type = @"1";
    
    [self request:_type];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    if ([self.MyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MyTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.MyTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MyTableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
        //酒店
        
        if([_type isEqualToString:@"1"]){
            
            NSDictionary * model= _dataSourceArr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model[@"order_code"]];//@"订单号 : 306954231";
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [cell.contentView addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString:model[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
            
            [cell.contentView addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            nameLabel_one.text = model[@"nick_name"];
            
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_one];
            
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:model[@"describe_img"]] placeholderImage:[UIImage imageNamed:@"a2_tupian"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text = model[@"name"];//@"双人房";
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            NSString * string = [NSString stringWithFormat:@"房间数 : %@间 \n入住 : %@ \n离店:%@   %@晚",model[@"quantity"], model[@"start_date"],model[@"end_date"],model[@"check_days"]];
            
            timeLaebl.text = string;
            
            timeLaebl.numberOfLines = 0 ;
            
            
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 7];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
            
            NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%@",model[@"real_price"]
                              ];
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            NSString * lengsyinh= [NSString stringWithFormat:@"%@",model[@"real_price"]];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, lengsyinh.length + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            
            
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"待审核" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = row;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
            
            
        }
        
    }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        //饭店
        
        if([_type isEqualToString:@"1"]){
            
            
            NSMutableArray  * data_Arr = _dataSourceArr[section];
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"describe_img"]] placeholderImage:[UIImage imageNamed:@"b1_tu1"]];
            
            
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
            
            
            if( row == data_Arr.count-1 ){
                
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"待审核" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                //  [button addTarget:self action:@selector(fandianyanzhenghexiao:) forControlEvents:UIControlEventTouchUpInside];
                
                
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
    
#warning LPC 9.29 暂时注释
    /*
    LPCnouserxiangqiyeVcViewController * viewcontroller= [LPCnouserxiangqiyeVcViewController new];
    
    NSString  * idString = @"";
    
  
        
        NSMutableArray * data_Arr = _dataSourceArr[indexPath.section];
        
        NSDictionary * dic = data_Arr[0];
        
        idString = dic[@"order_code"];
        

        viewcontroller.imageUrl = dic[@"describe_img"];

    
    
    viewcontroller.idString = idString;
    
    viewcontroller.object = self;
    
    [self push:viewcontroller];
    */
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
        //酒店
        
        
        
    }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        //饭店
        
        if([_type isEqualToString:@"1"]){
            
            NSArray * array = _model.data[section];
            
            return array.count;
        }
        
      
        
        
    }else{
        
        
        
    }
   
    return 1;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
        //酒店
        
        return 0;
        
    }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        //饭店
        
        NSMutableArray *data = _dataSourceArr[indexPath.section];
        
        if(indexPath.row == data.count-1){
            
            return 120 +44;
            
        }
        
        
        
        
    }else  if ([[user  objectForKey:@"shopId"] isEqualToString:@"3"]){
        
        
        return 0;
    }
    
    return 120 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
        //酒店
        
        return 0;
        
    }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        //饭店
      
        if([_type isEqualToString:@"1"]){
            
            NSInteger tag = _model.data.count;
            
            return tag;
            
        }
        
       
        
        
    }else{
        
        
        return 0;
    }
   
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
        //酒店
        
        return 0;
        
    }else if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]){
        //饭店
        
        if([_type isEqualToString:@"1"]){
            
            NSMutableArray * data = _dataSourceArr[section];
            
            NSDictionary *dic = data[0];
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
            
            
            orlderLabel.text = code_String;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [view  addSubview:orlderLabel];
            
            
            UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
            
            imageView_one.image  =[UIImage imageNamed:@"d19_touxaing"];
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
            imageView_one.layer.masksToBounds =true;
            
            imageView_one.layer.cornerRadius = 15;
            
            [view  addSubview:imageView_one];
            
            
            UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
            
            nameLabel_one.text = dic[@"nick_name"];
            
            nameLabel_one.adjustsFontSizeToFitWidth = true;
            
            [view addSubview:nameLabel_one];

            
        }
        
        
        
        
    }else{
        
        
        return 0;
    }
    
    return view;
}


@end
