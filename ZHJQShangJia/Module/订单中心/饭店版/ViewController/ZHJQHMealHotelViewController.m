//
//  ZHJQHMealHotelViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHMealHotelViewController.h"
#import "LPCfandiandataArrModel.h"
#import "MJRefreshGifHeader.h"


@interface ZHJQHMealHotelViewController ()<UITextFieldDelegate,fandiandelegate>

@end

@implementation ZHJQHMealHotelViewController

-(void)upload{
    
    if([_type isEqualToString:@"1"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            [self upquset:@"未使用" leixing:@"单品"];
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            [self upquset:@"未使用" leixing:@"套餐"];
            
        }
    }if([_type isEqualToString:@"2"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            [self upquset:@"已使用" leixing:@"单品"];
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            [self upquset:@"已使用" leixing:@"套餐"];
            
        }
    }if([_type isEqualToString:@"3"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            [self upquset:@"已过期" leixing:@"单品"];
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            [self upquset:@"已过期" leixing:@"套餐"];
            
        }
    }

    
}
#pragma mark  上提网络
-(void)upquset:(NSString *)type leixing:(NSString *)leixing{
    
    [SHARE_APP showHud];
    
    [_TableView.mj_footer endRefreshing];
    
    NSDictionary * dict;
    
    if([type isEqualToString:@"未使用"]){
        
        if([leixing isEqualToString:@"单品"]){
            
            dict  = @{@"status":@1 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@1 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@1};
            
        }
        
        
    }if([type isEqualToString:@"已使用"]){
        
        
        if([leixing isEqualToString:@"单品"]){
            
            dict  = @{@"status":@2 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@2 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@1};
            
        }
        
        
    }if([type isEqualToString:@"已过期"]){
        
        if([leixing isEqualToString:@"单品"]){
            
            dict  = @{@"status":@3 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@3 ,@"Page":[NSNumber numberWithInteger:_indextPage],@"rows":@10,@"type":@1};
            
        }
        
        
    }
    
    [ZHJQHttpToll GET:LPCFANDIANLIEBIAO parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCfandiandataArrModel * model = [LPCfandiandataArrModel yy_modelWithJSON:dic_json];
        
        
        if(model.header.status == 0){
            
            if(_indextPage >= model.data.lastPage){
                
                [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_TableView.mj_footer endRefreshingWithNoMoreData];
                
            }else {
                
                _indextPage ++ ;
                
                [_TableView.mj_footer  resetNoMoreData];
                
            }
            
            
#pragma mark 未使用的单品的数据源
            if([type isEqualToString:@"未使用"] && [leixing isEqualToString:@"单品"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_danpinArr_weishiyong addObject:arr];
                    
                }
                
            }
            
#pragma mark 未使用的套餐的数据源
            if([type isEqualToString:@"未使用"] && [leixing isEqualToString:@"套餐"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_taocanArr_weishiyong addObject:arr];
                    
                }
                
            }
#pragma mark 已使用的单品的数据源
            if([type isEqualToString:@"已使用"] && [leixing isEqualToString:@"单品"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_danpinArr_yishiyong addObject:arr];
                    
                }
                
            }
            
#pragma mark 已使用的套餐的数据源
            if([type isEqualToString:@"已使用"] && [leixing isEqualToString:@"套餐"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_taocanArr_yishiyong addObject:arr];
                    
                }
                
            }
            
#pragma mark 已过期的单品的数据源
            if([type isEqualToString:@"已过期"] && [leixing isEqualToString:@"单品"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_danpinArr_yiguoqi addObject:arr];
                    
                }
                
            }
            
