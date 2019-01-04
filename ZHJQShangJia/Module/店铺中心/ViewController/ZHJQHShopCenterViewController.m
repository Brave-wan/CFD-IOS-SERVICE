
//
//  ZHJQHShopCenterViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHShopCenterViewController.h"
#import "LPCSPYEVC.h"
#import "LPCSPTDViewController.h"

#import "UIImageView+WebCache.h"

@interface ZHJQHShopCenterViewController (){
    
    
    UIImageView * headimageView;
}

@property (nonatomic ,strong) NSMutableArray * section_oneImageArr;

@property (nonatomic ,strong) NSMutableArray * section_oneNameArr;

@property (nonatomic ,strong) NSMutableArray * section_twoImageArr;

@property (nonatomic ,strong) NSMutableArray * section_twoNameArr;

@property (nonatomic ,strong) NSMutableArray * section_threeImageArr;

@property (nonatomic ,strong) NSMutableArray * section_threeNameArr;

@end

@implementation ZHJQHShopCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hotel" object:nil];
    
    // 0. navbar 隐藏
    
    [self.navigationController.navigationBar setHidden:true];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"indexChang" object:nil];

    
}
#pragma mark 店铺信息
/**
 *  获取店铺信息
 */
-(void)request{
    
    NSUserDefaults   * user  = [NSUserDefaults  standardUserDefaults];
    
    NSString  * string = [user objectForKey:@"shopId"];
    
    // 1 酒店  2 饭店 3特产4 小吃

    
    NSString  * numString = @"";
    
    if([string isEqualToString:@"1"]){
        
        numString = @"2";
    }else 
    if([string isEqualToString:@"2"]){
        
        numString = @"1";
    }
    else{
        
        numString = @"3";
    }
    
    
    NSDictionary * dict = @{@"status":string};
    
    
    [ZHJQHttpToll GET:LPCSTOREINFORMATION parameters:dict success:^(id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
//           NSString * string_json = [dic JSONString];
//
        
        LPCShopCeneterModel  * model = [LPCShopCeneterModel yy_modelWithJSON:dic];
        
        if(model.header.status == 0){
            
            
            [headimageView  sd_setImageWithURL:[NSURL URLWithString:model.data.backgroud_img] placeholderImage:[UIImage imageNamed:@"d1_beijing"]];
            
            _nameLabel.text = model.data.name;
            
            return ;
            
        }
        
        
        [self MBShow:[self head:dic] backview:self.view];
        
    } failure:^(NSError *error) {
        
       [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
    
}

#pragma mark cell的数据源
/**
 *  数据源
 */
-(void)Arr{
    
    _section_oneImageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d1_tubiao_2tongji"],[UIImage imageNamed:@"d1_tubiao_2tongji"], nil];
    
    _section_oneNameArr = [NSMutableArray arrayWithObjects:@"数据统计", nil];
    
    _section_twoImageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d1_tubiao_3chongzhi"],[UIImage imageNamed:@"d1_tubiao_6tuikuan"], nil];//d1_tubiao_6tuikuan@3x
    
    _section_twoNameArr = [NSMutableArray arrayWithObjects:@"商铺余额",@"退款订单", nil];
    
    _section_threeImageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d1_tubiao_4xiaoxi"],[UIImage imageNamed:@"d1_tubiao_5dianpu"],[UIImage imageNamed:@"d1_tubiao_6xinxi"], nil];
    
    _section_threeNameArr = [NSMutableArray arrayWithObjects:@"消息中心",@"店铺信息",@"设置", nil];
    
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(237, 243, 248, 1);
    
    
    // 0.数据载体
    
    if(!_Tableview){
        
        _Tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -State_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height + State_HEIGHT)style:UITableViewStylePlain];
       
        
        _Tableview.delegate = self;
        
        _Tableview.dataSource = self;
        
        
        UIView * footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        footView.backgroundColor = COLOR(237, 243, 248, 1);
        
        
        _Tableview.tableFooterView = footView;
        
        _Tableview.backgroundColor = COLOR(237, 243, 248, 1);
        
        [self.view addSubview:_Tableview];
        
    }
    
    // 1. tableview 的头 headView
    
    headimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 186)];
    
    headimageView.image = [UIImage imageNamed:@"d1_beijing"];
    
    _Tableview.tableHeaderView = headimageView;
    
   
    
    // 2.店铺的名称
    
    _nameLabel = [[UILabel alloc]initWithFrame:headimageView.frame];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",[user objectForKey:@"shangjianame"]];
    
    _nameLabel.textColor = [UIColor whiteColor];
    
    _nameLabel.font = [UIFont systemFontOfSize:_nameLabel.font.pointSize + 2];
    
    _nameLabel.textAlignment =  NSTextAlignmentCenter;
    
    [headimageView addSubview:_nameLabel];
    
   // 3. 底部的三个按钮
    
    NSMutableArray * imageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d1_anniu_shiming"],[UIImage imageNamed:@"d1_anniu_renzheng"],[UIImage imageNamed:@"d1_anniu_jiesuan"], nil];
    
    NSMutableArray * nameArr = [NSMutableArray arrayWithObjects:@"实名认证",@"商家认证",@"结算账户", nil];
    
    HeadViewButton * headViewbutton = [[HeadViewButton alloc]initWithFrame:CGRectMake(0, headimageView.frame.size.height - 24 - 20, SCREEN_WIDTH, 44) dataSourceArr:imageArr nameArr:nameArr];
    
    headimageView.userInteractionEnabled = true;
    
    [headimageView addSubview:headViewbutton];
    
    headViewbutton.Showstring = ^(NSInteger  index){
      
        if([nameArr[index] isEqualToString:@"实名认证"]){
            
            LPCPersonauthenticationViewController  * viewcontroller = [[LPCPersonauthenticationViewController alloc]init];
            
            [self push:viewcontroller];
            
        }else if ([nameArr[index] isEqualToString:@"商家认证"]){
            
            [self viewcontroller];
            
        }else if([nameArr[index] isEqualToString:@"结算账户"]){
            
             [self viewcontroller];
        }
        
    };
    
    // 4. cell 数据源
    
    [self Arr];
    
    // 5 获取店铺详情
    [self request];
    
}

