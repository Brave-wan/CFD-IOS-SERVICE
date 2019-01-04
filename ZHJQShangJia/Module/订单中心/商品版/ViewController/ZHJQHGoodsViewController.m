//
//  ZHJQHGoodsViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHGoodsViewController.h"
#import "LPCgoodsfahuoVC.h"

@interface ZHJQHGoodsViewController ()<indextDelegate,UITextFieldDelegate,cliclkSecyionDelegate>{
    
     LPCSegemView  * segment;
    
     NSInteger    Firststring;
    
     NSInteger    Secondstring;
    
    NSInteger    Threestring;
}

@end

@implementation ZHJQHGoodsViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};

    
    [self backColor:COLOR(237, 243, 248, 1)];
    
    _type = @"1";
    
    _searchBar = [[LPCCustomTextFild alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH -100, 30)];
    
    _searchBar.placeholder = @"  订单号、下单人";
    
    _searchBar.delegate = self;
    
    [_searchBar setValue:COLOR(61, 162, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_searchBar setValue:[UIFont systemFontOfSize:_searchBar.font.pointSize -4] forKeyPath:@"_placeholderLabel.font"];
    
    _searchBar.font = [UIFont systemFontOfSize:_searchBar.font.pointSize - 4];
    
    [_searchBar setBackgroundColor:COLOR(26, 122, 187, 1)];
    
    _searchBar.layer.masksToBounds = true;
    
    _searchBar.layer.cornerRadius = _searchBar.frame.size.height/2;
    
    _searchBar.leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, _searchBar.frame.size.height)];
    
    _searchBar.textColor = [UIColor whiteColor];
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView * rihgt = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, _searchBar.frame.size.height)];
    
    rihgt.image = [UIImage imageNamed:@"a2_sousuo"];
    
    rihgt.contentMode = UIViewContentModeCenter;
    
    _searchBar.rightView = rihgt;
    
    _searchBar.rightViewMode = UITextFieldViewModeAlways;
    


    _searchBar.returnKeyType = UIReturnKeySearch;
    
    self.navigationItem.titleView = _searchBar;
    
    [self Creat_UI];
    
    _page = 1;
    
    [self getdownrequest:@"待发货" intde:1];
    
    
    

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    LPCsearcjbarshangpinViewController * ViewController = [[LPCsearcjbarshangpinViewController alloc]init];
    
    ViewController.type_string = @"商品";
    
    [self push:ViewController];
    
    return NO;
}
-(void)Creat_UI{
    
    NSMutableArray * nameArr = [NSMutableArray arrayWithObjects:@"待发货",@"已发货",@"已完成", nil];

    
    segment = [[LPCSegemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) name:nameArr];
    
    segment.delegate = self;
    
    _bageNum_Arr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    
    [self.view addSubview:segment];
    
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segment.frame.size.height + 5, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height-45)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [UIView new];
        
        _TableView.backgroundColor = COLOR(237, 242, 249, 1);
        
        _TableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(regrft)];
        
        _Footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadup)];
        
        _TableView.mj_footer = _Footer;
        
        [self.view addSubview:_TableView];
        
    }
    
}
// 上拉
-(void)loadup{
    
    [_TableView.mj_footer  beginRefreshing];
    
    if([_type isEqualToString:@"3"]){
        
        
        [self upload:@"已完成" intde:2];
        
    }
    if([_type isEqualToString:@"1"]){
        
        [self upload:@"待发货" intde:2];
        
    }if([_type isEqualToString:@"2"]){
        
        [self upload:@"已发货" intde:2];
        
        
        
    }
}
-(void)upload:(NSString *)string_type intde:(int )inted{
    
    [SHARE_APP showHud];
    
    int type_segment   = 0;
    
    if([string_type isEqualToString:@"待发货"]){
        
        type_segment       = 1;
        
    }else if([string_type isEqualToString:@"已发货"]){
        
        type_segment       = 3;

    }else {
        
        type_segment       = 2;

    }
    
    NSNumber * mun = [NSNumber numberWithInt:type_segment];
    
    NSDictionary * dic = @{@"page":[NSNumber numberWithInteger:_page] ,
                           @"rows":@10 ,
                           @"status":mun};
    
    [ZHJQHttpToll GET:LPSHEDDROPDOWN parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        LPCgoodModel * model = [LPCgoodModel yy_modelWithJSON:dic_json];
        
        if(model.header.status == 0){
            
            [SHARE_APP hideHud];
            
            [_TableView.mj_footer endRefreshing];

            
            if(_page >= model.data.orderList.lastPage){
                
                [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_TableView.mj_footer endRefreshingWithNoMoreData];
                
                
            }

            _page ++;
                
           
            
            if([string_type isEqualToString:@"待发货"]){
                
                
                for(NSMutableArray * arr  in   [model.data.orderList.rows mutableCopy]){
                    
                    
                    [self.Hang_dataScureArr addObject:arr];
                    
                }
                
                Firststring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Firststring];
                
                _bageNum_Arr[0] = [NSString stringWithFormat:@"%@",num];
                
            }if([string_type isEqualToString:@"已完成"]){
                
                
                for(NSMutableArray * arr  in   [model.data.orderList.rows mutableCopy]){
                    
                    
                    [self.been_dataSoureArr addObject:arr];
                    
                }
                
                Secondstring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Secondstring];
                
                _bageNum_Arr[2] = [NSString stringWithFormat:@"%@",num];
                
                
            }if([string_type isEqualToString:@"已发货"]){
                
                
                for(NSMutableArray * arr  in   [model.data.orderList.rows mutableCopy]){
                    
                    
                    [self.Already_dataSourceArr addObject:arr];
                    
                }
                
                Threestring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Threestring];
                
                _bageNum_Arr[1] = [NSString stringWithFormat:@"%@",num];
                
                
                
            }
            
            segment.title_numLabelArr = _bageNum_Arr;
            
            [self.TableView reloadData];
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self.TableView reloadData];
        
        [self.TableView.mj_footer  endRefreshing];
        [self MBShow:@"服务器繁忙,请刷新尝试" backview:self.view];
        
    }];
    
    
}