#pragma mark 已过期的套餐的数据源
            if([type isEqualToString:@"已过期"] && [leixing isEqualToString:@"套餐"]){
                
                
                for(NSMutableArray * arr in [model.data.rows mutableCopy]){
                    
                    [_taocanArr_yiguoqi addObject:arr];
                    
                }
                
            }
            
            [SHARE_APP hideHud];
            
            
            [_TableView  reloadData];
            
            return ;
        }
        
        [self MBShow:@"数据请求失败" backview:self.view];
        
        
        [_TableView  reloadData];
        
    } failure:^(NSError *error) {
        
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
        [_TableView reloadData];
        
    }];
    
    
}
#pragma mark  网络请求
-(void)requset:(NSString *)type leixing:(NSString *)leixing{
    
    [SHARE_APP showHud];
    
    _danpinArr_yiguoqi = [NSMutableArray array];

    _danpinArr_weishiyong = [NSMutableArray array];
    
    _danpinArr_yishiyong = [NSMutableArray array];
    
    
    _taocanArr_weishiyong = [NSMutableArray array];
    
    _taocanArr_yishiyong = [NSMutableArray array];
    
    _taocanArr_yiguoqi =[NSMutableArray array];

    _indextPage =1 ;
    
    NSDictionary * dict;
    
    if([type isEqualToString:@"未使用"]){
        
        if([leixing isEqualToString:@"单品"]){
            
             dict  = @{@"status":@1 ,@"Page":@1,@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@1 ,@"Page":@1,@"rows":@10,@"type":@1};
            
        }
    
        
    }if([type isEqualToString:@"已使用"]){
        
        
        if([leixing isEqualToString:@"单品"]){
            
            dict  = @{@"status":@2 ,@"Page":@1,@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@2 ,@"Page":@1,@"rows":@10,@"type":@1};
            
        }
        
        
    }if([type isEqualToString:@"已过期"]){
        
        if([leixing isEqualToString:@"单品"]){
            
            dict  = @{@"status":@3 ,@"Page":@1,@"rows":@10,@"type":@0};
            
        }if([leixing isEqualToString:@"套餐"]){
            
            dict  = @{@"status":@3 ,@"Page":@1,@"rows":@10,@"type":@1};
            
        }
        
        
    }
    
    [ZHJQHttpToll GET:LPCFANDIANLIEBIAO parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCfandiandataArrModel * model = [LPCfandiandataArrModel yy_modelWithJSON:dic_json];
      
        
        
        if(model.header.status == 0){
            
            if(_indextPage >= model.data.lastPage){
                
                [_Footer setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_TableView.mj_footer endRefreshingWithNoMoreData];
                
            }else {
                
                _indextPage ++ ;
                
                [_TableView.mj_footer  resetNoMoreData];
                
            }
            
            
#pragma mark 未使用的单品的数据源
            if([type isEqualToString:@"未使用"] && [leixing isEqualToString:@"单品"]){
                
                _danpinArr_weishiyong = [model.data.rows mutableCopy];

            }
            
#pragma mark 未使用的套餐的数据源
            if([type isEqualToString:@"未使用"] && [leixing isEqualToString:@"套餐"]){
                
                _taocanArr_weishiyong = [model.data.rows mutableCopy];
                
            }
#pragma mark 已使用的单品的数据源
            if([type isEqualToString:@"已使用"] && [leixing isEqualToString:@"单品"]){
                
                _danpinArr_yishiyong = [model.data.rows mutableCopy];
                
            }

#pragma mark 已使用的套餐的数据源
            if([type isEqualToString:@"已使用"] && [leixing isEqualToString:@"套餐"]){
                
                _taocanArr_yishiyong = [model.data.rows mutableCopy];
                
            }
            
#pragma mark 已过期的单品的数据源
            if([type isEqualToString:@"已过期"] && [leixing isEqualToString:@"单品"]){
                
                _danpinArr_yiguoqi= [model.data.rows mutableCopy];
                
            }
            
#pragma mark 已过期的套餐的数据源
            if([type isEqualToString:@"已过期"] && [leixing isEqualToString:@"套餐"]){
                
                _taocanArr_yiguoqi = [model.data.rows mutableCopy];
                
            }
     
            [SHARE_APP hideHud];
            
            [_TableView.mj_header endRefreshing];
            
            [_TableView  reloadData];
            
            return ;
        }
        
        [self MBShow:@"数据请求失败" backview:self.view];
       
        [_TableView.mj_header endRefreshing];
        
        [_TableView  reloadData];
        
    } failure:^(NSError *error) {
        
        [_TableView.mj_header endRefreshing];
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
        [_TableView reloadData];
        
    }];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};


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
    
    _oneOrtwo = @"1";
    
    _indextPage = 1;
    
    [self requset:@"未使用" leixing:@"单品"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    LPCSearBarViewController * ViewController = [[LPCSearBarViewController alloc]init];
    
    ViewController.type_string= @"饭店";
    
    [self push:ViewController];
    
    return NO;
}
-(void)Creat_UI{
    
    NSMutableArray * nameArr = [NSMutableArray arrayWithObjects:@"未使用",@"已使用",@"已过期", nil];
    
    LPCSegemView  * segment = [[LPCSegemView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) name:nameArr];
    
    segment.delegate = self;
    
    [self.view addSubview:segment];
    
    UIButton * button =  [[UIButton alloc]initWithFrame:CGRectMake(50, segment.frame.size.height + 7, (SCREEN_WIDTH - 150)/2, 30)];
    
    [button setBackgroundColor:COLOR(0, 196, 255, 1)];
    
    button.tag = 22;
    
    [button setTitle:@"单品预定订单" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [button.layer setMasksToBounds: true];
    
    button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize  -5];
    
    button.titleLabel.adjustsFontSizeToFitWidth = true;
    
    [button addTarget:self action:@selector(button_cilck) forControlEvents:UIControlEventTouchUpInside];
    
    [button.layer setCornerRadius:15];
    
    [self.view addSubview:button];
    
    
    UIButton * button_ =  [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH - 150)/2 -50, segment.frame.size.height + 7, (SCREEN_WIDTH - 150)/2, 30)];
    
    [button_ setBackgroundColor:[UIColor clearColor]];
    
    button_.tag = 23;
    
    [button_ setTitle:@"套餐预定订单" forState:UIControlStateNormal];
    
    [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button_.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [button_.layer setMasksToBounds: true];
    
    button_.titleLabel.font = [UIFont systemFontOfSize:button_.titleLabel.font.pointSize  -5];
    
    [button_ addTarget:self action:@selector(button_click_one) forControlEvents:UIControlEventTouchUpInside];
    
    button_.titleLabel.adjustsFontSizeToFitWidth = true;
    
    [button_.layer setCornerRadius:15];
    
    [self.view addSubview:button_];
    
    
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segment.frame.size.height + 45, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height-85)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [UIView new];
        
        _TableView.backgroundColor = COLOR(237, 242, 249, 1);
        
        _TableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
            
            if([_type isEqualToString:@"1"]){
                
                if([_oneOrtwo isEqualToString:@"1"]){
                    
                    [self requset:@"未使用" leixing:@"单品"];
                    
                }if([_oneOrtwo isEqualToString:@"2"]){
                    
                    [self requset:@"未使用" leixing:@"套餐"];
                    
                }
            }if([_type isEqualToString:@"2"]){
                
                if([_oneOrtwo isEqualToString:@"1"]){
                    
                    [self requset:@"已使用" leixing:@"单品"];
                    
                }if([_oneOrtwo isEqualToString:@"2"]){
                    
                    [self requset:@"已使用" leixing:@"套餐"];
                    
                }
            }if([_type isEqualToString:@"3"]){
                
                if([_oneOrtwo isEqualToString:@"1"]){
                    
                    [self requset:@"已过期" leixing:@"单品"];
                    
                }if([_oneOrtwo isEqualToString:@"2"]){
                    
                    [self requset:@"已过期" leixing:@"套餐"];
                    
                }
            }
            
            
        }];
        
        _Footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(upload)];
        
        _TableView.mj_footer = _Footer;
        
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
    
    NSInteger  section = indexPath.section;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    //[self.TableView       setSeparatorStyle:UITableViewCellSeparatorStyleNone];

