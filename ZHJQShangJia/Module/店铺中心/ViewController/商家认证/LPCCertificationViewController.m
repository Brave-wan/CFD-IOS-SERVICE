//
//  LPCCertificationViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCCertificationViewController.h"

#import "UIImageView+WebCache.h"

@interface LPCCertificationViewController (){
    
    NSString * shangjianame ;
    
    NSString *  dianpuleixing;
    
    NSString *  yingyinchnapin;
    
    NSString  * zhanghuleixing;
    
    NSString * zhanghumingcheng;
    
    NSString * yinhangzhanghao ;
    
    NSString * kaihuhang;
    
    NSString * yingyezhizhao;
    
    NSString * zhengshu ;
    
    NSString * qitazhengshu;
}

@end

@implementation LPCCertificationViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    
}
#pragma mark 获取商家认证信息
/**
 *  获取商家认证信息
 */
-(void)getUserinfoment{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    shangjianame = [user objectForKey:@"shangjianame"];
    
    dianpuleixing = [user objectForKey:@"dianpuleixing"];
    
    yingyinchnapin = [user objectForKey:@"jingyingchanpin"];
    
    zhanghuleixing = [user objectForKey:@"zhanghaoleixing"];
    
    zhanghumingcheng = [user objectForKey:@"zhanghumingcheng"];
    
    yinhangzhanghao = [user objectForKey:@"yihangzhanghu"];
    
    kaihuhang = [user objectForKey:@"kaihuahang"];
    
    yingyezhizhao = [user objectForKey:@"yingyezhizhao"];
    
    zhengshu = [user objectForKey:@"zhengshu"];
    
    qitazhengshu = [user objectForKey:@"zhengshuqita"];
    
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self nav_title:@"商家认证详情"];
    
    [self left];
    
    [self getUserinfoment];
    
    self.view.backgroundColor = COLOR(237, 243, 248, 1);
    
    [self Creat_UI];
    
    
    // Do any additional setup after loading the view.
}

-(void)Creat_UI{
    
    if(_Tableview == nil){
        
        _Tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _Tableview.delegate = self;
        
        _Tableview.dataSource = self;
        
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        
        _Tableview.backgroundColor = footView.backgroundColor = self.view.backgroundColor;
        
        UILabel * lbael = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        
        lbael.text = @"隐私声明:我们承诺此信息仅用于核实商家信息,不做任何其他用途!";
        
        lbael.backgroundColor = [UIColor clearColor];
        
        lbael.textAlignment = NSTextAlignmentCenter;
        
        lbael.textColor = [UIColor lightGrayColor];
        
        lbael.font = [UIFont systemFontOfSize:lbael.font.pointSize - 2];
        
        lbael.adjustsFontSizeToFitWidth = true;
        
        [footView addSubview:lbael];
        
        _Tableview.tableFooterView = footView;
        
        [self.view addSubview:_Tableview];
        
        
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
    
    NSInteger  section = indexPath.section;
    
    NSInteger  row = indexPath.row;
    
    if(section == 0){
        
        NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"  商家名称",@"  店铺类型",@"  经营产品", nil];
        
        NSMutableArray * arr_name = [NSMutableArray arrayWithObjects:@"曹妃甸休闲旅游度假酒店",@"酒店",@"客房", nil];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 80, 44-14)];
        
        label.text = arr[row];
        
        [cell.contentView addSubview:label];
        
        
        UILabel  * nametextfild = [[UILabel alloc]initWithFrame:CGRectMake(100, 7, SCREEN_WIDTH - 110, 30)];
        
        if(row == 0){
            
            nametextfild.text = shangjianame;
            
        }
        if(row == 1){
            
            nametextfild.text = dianpuleixing;
            
        }
        if(row == 2){
            
            nametextfild.text = yingyinchnapin;
            
        }
        
        
        [cell.contentView addSubview:nametextfild];
        
        
    }
    
    if(section == 1){
        
        NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"  账户类型",@"  账户名称",@"  银行账号",@"  开户行", nil];
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 80, 44-14)];
        
        label.text = arr[row];
        
        
        [cell.contentView addSubview:label];
        
        
        UILabel  * nametextfild = [[UILabel alloc]initWithFrame:CGRectMake(100, 7, SCREEN_WIDTH - 110, 30)];
        
        if(row == 0){
            
            nametextfild.text = zhanghuleixing;
            
        }
        if(row == 1){
            
            nametextfild.text = zhanghumingcheng;
            
        }
        if(row == 2){
            
            nametextfild.text = yinhangzhanghao;
            
        }if(row == 3){
            
            nametextfild.text = kaihuhang;
            
        }
        
        
        nametextfild.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
        
        nametextfild.tag = row;
        
        
        [cell.contentView addSubview:nametextfild];
 
    }if(section == 2){
        
        if(row == 0){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 30)];
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.text = @"  营业执照";
            
            [cell.contentView addSubview:label];
            
        }if(row == 1){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
            
            label.text = @"营业执照";
            
            label.textAlignment = NSTextAlignmentCenter;
            
            [cell.contentView addSubview:label];
            
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75/2, label.frame.origin.y + label.frame.size.height + 10, 75, 75)];

            
            [image sd_setImageWithURL:[NSURL URLWithString:yingyezhizhao] placeholderImage:[UIImage imageNamed:@"d26_tu1"]];
            
            [cell.contentView addSubview:image];
            
            
        }
        
    }if(section == 3){
        
        if(row == 0){
           
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 30)];
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.text = @"  其他证书";
            
            [cell.contentView addSubview:label];
            
        }if(row == 1){
            
            for (int i = 0 ; i < 2;  i ++) {
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * i, 10, SCREEN_WIDTH/2, 20)];
                
                label.text  = @"其他证书";
                
                label.textAlignment =  NSTextAlignmentCenter;
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                label.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:label];
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4 - 75/2) + i * (SCREEN_WIDTH/2), label.frame.origin.y + label.frame.size.height + 10, 75, 75)];
                
                if(i == 0){
                    
                      [imageView sd_setImageWithURL:[NSURL URLWithString:zhengshu] placeholderImage:[UIImage imageNamed:@"d26_tu2"]];
                    
                } if(i == 1){
                    
                    
                     [imageView sd_setImageWithURL:[NSURL URLWithString:qitazhengshu] placeholderImage:[UIImage imageNamed:@"d26_tu3"]];
              
                }
                
                
                [cell.contentView addSubview:imageView];
                
            }
            
            
        }
        
    }
    
    
    return cell;
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 3;
        
    }if(section == 1){
        
        return 4;
    }
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        return 44;
        
    }if(indexPath.section == 2){
        
        if(indexPath.row == 1){
            
            return 135;
            
        }
        
    }
    
    if(indexPath.section == 3){
        
        if(indexPath.row == 1){
            
            return 135;
            
        }
        
    }
    
    return 44;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        
        label.text = @"  结算账户信息";
        
        label.textColor = [UIColor redColor];
        
        return label;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    if(section == 1){
        
        return 30;
        
    }
    
    return 10;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
