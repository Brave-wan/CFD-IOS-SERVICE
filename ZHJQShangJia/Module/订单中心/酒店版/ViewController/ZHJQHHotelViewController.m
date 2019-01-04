//
//  ZHJQHHotelViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHHotelViewController.h"
#import "MJRefreshGifHeader.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"

@interface ZHJQHHotelViewController ()<indextDelegate>

@end

@implementation ZHJQHHotelViewController

-(void)download{
    
    [_TableView.mj_header beginRefreshing];

    
    if([_type isEqualToString:@"1"]){
        
         [self getArr:@"未使用"];
    }if([_type isEqualToString:@"2"]){
        
        [self getArr:@"已使用"];
    }if([_type isEqualToString:@"3"]){
        
        [self getArr:@"已过期"];
    }
    
   
    
}
#pragma mark 网络请求
/**
 *  酒店列表的数据源
 *
 *  @param type 类型
 */
-(void)getArr:(NSString *)type{
    
    _indexPage = 1;
    
    _data_scoureArr = [NSMutableArray array];
    
    _data_guoqi_scoureArr = [NSMutableArray array];
    
    _data_shiyong_scoureArr =[NSMutableArray array];
    
    NSDictionary * dict;
    
    if([type isEqualToString:@"未使用"]){
        
         dict  = @{@"status":@1 ,@"page":@1,@"rows":@10};
        
    }if([type isEqualToString:@"已使用"]){
        
        dict  = @{@"status":@2 ,@"page":@1,@"rows":@10};
        
    }if([type isEqualToString:@"已过期"]){
        
        dict  = @{@"status":@3 ,@"page":@1,@"rows":@10};
        
        NSLog(@"已过期的参数:%@",dict);
        
    }
    
    
    
    [SHARE_APP showHud];
    
    [ZHJQHttpToll GET:LPCJIUDIANLIEBIAO parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCJiudianliebiaoModel  * model = [LPCJiudianliebiaoModel yy_modelWithJSON:dic_json];
        
        if(_indexPage >= model.data.lastPage){
            
            [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
            
            [_TableView.mj_footer endRefreshingWithNoMoreData];
            
        }else {
            
             _indexPage ++ ;
            
            [_TableView.mj_footer resetNoMoreData];
            
        }
        
        
        if(model.header.status == 0){
            
             [SHARE_APP hideHud];
            
            if([_type isEqualToString:@"1"]){
                
                _data_scoureArr = [model.data.rows mutableCopy];
                
            }
            if([_type isEqualToString:@"2"]){
                
                _data_shiyong_scoureArr = [model.data.rows mutableCopy];
                
            }
            if([_type isEqualToString:@"3"]){
                
                _data_guoqi_scoureArr = [model.data.rows mutableCopy];
                
            }
            
            [_TableView.mj_header endRefreshing];

            
            [_TableView reloadData];
            
            return ;
            
        }
        [_TableView.mj_header endRefreshing];

        [self MBShow:@"请求失败" backview:self.view];
       
        
    } failure:^(NSError *error) {
     
        [_TableView.mj_header endRefreshing];

        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
    
}


#pragma mark 验证核销
-(void)yanzhenghexiao:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        LPCJIudianliebiaoRows * model = _data_scoureArr[sender.tag];
        
        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
               [self getArr:@"未使用"];
                
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
        
        LPCJIudianliebiaoRows * model = _data_scoureArr[sender.tag];
        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCQUXIAODINGDAN parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                [self getArr:@"未使用"];
                
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


-(void)chooserefre:(NSString *)type{
    
    [self getArr:type];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};

    
    _data_scoureArr = [NSMutableArray array];
   
    _data_guoqi_scoureArr = [NSMutableArray array];
    
    _data_shiyong_scoureArr =[NSMutableArray array];
    

    [self backColor:COLOR(237, 243, 248, 1)];
    
    _type = @"1";
    
    _searchBar = [[LPCCustomTextFild alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH -100, 30)];
    
    _searchBar.placeholder = @"  订单号、下单人";
    
    [_searchBar setValue:COLOR(61, 162, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    [_searchBar setValue:[UIFont systemFontOfSize:_searchBar.font.pointSize -4] forKeyPath:@"_placeholderLabel.font"];
    
    _searchBar.font = [UIFont systemFontOfSize:_searchBar.font.pointSize - 4];
    
    [_searchBar setBackgroundColor:COLOR(26, 122, 187, 1)];
    
    _searchBar.layer.masksToBounds = true;
    
    _searchBar.layer.cornerRadius = _searchBar.frame.size.height/2;
    
    _searchBar.leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, _searchBar.frame.size.height)];
    
    _searchBar.textColor = [UIColor whiteColor];
    
    _searchBar.delegate = self;
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView * rihgt = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, _searchBar.frame.size.height)];
    
    rihgt.image = [UIImage imageNamed:@"a2_sousuo"];
    
    rihgt.contentMode = UIViewContentModeCenter;
    
    _searchBar.rightView = rihgt;
    
    _searchBar.rightViewMode = UITextFieldViewModeAlways;
    
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    self.navigationItem.titleView = _searchBar;
    
    [self Creat_UI];

    [self getArr:@"未使用"];
    
    _type = @"1";
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    LPCSearcherjiudianViewController * ViewController = [[LPCSearcherjiudianViewController alloc]init];
    
    ViewController.type_string = @"酒店";
    
    [self push:ViewController];
    
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Creat_UI{
    
    NSMutableArray * nameArr = [NSMutableArray arrayWithObjects:@"未使用",@"已使用",@"已过期", nil];
    
    LPCSegemView  * segment = [[LPCSegemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) name:nameArr];
    
    segment.delegate = self;
    
    [self.view addSubview:segment];
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segment.frame.size.height + 5, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height-45)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [UIView new];
        
        _TableView.backgroundColor = COLOR(237, 242, 249, 1);
        
        _TableView.mj_header = [MJChiBaoZiHeader  headerWithRefreshingTarget:self refreshingAction:@selector(download)];
        
        _Footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(upload)];
        
        _TableView.mj_footer = _Footer;
        
        
        [self.view addSubview:_TableView];
        
    }
    
}
-(void)upload{
    
    [_TableView.mj_footer beginRefreshing];
    
    
    if([_type isEqualToString:@"1"]){
        
        [self loarequser:@"未使用"];
    }if([_type isEqualToString:@"2"]){
        
        [self loarequser:@"已使用"];
    }if([_type isEqualToString:@"3"]){
        
        [self loarequser:@"已过期"];
    }
}
-(void)loarequser:(NSString *)type{

    
        NSDictionary * dict;
        
        if([type isEqualToString:@"未使用"]){
            
            dict  = @{@"status":@1 ,@"page":[NSNumber numberWithInteger:_indexPage],@"rows":@10};
            
        }if([type isEqualToString:@"已使用"]){
            
            dict  = @{@"status":@2 ,@"page":[NSNumber numberWithInteger:_indexPage],@"rows":@10};
            
        }if([type isEqualToString:@"已过期"]){
            
            dict  = @{@"status":@3 ,@"page":[NSNumber numberWithInteger:_indexPage],@"rows":@10};
            
        }
        
        
        
        [SHARE_APP showHud];
        
        [ZHJQHttpToll GET:LPCJIUDIANLIEBIAO parameters:dict success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            LPCJiudianliebiaoModel  * model = [LPCJiudianliebiaoModel yy_modelWithJSON:dic_json];
            
            if(_indexPage >= model.data.lastPage){
                
                [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_TableView.mj_footer endRefreshingWithNoMoreData];
                
            }else {
                
                _indexPage ++ ;
                
                [_TableView.mj_footer resetNoMoreData];
                
            }
            
            
            if(model.header.status == 0){
                
                [SHARE_APP hideHud];
                
                if([_type isEqualToString:@"1"]){
                    
                    for (NSDictionary * dic  in [model.data.rows mutableCopy]) {
                        
                        [_data_scoureArr addObject:dic];
                        
                    }
                    
                    
                }
                if([_type isEqualToString:@"2"]){
                    
                    
                    for (NSDictionary * dic  in [model.data.rows mutableCopy]) {
                        
                        [_data_shiyong_scoureArr addObject:dic];
                        
                    }
                    
                }
                if([_type isEqualToString:@"3"]){
                    
                    for (NSDictionary * dic  in [model.data.rows mutableCopy]) {
                        
                        [_data_guoqi_scoureArr addObject:dic];
                        
                    }
                    
                    
                }
                
                [_TableView.mj_footer endRefreshing];
                
                
                [_TableView reloadData];
                
                return ;
                
            }
            [_TableView.mj_footer endRefreshing];
            
            [self MBShow:@"请求失败" backview:self.view];
            
            
        } failure:^(NSError *error) {
            
            [_TableView.mj_footer endRefreshing];
            
            [self MBShow:@"服务器繁忙" backview:self.view];
            
        }];
        

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
    
    NSInteger section = indexPath.section;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    if([_type isEqualToString:@"1"]){
        
        LPCJIudianliebiaoRows * model = _data_scoureArr[section];
        
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
            
            orlderLabel.textAlignment = NSTextAlignmentLeft;
            
        orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model.order_code];//@"订单号 : 306954231";
            
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
            
        
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
        nameLabel.text = model.name;//@"双人房";
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
       
             NSString * string = [NSString stringWithFormat:@"房间数 : %ld间 \n入住 : %@ \n离店:%@   %ld晚",(long)model.quantity, model.start_date,model.end_date,(long)model.check_days];
        
            timeLaebl.text = string;
            
            timeLaebl.numberOfLines = 0 ;
        
        
        
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
            
        NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%ld",(long)model.real_price
                          ];
        
        allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
            
            UIColor * color = COLOR(255, 70, 78, 1);
        
        NSString * lengsyinh= [NSString stringWithFormat:@"%ld",(long)model.real_price];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, lengsyinh.length + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.size.height + allLable.frame.origin.y , SCREEN_WIDTH, .4)];
        
        henglabel.backgroundColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
           
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
                
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
        
        [button_one addTarget:self action:@selector(quxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = row;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
               // [cell.contentView addSubview:button_one];
                
                
        
        
    }    if([_type isEqualToString:@"2"]){
        
        LPCJIudianliebiaoRows * model = _data_shiyong_scoureArr[section];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model.order_code];//@"订单号 : 306954231";
        
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
        
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel.text = model.name;//@"双人房";
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
        UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
        
        timeLaebl.textAlignment = NSTextAlignmentLeft;
        
        NSString * string = [NSString stringWithFormat:@"房间数 : %ld间 \n入住 : %@ \n离店:%@   %ld晚",(long)model.quantity, model.start_date,model.end_date,(long)model.check_days];
        
        timeLaebl.text = string;
        
        timeLaebl.numberOfLines = 0 ;
        
        
        
        timeLaebl.textColor = [UIColor lightGrayColor];
        
        timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
        
        [cell.contentView addSubview:timeLaebl];
        
        
        UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
        
        NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%ld",(long)model.real_price
                          ];
        
        allLable.textColor = [UIColor blackColor];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
        
        UIColor * color = COLOR(255, 70, 78, 1);
        
        NSString * lengsyinh= [NSString stringWithFormat:@"%ld",(long)model.real_price];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(5, lengsyinh.length + 1)];
        
        allLable.attributedText = AttributedStr;
        
        
        [cell.contentView addSubview:allLable];
        
        
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.size.height + allLable.frame.origin.y , SCREEN_WIDTH, .4)];
        
        henglabel.backgroundColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
        
       UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"交易完成" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = section;
        
        button.enabled = false;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];

        
        
        
        
    }
    
    
    
    if([_type isEqualToString:@"3"]){
        
        LPCJIudianliebiaoRows * model = _data_guoqi_scoureArr[section];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        orlderLabel.text = [NSString stringWithFormat:@"订单号 :%@",model.order_code];//@"订单号 : 306954231";
        
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
        
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, nameLabel_one.frame.size.height + 7 + 5, 110, 90)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.describe_img] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
        
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
        
        nameLabel.text = model.name;//@"双人房";
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
        UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 60)];
        
        timeLaebl.textAlignment = NSTextAlignmentLeft;
        
        NSString * string = [NSString stringWithFormat:@"房间数 : %ld间 \n入住 : %@ \n离店:%@   %ld晚",(long)model.quantity, model.start_date,model.end_date,(long)model.check_days];
        
        timeLaebl.text = string;
        
        timeLaebl.numberOfLines = 0 ;
        
        
        
        timeLaebl.textColor = [UIColor lightGrayColor];
        
        timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - LPCJIUDIANHEGIHT];
        
        [cell.contentView addSubview:timeLaebl];
        
        
        UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y , timeLaebl.frame.size.width, 30)];
        
        NSString* all  = [ NSString  stringWithFormat:@"总额 : ￥%ld",(long)model.real_price
                          ];
        
        allLable.textColor = [UIColor blackColor];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:all];
        
        UIColor * color = COLOR(255, 70, 78, 1);
        
        NSString * lengsyinh= [NSString stringWithFormat:@"%ld",(long)model.real_price];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:NSMakeRange(5, lengsyinh.length + 1)];
        
        allLable.attributedText = AttributedStr;
        
        
        [cell.contentView addSubview:allLable];
        
        UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.size.height + allLable.frame.origin.y , SCREEN_WIDTH, .4)];
        
        henglabel.backgroundColor = [UIColor lightGrayColor];
        
        [cell.contentView addSubview:henglabel];
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"已过期" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = section;
        
        button.enabled = false;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
        
        
        
    }
    
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 酒店
    
    LPCHotelNOViewController  * JDViewcontroller = [[LPCHotelNOViewController alloc]init];
    
    
    LPCHotelOkViewController  * OkViewController = [[LPCHotelOkViewController alloc]init];
    
    LPCHoteloverdueViewController * Viewcontroller = [[LPCHoteloverdueViewController alloc]init];
    
    
   if([_type isEqualToString:@"1"]){
       
       
       LPCJIudianliebiaoRows * model = _data_scoureArr[indexPath.section];
       
       JDViewcontroller.idString = model.order_code;
       
       JDViewcontroller.object= self;
    
        [self push:JDViewcontroller];
        
        
   }if([_type isEqualToString:@"2"]){
       
       
       LPCJIudianliebiaoRows * model = _data_shiyong_scoureArr[indexPath.section];
       
       OkViewController.idString = model.order_code;
       
       [self push:OkViewController];
       
       
   }if([_type isEqualToString:@"3"]){
       
       
       LPCJIudianliebiaoRows * model = _data_guoqi_scoureArr[indexPath.section];
       
       Viewcontroller.idString = model.order_code;
       
       [self push:Viewcontroller];
       
       
   }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /*if([_type isEqualToString:@"1"]){
        
        return _data_scoureArr.count;
        
    } if([_type isEqualToString:@"2"]){
        
        return _data_shiyong_scoureArr.count;
        
    } if([_type isEqualToString:@"3"]){
        
        return _data_guoqi_scoureArr.count;
        
    }*/
    
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 +44*2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    if([_type isEqualToString:@"1"]){
        
        return _data_scoureArr.count;
        
    } if([_type isEqualToString:@"2"]){
        
        return _data_shiyong_scoureArr.count;
        
    } if([_type isEqualToString:@"3"]){
        
        return _data_guoqi_scoureArr.count;
        
    }

    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 5;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = self.view.backgroundColor ;
    
    return view;
    
    
}

-(void)index:(NSInteger)segmentindex type:(NSString *)type{
    
    if([type isEqualToString:@"未使用"]){
        
        _type = @"1";

    }
    if([type isEqualToString:@"已使用"]){
        
        _type = @"2";
        
    } if([type isEqualToString:@"已过期"]){
        
        _type = @"3";
    }
    
        
    [self getArr:type];
    

    
}

@end