#pragma mark 未使用
    if([_type isEqualToString:@"1"]){
        
        
#pragma mark  未使用的单品
        if([_oneOrtwo  isEqualToString:@"1"]){
            
            

            NSMutableArray  * data_Arr = _danpinArr_weishiyong[section];
            
            
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
                
                
                
                UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width - 30, 40)];
                
                timeLaebl.textAlignment = NSTextAlignmentLeft;
            
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
#warning LPC 单品没有取消订单
                  //  [cell.contentView addSubview:button_one];
                
            }
            
         
        }
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            
            NSMutableArray  * data_Arr = _taocanArr_weishiyong[section];
            
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            NSString * urlimages = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlimages] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            NSString * eattime =[NSString stringWithFormat:@"就餐时间 : %@ \n 数量 :  %@",dic[@"eat_date"],dic[@"quantity"]];
            
            timeLaebl.text =  eattime;
            
            
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
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:COLOR(255, 63, 81, 1)];
            
            [button setTitle:@"验证核销" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
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
            
            button_one.layer.cornerRadius = 7;
            
            button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
            
            button_one.layer.borderWidth = .5;
            
            //[cell.contentView addSubview:button_one];
            
            
            [button addTarget:self action:@selector(fandianyanzhenghexiao:) forControlEvents:UIControlEventTouchUpInside];
            
            [button_one addTarget:self action:@selector(dandianquxiaodingdan:) forControlEvents:UIControlEventTouchUpInside];

        }
        
    }