// 下拉
-(void)regrft{
    
     [_TableView.mj_header  beginRefreshing];

if([_type isEqualToString:@"3"]){
    
     [self getdownrequest:@"已完成" intde:2 ];
    
}
if([_type isEqualToString:@"1"]){
    
    [self getdownrequest:@"待发货" intde:2];
    
    
}if([_type isEqualToString:@"2"]){
    
    [self getdownrequest:@"已发货" intde:2];

    
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
    
    cell.backgroundColor = [UIColor whiteColor];
   
#pragma mark cell 重用cell 待发货
    if([_type isEqualToString:@"1"]){
        
        NSMutableArray * data_Arr = self.Hang_dataScureArr[section];
       
        NSDictionary * moel = data_Arr[row];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
        
        
        
        if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"describe_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"describe_img"]] isEqualToString:@"<null>"]){
            
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
            
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 2];
        
          NSString * numStreing  = [NSString stringWithFormat:@"%@",moel[@"price"]];
        
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
        
        
        if(row == data_Arr.count -1){
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.origin.y + allLabel.frame.size.height, SCREEN_WIDTH, .5)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"确认发货" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            [button addTarget:self action:@selector(qurenfahuo:) forControlEvents:UIControlEventTouchUpInside];
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];

            
        }

    }
#pragma mark cell 重用cell 已发货
    if([_type isEqualToString:@"2"])
    
    {
        if(self.Already_dataSourceArr.count > 0){
            
            NSMutableArray * data_Arr = self.Already_dataSourceArr[section];
            
            NSDictionary * moel = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
            
            
            if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
                
                
                
            }else {
                
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:moel[@"describe_img"] ] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
                
            }
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel_sd = [[UILabel alloc]initWithFrame:CGRectMake( imageView.frame.size.width + imageView.frame.origin.x+ 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel_sd.text = moel[@"goods_name"];
            
            nameLabel_sd.textAlignment = NSTextAlignmentLeft;
            
            nameLabel_sd.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel_sd];
            
            UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_sd.frame.origin.x, nameLabel_sd.frame.origin.y + 30 + 5, nameLabel_sd.frame.size.width/3 -15, 30)];
            
            
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
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 3];
            
            NSString * PIstring= [NSString stringWithFormat:@"￥%@    配送费:￥%@",moel[@"goods_price"],moel[@"deliver_fee"]];
            
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
            
            
            
