//
//  LPCInformationViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/1.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCInformationViewController.h"
#import "LPCShopCeneterModel.h"
#import "UIImageView+WebCache.h"

@interface LPCInformationViewController ()

#pragma mark ========================================================================
// 商品版的头部图片
@property (nonatomic ,strong) UIImageView * headImage;

// 商品版的头像
@property (nonatomic ,strong) UIImageView * headimageView;

// 商品版的昵称
@property (nonatomic ,strong) UILabel * label;

// 地理位置
@property (nonatomic ,strong) NSString * address_string;

// 商品版的电话
@property (nonatomic ,strong) NSString * tel_string;

// 商品版的简介
@property (nonatomic ,strong) NSString * coontent_string;

// 地理位置的高度
@property (nonatomic ,assign) float  section_one_hegit;

// 简介的高度
@property (nonatomic ,assign) float  section_one_row_hegit;

#pragma mark 饭店版 ===================================================================

// 饭店名称
@property (nonatomic ,strong) NSString * name_string;

// 饭店地理位置
@property (nonatomic ,strong) NSString * address_tow_string;

// 饭店电话
@property (nonatomic ,strong) NSString * tel_two_string;

// 饭店简介
@property (nonatomic ,strong) NSString * content_two_string;

// 饭店的地理位置的高度
@property (nonatomic ,assign) float   section_two_hegit;

// 饭店简介的高度
@property (nonatomic ,assign)  float  section_two_content_hegit;

// 商品版的店铺昵称
@property (nonatomic ,strong)  UILabel * namelabel;

@end

@implementation LPCInformationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 0. 标题 返回按钮
    
    [self nav_title:@"店铺中心"];
    
    [self left];
    
    [self backColor:COLOR(237, 243, 248, 1)];
    
    // 1. tableview
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TableView.delegate = self ;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [[UIView alloc]init];
        
        _TableView.backgroundColor = self.view.backgroundColor;
        
        [self.view addSubview:_TableView];
    
    }
    
    
    // 1. 判断店主的身份
    
    [self requset];
    // Do any additional setup after loading the view.
}

#pragma mark 商品布局
/**
 *  商品布局
 */
-(void)commodity_CreatUI{
    
    // 0. tableView 的headview
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    
    _headImage.image = [UIImage imageNamed:@"小吃界面头部背景"];
    
    _TableView.tableHeaderView = _headImage;
    
    // 1. 头像
    
    _headimageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, _headImage.frame.size.height - 87, 87, 87)];
    
    _headimageView.image = [UIImage imageNamed:@"LPCzhanweifu"];
    
    [_headImage addSubview:_headimageView];
    
    // 2. 昵称
    
    _namelabel  = [[UILabel alloc]initWithFrame:CGRectMake(107 + 20, _headimageView.frame.origin.y, SCREEN_WIDTH - 107 - 20, _headimageView.frame.size.height)];
    
    _namelabel.textAlignment = NSTextAlignmentLeft;
    
    _namelabel.text = @"";
    
    _namelabel.textColor = [UIColor whiteColor];
    
    [_headImage addSubview:_namelabel];
    
    // 3. 内容赋值
    
    _address_string = @"";
    
    _tel_string = @"";
    
    _coontent_string = @"";
    
    
    // 4. 身份标示 和 刷新
    _section_index = 1;
    
  
    
}
#pragma mark 网络请求
/**
 *  获取店铺信息
 */