#pragma mark 已使用
    if([_type isEqualToString:@"2"]){
        
        
#pragma mark  已使用的单品
        if([_oneOrtwo  isEqualToString:@"1"]){
            

            NSMutableArray  * data_Arr = _danpinArr_yishiyong[section];
            
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"describe_img"]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
            
            
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
            
            
            if(row == data_Arr.count - 1){
                
                UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height , SCREEN_WIDTH , .4)];
                
                henglabel.backgroundColor = [UIColor lightGrayColor];
                
                [cell.contentView addSubview:henglabel];
                
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"交易完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }
            
           
            
    
            
        }
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            
            
            NSMutableArray  * data_Arr = _taocanArr_yishiyong[section];
            
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            NSString * urlstring = [NSString stringWithFormat:@"%@",dic[@"describe_img"]];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlstring] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =[self getstring:[NSString stringWithFormat:@"%@",dic[@"name"] ]];//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
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
            
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height , SCREEN_WIDTH , .4)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7 + allLable.frame.size.height + allLable.frame.origin.y, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"交易完成" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        
        }
        
    }
#pragma mark 已过期
    if([_type isEqualToString:@"3"]){
        
        
#pragma mark  已过期的单品
        if([_oneOrtwo  isEqualToString:@"1"]){
            
            
            NSMutableArray  * data_Arr = _danpinArr_yiguoqi[section];
            
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"describe_img"]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
            
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
            
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height , SCREEN_WIDTH , .4)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
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
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            
            
            NSMutableArray  * data_Arr = _taocanArr_yiguoqi[section];
            
            
            NSDictionary  *dic = data_Arr[row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15 , 110, 90)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[self getstring:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]]] placeholderImage:[UIImage imageNamed:@"LPCzhanweifu"]];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text =dic[@"name"] ;//model.name;
            
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            
            timeLaebl.text =  [@"就餐时间 : " stringByAppendingString:dic[@"eat_date"]]; //@"就餐时间 : 2016.06.21  18:30";
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
            
            
            UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height , SCREEN_WIDTH , .4)];
            
            henglabel.backgroundColor = [UIColor lightGrayColor];
            
            [cell.contentView addSubview:henglabel];
            
            
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

    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // NSInteger section = indexPath.section;
    
    
    LPCHoteEatDeleViewController * eatViewController = [[LPCHoteEatDeleViewController alloc]init];
    
    LPCHotelYesViewController  * JDViewcontroller = [[LPCHotelYesViewController alloc]init];
    
    LPCHoteloverViewController  * overViewControllerr = [[LPCHoteloverViewController alloc]init];
    
    
    if([_type isEqualToString:@"1"]){
        
        NSString  * idString = @"";
    
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray * data_Arr = _danpinArr_weishiyong[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            NSMutableArray * data_Arr = _taocanArr_weishiyong[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            eatViewController.imageUrl = [self getstring:[NSString stringWithFormat:@"%@",dic[@"describe_img"]]];
            
        }
        
        
        
        eatViewController.oneTwo = _oneOrtwo;
        
        eatViewController.idString = idString;
        
        eatViewController.object = self;
        
        [self push:eatViewController];
        
        
    }if([_type isEqualToString:@"2"]){
        
        
        NSString  * idString = @"";
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray * data_Arr = _danpinArr_yishiyong[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            NSMutableArray * data_Arr = _taocanArr_yishiyong[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
             JDViewcontroller.imageUrl = [self getstring:[NSString  stringWithFormat:@"%@",dic[@"describe_img"]]];
            
        }
        
        
        
        JDViewcontroller.oneTwo = _oneOrtwo;
        
        JDViewcontroller.idString = idString;
    
        
        [self push:JDViewcontroller];
        
        
    }if([_type isEqualToString:@"3"]){
        
        
        NSString  * idString = @"";
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray * data_Arr =_danpinArr_yiguoqi[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            
            
        }if([_oneOrtwo isEqualToString:@"2"]){
            
            NSMutableArray * data_Arr = _taocanArr_yiguoqi[indexPath.section];
            
            NSDictionary * dic = data_Arr[0];
            
            idString = [self getstring:[NSString stringWithFormat:@"%@",dic[@"order_code"]]];
            
            overViewControllerr.imageUrl = [self getstring:[NSString  stringWithFormat:@"%@",dic[@"describe_img"]]];
            
        }
        
        
        
        overViewControllerr.oneTwo = _oneOrtwo;
        
        overViewControllerr.idString = idString;
        
        [self push:overViewControllerr];
        
        
    }
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
#pragma mark 未使用的 row 的个数
    if([_type isEqualToString:@"1"] && [_oneOrtwo isEqualToString:@"1"]){
        
        NSMutableArray * data =  _danpinArr_weishiyong[section];
        
        return data.count;
        
    }
    
    if([_type isEqualToString:@"1"] && [_oneOrtwo isEqualToString:@"2"]){
        
        NSMutableArray * data =  _taocanArr_weishiyong[section];
        
        return data.count;
        
    }
    
#pragma mark 已使用的 row 的个数
    if([_type isEqualToString:@"2"] && [_oneOrtwo isEqualToString:@"1"]){
        
        NSMutableArray * data =  _danpinArr_yishiyong[section];
        
        return data.count;
        
    }
    
    if([_type isEqualToString:@"2"] && [_oneOrtwo isEqualToString:@"2"]){
        
        NSMutableArray * data =  _taocanArr_yishiyong[section];
        
        return data.count;
        
    }
    
    
#pragma mark 已过期的 row 的个数
    if([_type isEqualToString:@"3"] && [_oneOrtwo isEqualToString:@"1"]){
        
        NSMutableArray * data =  _danpinArr_yiguoqi[section];
        
        return data.count;
        
    }
    
    if([_type isEqualToString:@"3"] && [_oneOrtwo isEqualToString:@"2"]){
        
        NSMutableArray * data =  _taocanArr_yiguoqi[section];
        
        return data.count;
        
    }
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([_type isEqualToString:@"1"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray *data = _danpinArr_weishiyong[indexPath.section];
            
            if(indexPath.row == data.count-1){
                
                return 120 +44;
                
            }
            
        }
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            return 120+44;
            
        }
        
    }
    
    if([_type isEqualToString:@"2"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray *data = _danpinArr_yishiyong[indexPath.section];
            
            if(indexPath.row == data.count-1){
                
                return 120 +44;
                
            }
            
        }
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            return 120+44;
            
        }
        
    }if([_type isEqualToString:@"3"]){
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            NSMutableArray *data = _danpinArr_yiguoqi[indexPath.section];
            
            if(indexPath.row == data.count-1){
                
                return 120 +44;
                
            }
            
        }
        
        if([_oneOrtwo isEqualToString:@"2"]){
            
            return 120+44;
            
        }
        
    }
    
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#pragma mark 未使用的section 的个数
    if([_type isEqualToString:@"1"] && [_oneOrtwo isEqualToString:@"1"]){
        
        return _danpinArr_weishiyong.count;
        
    }
    
    if([_type isEqualToString:@"1"] && [_oneOrtwo isEqualToString:@"2"]){
        
        return _taocanArr_weishiyong.count;
        
    }
    
    
 #pragma mark 已使用的section 的个数
    if([_type isEqualToString:@"2"] && [_oneOrtwo isEqualToString:@"1"]){
        
        return _danpinArr_yishiyong.count;
        
    }
    
    if([_type isEqualToString:@"2"] && [_oneOrtwo isEqualToString:@"2"]){
        
        return _taocanArr_yishiyong.count;
        
    }
    