#pragma  mark 已发货的状态值  order_state
            if(row == data_Arr.count -1){
                
                UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.origin.y + allLabel.frame.size.height, SCREEN_WIDTH, .5)];
                
                henglabel.backgroundColor = [UIColor lightGrayColor];
                
                [cell.contentView addSubview:henglabel];
                
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, allLabel.frame.origin.y + allLabel.frame.size.height+ 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                NSString * status_String = [NSString stringWithFormat:@"%@",moel[@"order_state"]];
                
                NSString * title_string= @"";
                
                if([status_String isEqualToString:@"3"] | [status_String isEqualToString:@"4"]){
                    
                    title_string = @"已发货";
                    
                }if([status_String isEqualToString:@"5"] ){
                    
                    title_string = @"已完成";
                    
                }if([status_String isEqualToString:@"6"] ){
                    
                    title_string = @"去审核";
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    [button addTarget:self action:@selector(qushenhe:) forControlEvents:UIControlEventTouchUpInside];
                    
                }if([status_String isEqualToString:@"7"] ){
                    
                    title_string = @"退款中";
                    
                    [button setBackgroundColor:[UIColor lightGrayColor]];
                    
                }
                
                if([status_String isEqualToString:@"11"] ){
                    
                    title_string = @"待收货";
                    
                    [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                    
                    
                    [button addTarget:self action:@selector(shouhuo:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
                if( [status_String isEqualToString:@"8"]){
                    
                    title_string = @"退款中";
                    
                }
                
                if([status_String isEqualToString:@"10"] ){
                    
                    title_string = @"已驳回";
                    
                }
                if([status_String isEqualToString:@"9"] ){
                    
                    title_string = @"已退款";
                    
                }
                
                [button setTitle:title_string forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
            }
 
        }
  
        
    }
#pragma mark cell 重用cell 已完成
    
    if([_type isEqualToString:@"3"]){
        
        NSMutableArray * data_Arr = self.been_dataSoureArr[section];
        
        NSDictionary * moel = data_Arr[row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
        
        
        if([[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[moel objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
            
            
        }else {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:moel[@"describe_img"] ] placeholderImage:[UIImage imageNamed:@"c1_tu1"]];
            
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
        
        pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 3];
        
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
        
        
        if(row == data_Arr.count -1){
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLabel.frame.origin.y + allLabel.frame.size.height, SCREEN_WIDTH, .5)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"已完成" forState:UIControlStateNormal];
            
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
    
    NSInteger section = indexPath.section;

    LPCGoodsDeliteViewController * ViewController = [[LPCGoodsDeliteViewController alloc]init];
    
    
    // 未完成 (状态值需要数据返回)
   if([_type isEqualToString:@"1"]){
        
       
            // 发货 
        ViewController .string = @"2";
       
       NSMutableArray * data_sourceArr = _Hang_dataScureArr[section];
       
       NSDictionary * dic_t = data_sourceArr[0];
       
       ViewController.string_id = [NSString stringWithFormat:@"%@",dic_t[@"order_code"]];
       
       ViewController.object = self;
       
       ViewController.is_pickup_string = [NSString stringWithFormat:@"%@",dic_t[@"is_pickup"]];
       
       ViewController.idstring = [NSString  stringWithFormat:@"%@",dic_t[@"order_code"]];
       
       ViewController.section = section;
       
       
        [self push:ViewController];
        
    }
    
    
    if([_type isEqualToString:@"2"]){
        
        
        // 发货
        ViewController .string = @"3";
        
        NSMutableArray * data_sourceArr = _Already_dataSourceArr[section];
        
        NSDictionary * dic_t = data_sourceArr[0];
        

        ViewController.string_id = [NSString stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.object = self;
        
        ViewController.idstring = [NSString  stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.section = section;
        
        if([[NSString  stringWithFormat:@"%@",dic_t[@"order_state"]] isEqualToString:@"6"] ||[[NSString  stringWithFormat:@"%@",dic_t[@"order_state"]] isEqualToString:@"11"] ){
            
            
            ViewController.object = self;
            
        }
        
        
        [self push:ViewController];
        
    }
    
    if([_type isEqualToString:@"3"]){
        
        
        // 完成
        ViewController .string = @"4";
        
        NSMutableArray * data_sourceArr = _been_dataSoureArr[section];
        
        NSDictionary * dic_t = data_sourceArr[0];
        
        ViewController.string_id = [NSString stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.object = self;
        
        ViewController.idstring = [NSString  stringWithFormat:@"%@",dic_t[@"order_code"]];
        
        ViewController.section = section;
        
        
        [self push:ViewController];

        
    }
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([_type isEqualToString:@"1"]){

        NSMutableArray * model = _Hang_dataScureArr[section];
    
        return model.count;
    
    }
    if([_type isEqualToString:@"2"]){
        
        NSMutableArray * model = _Already_dataSourceArr[section];
        
        return model.count;
        
    }
    if([_type isEqualToString:@"3"]){
        
        NSMutableArray * model = _been_dataSoureArr[section];
        
        
        return model.count;
        
    }
    
    return 10;
    
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_type isEqualToString:@"1"]){
        
         NSMutableArray * dataArr = _Hang_dataScureArr[indexPath.section];
        
        if(dataArr.count -1 == indexPath.row){
            
            return 120 + 44;
            
        }
    }
    if([_type isEqualToString:@"3"]){
        
        NSMutableArray * dataArr = _been_dataSoureArr[indexPath.section];
        
        if(dataArr.count -1 == indexPath.row){
            
            return 120 + 44;
            
        }
    }
    if([_type isEqualToString:@"2"]){
        
        if(_Already_dataSourceArr.count > 0){
            
            NSMutableArray * dataArr = _Already_dataSourceArr[indexPath.section];
            
            if(dataArr.count -1 == indexPath.row){
                
                return 120 + 44;
                
            }
        }
      
    }

    return 120 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([_type isEqualToString:@"1"] ){
        
          return _Hang_dataScureArr.count;
        
    }if([_type isEqualToString:@"3"]){
        
          return _been_dataSoureArr.count;
        
    }if([_type isEqualToString:@"2"]){
        
        return _Already_dataSourceArr.count;
    }
    
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIView * backView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    backView.backgroundColor = COLOR(237, 242, 249, 1);
    
    [view addSubview:backView];
    
    if([_type isEqualToString:@"1"]){
        
        NSMutableArray * data_Arr = self.Hang_dataScureArr[section];
        
        NSDictionary * dic = data_Arr[0];
        
        
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 +5, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
            NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",[dic  objectForKey:@"order_code"]];
            
            orlderLabel.text = orderSreing;
            
            orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
            
            [view  addSubview:orlderLabel];
            
            
            UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7+5, 30, 30)];
       
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
       
        
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
         
                [imageView_sd sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }else {
        
        
            [imageView_sd sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }
        
        [view addSubview:imageView_sd];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7+5, 80, 30)];
            
        if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"<null>"] && ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"(null)"] ){
            
            nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]];
            
        }
        
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [view addSubview:nameLabel];
            
    
        
    }
    
    if([_type isEqualToString:@"3"]){
        
        NSMutableArray * data_Arr = self.been_dataSoureArr[section];
        
        NSDictionary * dic = data_Arr[0];
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7+5, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",[dic  objectForKey:@"order_code"]];
        
        orlderLabel.text = orderSreing;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7+5, 30, 30)];
        
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
        
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_sd sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }else {
            
            
            [imageView_sd sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }
        
        
        [view addSubview:imageView_sd];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7+5, 80, 30)];
        
        
        
        if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"<null>"] && ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"(null)"] ){
            
            nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]];
            
        }
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel];
        
        
        
    } if([_type isEqualToString:@"2"]){
        
        NSMutableArray * data_Arr = self.Already_dataSourceArr[section];
        
        NSDictionary * dic = data_Arr[0];
        
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7+5, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * orderSreing = [NSString stringWithFormat:@"订单号 : %@",[dic  objectForKey:@"order_code"]];
        
        orlderLabel.text = orderSreing;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_sd = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7+5, 30, 30)];
        
        imageView_sd.layer.masksToBounds = true;
        
        imageView_sd.layer.cornerRadius = 15;
        
        
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"(null)"]|| [[NSString stringWithFormat:@"%@",[dic objectForKey:@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_sd sd_setImageWithURL:[NSURL URLWithString:@"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }else {
            
            
            [imageView_sd sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }
        
        
        [view addSubview:imageView_sd];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7+5, 80, 30)];
        
        if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"<null>"] && ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]] isEqualToString:@"(null)"] ){
            
            nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nick_name"]];
            
        }
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel];
        
        
        
    }
    
    
    return view;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)index:(NSInteger)segmentindex type:(NSString *)type{
    
   
    
    if([type isEqualToString:@"已完成"]){
        
        _type  = @"3";
        
         [self getdownrequest:type intde:1];
        
    }
    
    if([type isEqualToString:@"待发货"]){
        
        _type = @"1";
    
        [self getdownrequest:type intde:1];
    
    }
    if([type isEqualToString:@"已发货"]){
        
        _type = @"2";
        
        [self getdownrequest:type intde:1];

        
        
    }
    

    
}