-(void)requset{
    
    [SHARE_APP showHud];
    
    NSUserDefaults   * user  = [NSUserDefaults  standardUserDefaults];
    
    NSString  * string = [user objectForKey:@"shopId"];
    
    // 1 酒店 3特产 2 饭店 4 小吃
    
    
    NSString * string_key = [user objectForKey:@"KEY"];
    
    if([string_key isEqualToString:@"1"])
        // 商户版
        
        [self commodity_CreatUI];
    
    if([string_key isEqualToString:@"3"])
        // 饭店
        
        [self Hotel_CreatUI];
    
    if([string_key isEqualToString:@"2"])
        // 酒店
        
        [self HotelCreat_UI];
 
    
    NSDictionary * dict = @{@"status":string};
    
    
    [ZHJQHttpToll GET:LPCSTOREINFORMATION parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        LPCShopCeneterModel  * model = [LPCShopCeneterModel yy_modelWithJSON:dic];
        
         // 1 酒店 3特产 2 饭店 4 小吃
        
        if(model.header.status == 0){
            
            [SHARE_APP hideHud];
            
            if([string isEqualToString:@"1"]){
                
                
                _name_string = model.data.name;
                
                _address_tow_string = model.data.address;
                
                _tel_two_string = model.data.phone;
                
                _content_two_string = model.data.content;
                
               
                 if([model.data.is_blss isEqualToString:@"1"]){
                    
                     [_jd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_3sheshi"]];
                     
                     [_jd_dataSurcetitleArr addObject:@"设施"];

                }
                
                if([model.data.is_wifi isEqualToString:@"1"]){
                    
                    [_jd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_1kuandai"]];
                    
                    [_jd_dataSurcetitleArr addObject:@"无线"];
                    
                }
                
                if([model.data.is_yushi isEqualToString:@"1"]){
                    
                    [_jd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_2yushi"]];
                    
                    [_jd_dataSurcetitleArr addObject:@"浴室"];
                    
                }
                
                if([model.data.is_media isEqualToString:@"1"]){
                    
                    [_jd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_4keji"]];
                    
                    [_jd_dataSurcetitleArr addObject:@"媒体/科技"];
                    
                }
                
                if([model.data.is_food isEqualToString:@"1"]){
                    
                    [_jd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_5shipin"]];
                    
                    [_jd_dataSurcetitleArr addObject:@"食品"];
                    
                }
                
                
            }else if([string isEqualToString:@"2"] || [string isEqualToString:@"3"]){
                
                _name_string = model.data.name;
                
                _address_tow_string = model.data.address;
                
                _tel_two_string = model.data.phone;
                
                _content_two_string = model.data.content;

                
                if([model.data.is_blss isEqualToString:@"1"]){
                    
                    [_fd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_3sheshi"]];
                    
                    [_fd_dataSurcetitleArr addObject:@"设施"];
                    
                }
                
                if([model.data.is_wifi isEqualToString:@"1"]){
                    
                    [_fd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_1kuandai"]];
                    
                    [_fd_dataSurcetitleArr addObject:@"无线"];
                    
                }
                
                if([model.data.is_media isEqualToString:@"1"]){
                    
                    [_fd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_4keji"]];
                    
                    [_fd_dataSurcetitleArr addObject:@"媒体/科技"];
                    
                }
                
                if([model.data.is_food isEqualToString:@"1"]){
                    
                    [_fd_dataSurceImageArr addObject:[UIImage imageNamed:@"d3_tubiao_5shipin"]];
                    
                    [_fd_dataSurcetitleArr addObject:@"食品"];
                    
                }
                
                
               
            }else{
                
                
                [_headImage sd_setImageWithURL:[NSURL URLWithString:model.data.backgroud_img] placeholderImage:[UIImage imageNamed:@"小吃界面头部背景"]];
                
                [_headimageView sd_setImageWithURL:[NSURL URLWithString:model.data.head_img] placeholderImage:[UIImage imageNamed:@"d19_touxaing"]];
                
                _namelabel.text  = model.data.name;
                
                _address_string = model.data.address;
                
                _tel_string = model.data.phone;
                
                _coontent_string = model.data.content;
                   
                }

            
            
         

            
            [_TableView reloadData];
            
            return ;
            
        }
        
        
        [self MBShow:[self head:dic] backview:self.view];
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];

    
    
    
}
#pragma mark 饭店布局
/**
 *  饭店布局
 */
-(void)Hotel_CreatUI{
    
    _fd_dataSurcetitleArr = [NSMutableArray array];
    
    _fd_dataSurceImageArr = [NSMutableArray array];
    
    // 0 赋值
    
    _name_string = @"";
    
    _address_tow_string = @"";
    
    _tel_two_string = @"";
    
    _content_two_string = @"";
    
    
    // 1. 身份标示 和 刷新
    _section_index = 2;
    
   
    
}
#pragma mark 酒店版
-(void)HotelCreat_UI{
#pragma mark 酒店版 和饭店版 页面一致 故此用同一数据源
    
    _jd_dataSurceImageArr = [NSMutableArray array];
    
    _jd_dataSurcetitleArr = [NSMutableArray array];
    
    
    // 0 赋值
    
    _name_string = @"";
    
    _address_tow_string = @"";//曹妃甸湿地文化旅游度假区,这里是您酒店的具体位置,让用户更准确的找到你们
    
    _tel_two_string = @""; //0311-80561252
    
    _content_two_string = @""; //        曹妃湖红树湾住宅小区项目经唐海县政府批准立项，项目坐落于北方最大的滨海湿地、国家4A级景区内。有亚洲一流之称的金熊高尔夫球场与小区一河之隔。隔湖相望是展耀高尔夫球场，渤海国际会议中心与小区相邻，万亩曹妃湖与小区为畔。60万平方公里的曹妃甸湿地保护区点缀着湿地迷宫、三岛七星国际会所，形成了绿地、水系、温泉，是澳大利亚至西伯利亚鸟类迁移和栖息的天堂。2012年国务院正式批复，以京津唐为复地，重点打造环渤海经济带。撤销唐海县，建立曹妃甸区。曹妃甸作为环渤海经济发展的引擎，依托曹妃甸北方大港，首先打造曹妃甸湿地国家5A级景区。红树湾住宅小区项目坐落于湿地景区中央，有着独特的地理优势和发展前景，小区以湿地、温泉、游船、低碳为开发理念，为高端人群精心打造一个休闲旅游度假的养生宝地。项目以意大利水域威尼斯为蓝本，由湖水划分成相对独立的“蜻蜓”状五个岛屿。项目分三期开发，规划建筑总面积113355平方米。第一期设计轴线面积25465.9平方米，实际完工面积26015.04平方米。房型设计采用欧式设计，联排和独栋、户户温泉，使拥有者独享尊贵，设计理念与周边环境紧密结合，媲美威尼斯风情的再造。  \n        4000多平方米的红树湾会所，设有温泉SPA、游泳池、咖啡吧、雪茄吧、便利店、诊所、美食餐厅、健身房、桌球室等。本项目开发理念，融入景区，筑巢引凤，不曾有的高端住宅建造理念，给精英们的拥有而自豪和尊贵。""
    
    
    // 1. 身份标示 和 刷新
    _section_index = 3;
    
   
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate


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
    
    // 商品版
    if(_section_index == 1){
        
        if(section == 0){
            
            if(row == 0){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_ditu"];
                
                UILabel * address_label = [[UILabel alloc]initWithFrame:CGRectMake(45, cell.imageView.frame.origin.y, self.TableView.frame.size.width - 45 - 8, MAXFLOAT)];
                
                address_label.text = _address_string;
                
                CGRect rect = [self gethegitLabel:address_label sizepoit:address_label.font.pointSize-2 textString:_address_string newLbale:nil];
                
                address_label.textColor = [UIColor lightGrayColor];
                
                CGRect frame = address_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                if(frame.size.height < 40){
                    
                    frame.size.height = 45;
                }
                
                address_label.frame = frame;
                
                _section_one_hegit = frame.size.height  ;
                
                address_label.textAlignment = NSTextAlignmentCenter;
                
                [cell.contentView addSubview:address_label];
                
            }if(row == 1){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_dianhua"];

                cell.textLabel.text = _tel_string;
                
                cell.textLabel.textColor = [UIColor lightGrayColor];
            }
            
        } if(section == 1){
            
            if(row == 0){
                
                cell.textLabel.text = @"店铺介绍:";
                
            }if(row == 1){
                
                UILabel * content_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, MAXFLOAT)];
                
                content_label.text = _coontent_string;
                
                content_label.textColor = [UIColor lightGrayColor];
                
                CGRect rect = [self gethegitLabel:content_label sizepoit:content_label.font.pointSize - 2 textString:_coontent_string newLbale:nil];
                
                CGRect frame = content_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                content_label.frame = frame;
                
                _section_one_row_hegit = frame.size.height;
                
                [cell.contentView addSubview:content_label];
                
                
                
            }
            
            
            
        }
        
    }
    // 饭店版
    if(_section_index == 2){
        
        if(section == 0){
            
            cell.textLabel.text = _name_string;
            
        }if(section == 1){
            
            if(row == 0){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_ditu"];
                
                UILabel * address_label = [[UILabel alloc]initWithFrame:CGRectMake(45, cell.imageView.frame.origin.y, self.TableView.frame.size.width - 45 - 8, MAXFLOAT)];
                
                address_label.text = _address_tow_string;
                
                CGRect rect = [self gethegitLabel:address_label sizepoit:address_label.font.pointSize-2 textString:_address_tow_string newLbale:nil];
                
                address_label.textColor = [UIColor lightGrayColor];
                
                CGRect frame = address_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                if(frame.size.height < 40){
                    
                    frame.size.height = 45;
                }
                
                address_label.frame = frame;
                
                _section_two_hegit = frame.size.height  ;
                
                address_label.textAlignment = NSTextAlignmentCenter;
                
                [cell.contentView addSubview:address_label];
                
            }if(row == 1){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_dianhua"];
                
                cell.textLabel.text = _tel_two_string;
                
                
            }
            
        }if(section == 2){
            
            if(row == 0){
                
                cell.textLabel.text = @"饭店设施";
                
            }if(row == 1){

               
                LPCCustomView * customView = [[LPCCustomView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40) images:_fd_dataSurceImageArr string:_fd_dataSurcetitleArr];
                
                [cell.contentView addSubview:customView];
                
            }
            
        }if(section == 3){
            
            if(row == 0){
                
                cell.textLabel.text = @"饭店介绍";
                
            }if(row == 1){
                
                
                UILabel * content_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, MAXFLOAT)];
                
                content_label.text = _content_two_string;
                
                content_label.textColor = [UIColor lightGrayColor];
                
                CGRect rect = [self gethegitLabel:content_label sizepoit:content_label.font.pointSize - 2 textString:_content_two_string newLbale:nil];
                
                CGRect frame = content_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                content_label.frame = frame;
                
                _section_two_content_hegit = frame.size.height;
                
                [cell.contentView addSubview:content_label];
                
            }
            
        }
        
        
    }
    // 酒店版
    if(_section_index == 3){
        
        if(section == 0){
            
            cell.textLabel.text = _name_string;
            
        }if(section == 1){
            
            if(row == 0){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_ditu"];
                
                UILabel * address_label = [[UILabel alloc]initWithFrame:CGRectMake(45, cell.imageView.frame.origin.y, self.TableView.frame.size.width - 45 - 8, MAXFLOAT)];
                
                address_label.text = _address_tow_string;
                
                CGRect rect = [self gethegitLabel:address_label sizepoit:address_label.font.pointSize-2 textString:_address_tow_string newLbale:nil];
                
                address_label.textColor = [UIColor lightGrayColor];
                
                CGRect frame = address_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                if(frame.size.height < 40){
                    
                    frame.size.height = 45;
                }
                
                address_label.frame = frame;
                
                _section_two_hegit = frame.size.height  ;
                
                address_label.textAlignment = NSTextAlignmentCenter;
                
                [cell.contentView addSubview:address_label];
                
            }if(row == 1){
                
                cell.imageView.image = [UIImage imageNamed:@"d2_tubiao_dianhua"];
                
                cell.textLabel.text = _tel_two_string;
                
                
            }
            
        }if(section == 2){
            
            if(row == 0){
                
                cell.textLabel.text = @"酒店设施";
                
            }if(row == 1){
#warning 2016.8.1 lpc 饭店设施 待定
                
                
                
               // NSMutableArray * images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d3_tubiao_1kuandai"],[UIImage imageNamed:@"d3_tubiao_2yushi"],[UIImage imageNamed:@"d3_tubiao_3sheshi"],[UIImage imageNamed:@"d3_tubiao_4keji"],[UIImage imageNamed:@"d3_tubiao_5shipin"], nil];
                
                // NSMutableArray * nameimages = [NSMutableArray arrayWithObjects:@"宽带",@"浴室",@"便利设施",@"媒体/科技",@"食品/饮品", nil];
                
                LPCCustomView * customView = [[LPCCustomView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40) images:_jd_dataSurceImageArr string:_jd_dataSurcetitleArr];
                
                [cell.contentView addSubview:customView];
                
            }
            
        }if(section == 3){
            
            if(row == 0){
                
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                
                
                if ([[user  objectForKey:@"shopId"] isEqualToString:@"1"]) {
                cell.textLabel.text = @"酒店介绍";
                  
                }
                if ([[user  objectForKey:@"shopId"] isEqualToString:@"2"]) {
                    
                    cell.textLabel.text = @"饭店介绍";
                }
                if ([[user  objectForKey:@"shopId"] isEqualToString:@"3"]) {
                    
                    cell.textLabel.text = @"商铺介绍";
                }
                
                
                
                
            }if(row == 1){
                
                
                UILabel * content_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, MAXFLOAT)];
                
                content_label.text = _content_two_string;
                
                content_label.textColor = [UIColor lightGrayColor];
                
                CGRect rect = [self gethegitLabel:content_label sizepoit:content_label.font.pointSize - 2 textString:_content_two_string newLbale:nil];
                
                CGRect frame = content_label.frame;
                
                frame.size.height = rect.size.height + 10;
                
                content_label.frame = frame;
                
                _section_two_content_hegit = frame.size.height;
                
                [cell.contentView addSubview:content_label];
                
            }
            
        }
        
        
    }
    
    
    return cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_section_index == 1){
        
        return 2;
        
    } if(_section_index == 2){
        
        if(section == 0){
            
            return 1;
            
        }else{
            
            return 2;
            
        }
        
        
    } if(_section_index == 3){

        if(section == 0){
            
            return 1;
            
        }else{
            
            return 2;
            
        }
        
    }
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_section_index == 1){
        
        if(indexPath.section == 0){
            
            return _section_one_hegit;
            
        }if(indexPath.section == 1){
            
            if(indexPath.row == 1){
                
                return _section_one_row_hegit+ 10;
                
            }
            
        }
        
    }
    
    if(_section_index == 2){
        
        if(indexPath.section == 0){
            
            return 30;
            
        }if(indexPath.section == 1){
            
            if(indexPath.row == 0){
                
               return  _section_two_hegit;
                
            }
            
        }if(indexPath.section == 3){
            
            if(indexPath.row == 1){
                
                return _section_two_content_hegit;
                
            }
            
        }
        
    } if(_section_index == 3){
        
        if(indexPath.section == 0){
            
            return 30;
            
        }if(indexPath.section == 1){
            
            if(indexPath.row == 0){
                
                return  _section_two_hegit;
                
            }
            
        }if(indexPath.section == 3){
            
            if(indexPath.row == 1){
                
                return _section_two_content_hegit;
                
            }
            
        }
        
    }
    
    return 44;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_section_index == 1){
        
        return 2;
    
    }if(_section_index == 2){
        
        return 4;
        
    }if(_section_index == 3){
        
        return 4;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    
    return 10;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    CGFloat sectionHeaderHeight = 10;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
    
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
    
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
    }
}

@end