#pragma mark 已过期的section 的个数
    if([_type isEqualToString:@"3"] && [_oneOrtwo isEqualToString:@"1"]){
        
        return _danpinArr_yiguoqi.count;
        
    }
    
    if([_type isEqualToString:@"3"] && [_oneOrtwo isEqualToString:@"2"]){
        
        return _taocanArr_yiguoqi.count;
        
    }
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIView * view_one  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view_one.backgroundColor = [_TableView backgroundColor];
    
    [view addSubview:view_one];
    
    
    
#pragma mark 未使用的单品
    if([_type isEqualToString:@"1"] && [_oneOrtwo  isEqualToString:@"1"]){
        
        NSMutableArray * data = _danpinArr_weishiyong[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 + 5, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 5+ 7, 30, 30)];
        
       
        
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
        
        
    }
    
#pragma mark 套餐的未使用的订单
    if([_type isEqualToString:@"1"] && [_oneOrtwo  isEqualToString:@"2"]){
        
        NSMutableArray * data = _taocanArr_weishiyong[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5 + 7, SCREEN_WIDTH -10, 30)];
        
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
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7 + 5, 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
    }
    
#pragma mark 已使用单品的订单
    if([_type isEqualToString:@"2"] && [_oneOrtwo  isEqualToString:@"1"]){
        
        NSMutableArray * data = _danpinArr_yishiyong[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 +5, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7 + 5, 30, 30)];
        
        
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
        
        
    }
    
    