#pragma mark 未完成和已完成的下拉刷新
/**
 *  未完成和已完成的下拉刷新
 */
-(void)getdownrequest:(NSString *)string_type intde:(int)index{
    
    [SHARE_APP showHud];
    
    _page = 1;
    
    int type_segment   = 0;

    if([string_type isEqualToString:@"待发货"]){

    type_segment       = 1;

    _Hang_dataScureArr = [NSMutableArray array];

    }else if([string_type isEqualToString:@"已发货"]){
        
         type_segment       = 3;
        
        _Already_dataSourceArr  = [NSMutableArray array];
        
            
    }else {
            

    type_segment       = 2;

        _been_dataSoureArr  =[NSMutableArray array];

    }
    
    NSNumber * mun = [NSNumber numberWithInt:type_segment];
    
    NSDictionary * dic = @{@"page":@1 ,
                           @"rows":@10 ,
                           @"status":mun};
    
    [ZHJQHttpToll GET:LPSHEDDROPDOWN parameters:dic success:^(id responseObject) {
        
          NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        LPCgoodModel * model = [LPCgoodModel yy_modelWithJSON:dic_json];
        
        if(model.header.status == 0){
            
            _page = 2;
           
            [SHARE_APP hideHud];
            
            if(index == 2){
                
                [_TableView.mj_header endRefreshing];
                
                
            }
            NSMutableArray * dataArr = [model.data.orderList.rows mutableCopy];
            
            if(dataArr.count == 0 ||dataArr.count < 10 ){
                
                [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_TableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            if(dataArr.count == 10){
                
                [_TableView.mj_footer resetNoMoreData];
                
            }
            
            if([string_type isEqualToString:@"待发货"]){
                
                
                self.Hang_dataScureArr = [model.data.orderList.rows mutableCopy];
                
                Firststring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Firststring];
                
                 _bageNum_Arr[0] = [NSString stringWithFormat:@"%@",num];
                
            }if([string_type isEqualToString:@"已完成"]){
                
                self.been_dataSoureArr = [model.data.orderList.rows mutableCopy];
                
                Secondstring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Secondstring];
                
                 _bageNum_Arr[2] = [NSString stringWithFormat:@"%@",num];
                
                
            }if([string_type isEqualToString:@"已发货"]){
                
                self.Already_dataSourceArr = [model.data.orderList.rows mutableCopy];
                
                Threestring  = model.data.orderCount;
                
                NSNumber * num  = [NSNumber numberWithInteger:Threestring];
                
                _bageNum_Arr[1] = [NSString stringWithFormat:@"%@",num];
                
                
                
            }
            
            segment.title_numLabelArr = _bageNum_Arr;
            
            [self.TableView reloadData];
            
            return ;
            
        }
        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self.TableView reloadData];
        [self MBShow:@"服务器繁忙,请刷新尝试" backview:self.view];
        
    }];
    
    
    
}
#pragma mark  需要删除订单中的配送数据中的一个字典
/**
 *  需要删除订单中的配送数据中的一个字典
 *
 *  @param dataArr 参数
 *
 *  @return tableview zhong 需要的参数
 */