-(void)viewcontroller{
    
    LPCCertificationViewController * viewcontr = [[LPCCertificationViewController alloc]init];
    
    [self push:viewcontr];
    
}

#pragma mark tableview 的delegate

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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    NSInteger  row =  indexPath.row ;
    
    NSInteger  section = indexPath.section;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if(section == 0){
        
        cell.imageView.image = _section_oneImageArr[row];
        
        cell.textLabel.text = _section_oneNameArr[row];
        
    } if(section == 1){
        
        cell.imageView.image = _section_twoImageArr[row];
        
        cell.textLabel.text = _section_twoNameArr[row];
        
    }if(section == 2){
        
        cell.imageView.image = _section_threeImageArr[row];
        
        cell.textLabel.text = _section_threeNameArr[row];
        
    }
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    NSInteger row     = indexPath.row;
    
    // 店铺信息
    
    LPCInformationViewController  * infoViewcontrolelr = [[LPCInformationViewController alloc]init];
    
    // 设置
    LPCSetingViewController * setViewController = [[LPCSetingViewController alloc]init];
    
    // 代理充值
    
    LPCDLCZViewController * dlViewcontroller = [[LPCDLCZViewController alloc]init];
    
    // 消息中心
    
    LPCNewsViewController  * newsViewController = [[LPCNewsViewController alloc]init];
    
    // 店铺管理
    LPCOffViewController  * offViewcontroller = [[LPCOffViewController alloc]init];
    
    // 数据统计
    LPCNumViewController * numviewController = [[LPCNumViewController alloc]init];
    
    // 店铺余额
    LPCSPYEVC  * YeViewController = [[LPCSPYEVC alloc]init];
    
    

    // 退款
    
    LPCSPTDViewController  * TDViewController = [[LPCSPTDViewController alloc]init];
    
    if(section == 0){
        
        if(row == 0){
            
            [self push:offViewcontroller];
            
        }if(row == 1){
            
            [self push:numviewController];
            
        }
        
        
    }if(section == 1){
        
        if(row == 0){
            
            [self push:YeViewController];
            
        }if(row == 1){
            
            [self push:TDViewController];
        }
        
        
    }if(section == 2){
        
        if(row == 0){
            
            [self push:newsViewController];
            
        }if(row == 1){
            
            [self push:infoViewcontrolelr];
            
        }if(row == 2){
            
            [self push:setViewController];
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if(section == 2){
        
        return 3;
        
    }if(section == 0){
        
        return 1;
    }
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
    
        return 0;
        
    }
    
    return 15;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