#pragma mark 已使用套餐的订单
    if([_type isEqualToString:@"2"] && [_oneOrtwo  isEqualToString:@"2"]){
        
        NSMutableArray * data = _taocanArr_yishiyong[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 +5 , SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7 +5 , 30, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7 +5 , 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
    }
    
    
    
#pragma mark 已过期单品的订单
    if([_type isEqualToString:@"3"] && [_oneOrtwo  isEqualToString:@"1"]){
        
        NSMutableArray * data = _danpinArr_yiguoqi[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7 +5 , SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7 +5 , 30, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7 +5 , 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
    }
    
    
#pragma mark 已过期套餐的订单
    if([_type isEqualToString:@"3"] && [_oneOrtwo  isEqualToString:@"2"]){
        
        NSMutableArray * data = _taocanArr_yiguoqi[section];
        
        NSDictionary *dic = data[0];
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,  7 +5 , SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        NSString * code_String = [@"订单号 : " stringByAppendingString:dic[@"order_code"]];
        
        
        orlderLabel.text = code_String;
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [view  addSubview:orlderLabel];
        
        
        UIImageView * imageView_one = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7 +5 , 30, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"head_img"]] isEqualToString:@"<null>"]){
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: @"123"] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
            
        }else {
            
            [imageView_one sd_setImageWithURL:[NSURL URLWithString: dic[@"head_img"]] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
        }
        
        imageView_one.layer.masksToBounds =true;
        
        imageView_one.layer.cornerRadius = 15;
        
        [view  addSubview:imageView_one];
        
        
        UILabel * nameLabel_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7 +5 , 80, 30)];
        
        if([[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",dic[@"nick_name"]] isEqualToString:@"<null>"]){
            
            nameLabel_one.text =@"";
            
        }else {
            
            nameLabel_one.text = [NSString stringWithFormat:@"%@",dic[@"nick_name"]] ;
        }
        
        nameLabel_one.adjustsFontSizeToFitWidth = true;
        
        [view addSubview:nameLabel_one];
        
        
    }
    
    return view;
    
}

-(void)index:(NSInteger)segmentindex type:(NSString *)type{
    
    if([type isEqualToString:@"未使用"]){
        
        _type = @"1";
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
              [self requset:type leixing:@"单品"];
        }
        if([_oneOrtwo isEqualToString:@"2"]){
            
            [self requset:type leixing:@"套餐"];
        }
      
        
    }
        
    
    if([type isEqualToString:@"已使用"]){
        
        _type = @"2";

        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            [self requset:type leixing:@"单品"];
        }
        if([_oneOrtwo isEqualToString:@"2"]){
            
            [self requset:type leixing:@"套餐"];
        }
        
    }
    
    
    if([type isEqualToString:@"已过期"]){
        
        _type = @"3";
        
        if([_oneOrtwo isEqualToString:@"1"]){
            
            [self requset:type leixing:@"单品"];
        }
        if([_oneOrtwo isEqualToString:@"2"]){
            
            [self requset:type leixing:@"套餐"];
        }
    }

}