-(NSMutableArray *)dataSruce:(NSMutableArray *)dataArr{
    
    /*for(NSDictionary * dic in dataArr){
        
        NSString * string = dic[@"is_deliver_fee"];
        
        if( [string  integerValue]== 1){
            
            [dataArr removeObject:dic];
            
        }
        
    }
    */
    return dataArr;
    
}
#pragma mark 确认发货
-(void)qurenfahuo:(UIButton *)sender{
    

    LPCgoodsfahuoVC * Vc = [LPCgoodsfahuoVC new];
    
    Vc.delegate = self;
    
    NSMutableArray *  data= _Hang_dataScureArr[sender.tag];
    
    NSDictionary * dic = data[0];
    
    Vc.ord_type = [NSString stringWithFormat:@"%@",dic[@"order_state"]];
    
    Vc.idstring = [NSString  stringWithFormat:@"%@",dic[@"order_code"]];

    Vc.section = sender.tag;

    
    if([[NSString stringWithFormat:@"%@",dic[@"is_pickup"]] isEqualToString:@"1"]){
        
        // 自提
        NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
        
        NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
        
        
        NSDictionary * dic_request = @{@"orderCode":[NSString  stringWithFormat:@"%@",dic[@"order_code"]] ,@"siId":user_id,@"orderState":@"3",@"type":@3};
        
        [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
            
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
            
                
                [self MBShow:@"自提成功" backview:self.view];
                
                [_Hang_dataScureArr removeObjectAtIndex:sender.tag];
                
                [_TableView reloadData];
                
                return ;
            }
            
            [self MBShow:@"自提失败,请重新确认" backview:self.view];
            
        } failure:^(NSError *error) {
            
            [self MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        
        
    }else {
        
        [self push:Vc];
    }
    
    
}
#pragma mark 确认发货后的协议
-(void)chooseclick:(NSInteger)type_section{
    
    [_Hang_dataScureArr removeObjectAtIndex:type_section];
    

    NSString * first = _bageNum_Arr[0];
    
    NSInteger  int_first = [first integerValue] -1;
    
    NSNumber * number = [NSNumber numberWithInteger:int_first];
    
     _bageNum_Arr[0] = [NSString stringWithFormat:@"%@",number];
    
    segment.title_numLabelArr = _bageNum_Arr;
    
    [self.TableView reloadData];
    
    
}

#pragma mark 点击去审核的button的事件
-(void)qushenhe:(UIButton *)sender{
    
    NSMutableArray  * json_Arr =  _Already_dataSourceArr[sender.tag];
    
    NSDictionary * dic = json_Arr[0];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
     NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    

    NSDictionary * dic_request = @{@"orderCode":[NSString stringWithFormat:@"%@",dic[@"order_code"]] ,@"shopInformationId":user_id,@"orderState":@7};
    
    
    [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
        
        
          NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            [self MBShow:@"审核成功" backview:self.view];

           [_Already_dataSourceArr removeObjectAtIndex:sender.tag];
            
            [_TableView reloadData];
         
            return ;
        }
        
        [self MBShow:@"审核失败,请重新审核" backview:self.view];
        
    } failure:^(NSError *error) {
        
       [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
#pragma mark 商家端的确认收货
-(void)shouhuo:(UIButton *)sender{
    
    
    NSMutableArray  * json_Arr =  _Already_dataSourceArr[sender.tag];
    
    NSDictionary * dic = json_Arr[0];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    
    
    NSDictionary * dic_request = @{@"orderCode":[NSString stringWithFormat:@"%@",dic[@"order_code"]] ,@"shopInformationId":user_id,@"orderState":@8};
    
    
    [ZHJQHttpToll GET:LPCSHENHE parameters:dic_request success:^(id responseObject) {
        
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            [self MBShow:@"收货成功" backview:self.view];
            
            [_Already_dataSourceArr removeObjectAtIndex:sender.tag ];
            
            [_TableView reloadData];
            
            return ;
        }
        
        [self MBShow:@"收货失败,请重新收货" backview:self.view];
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
#pragma mark 详情页的刷新
-(void)chooserefre:(NSString *)type{
    
    [self getdownrequest:type intde:1];

}

@end