#pragma mark 俩个按钮的点击事件
-(void)button_cilck{
    
    UIButton * button = (UIButton *)[self.view viewWithTag:22];
    
    UIButton * button_ = (UIButton *)[self.view viewWithTag:23];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:COLOR(0, 196, 255, 1)];
    
    [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button_ setBackgroundColor:[UIColor clearColor]];
    
    _oneOrtwo = @"1";
    
    /*
     if([_oneOrtwo isEqualToString:@"1"]){
     
     [self requset:type leixing:@"单品"];
     }
     if([_oneOrtwo isEqualToString:@"2"]){
     
     [self requset:type leixing:@"套餐"];
     }
     */
    
    if([_type isEqualToString:@"1"]){
        
        [self requset:@"未使用" leixing:@"单品"];
        
    }
    
    if([_type isEqualToString:@"2"]){
        
        [self requset:@"已使用" leixing:@"单品"];
        
    }
    
    if([_type isEqualToString:@"3"]){
        
        [self requset:@"已过期" leixing:@"单品"];
        
    }
}

-(void)button_click_one{
    
    UIButton * button = (UIButton *)[self.view viewWithTag:23];
    
    UIButton * button_ = (UIButton *)[self.view viewWithTag:22];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:COLOR(0, 196, 255, 1)];
    
    [button_ setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button_ setBackgroundColor:[UIColor clearColor]];
    
    _oneOrtwo = @"2";
    
    
    if([_type isEqualToString:@"1"]){
        
        [self requset:@"未使用" leixing:@"套餐"];
        
    }
    
    if([_type isEqualToString:@"2"]){
        
        [self requset:@"已使用" leixing:@"套餐"];
        
    }
    
    if([_type isEqualToString:@"3"]){
        
        [self requset:@"已过期" leixing:@"套餐"];
        
    }
    
    
}

#pragma mark 取消订单
-(void)dandianquxiaodingdan:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
          
            
            [SHARE_APP showHud];
            
            NSMutableArray * Arr = [NSMutableArray array];
            
            if([_oneOrtwo isEqualToString:@"1"]){
                
                Arr = _danpinArr_weishiyong[sender.tag];
                
            }else {
                
                Arr = _taocanArr_weishiyong[sender.tag];
            }
            
            NSDictionary * dic_darr = Arr[0];
            
            NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
            
            NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
            
            NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"],@"siId":user_id};
            
            [ZHJQHttpToll GET:LPCFANDIANQUXIAODINGDN parameters:dic success:^(id responseObject) {
                
                NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                if([[self headdic:dic_json] isEqualToString:@"0"]){
                    
                    [SHARE_APP  hideHud];
                    
                    if([_oneOrtwo isEqualToString:@"1"]){
                        
                        [self requset:@"未使用" leixing:@"单品"];
                    }
                    if([_oneOrtwo isEqualToString:@"2"]){
                        
                        [self requset:@"未使用" leixing:@"套餐"];
                    }
                    
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
#pragma mark 验证核销
-(void)fandianyanzhenghexiao:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    

    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
         dispatch_after(0.2, dispatch_get_main_queue(), ^{
            
             [SHARE_APP showHud];
             
             NSMutableArray * Arr = [NSMutableArray array];
             
             if([_oneOrtwo isEqualToString:@"1"]){
                 
                 Arr = _danpinArr_weishiyong[sender.tag];
                 
             }else {
                 
                 Arr = _taocanArr_weishiyong[sender.tag];
             }
             
             NSDictionary * dic_darr = Arr[0];
             
//             NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
//             
//             NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
             
             NSDictionary  *  dic = @{@"orderCode":dic_darr[@"order_code"]};
             
             [ZHJQHttpToll GET:LPCFANDIANYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
                 
                 NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                 
                 if([[self headdic:dic_json] isEqualToString:@"0"]){
                     
                     [SHARE_APP  hideHud];
                     
                     if([_oneOrtwo isEqualToString:@"1"]){
                         
                         [self requset:@"未使用" leixing:@"单品"];
                     }
                     if([_oneOrtwo isEqualToString:@"2"]){
                         
                         [self requset:@"未使用" leixing:@"套餐"];
                     }
                     
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

-(void)fandianhuidiao:(NSString *)type one:(NSString *)onetwo{
    
    
    [self  requset:type leixing:onetwo];
    
}
@end
