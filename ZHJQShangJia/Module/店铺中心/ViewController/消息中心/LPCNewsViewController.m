
//
//  LPCNewsViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCNewsViewController.h"

@interface LPCNewsViewController ()

@property (nonatomic ,strong) MJChiBaoZiFooter * foot;

@end

@implementation LPCNewsViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBar.hidden = false;
    
}
/**
 *  下拉刷新 或者一进入页面的网络请求
 *
 *  @param indext 判断下拉还是push进来
 */
-(void)retqset:(int) indext{
    
    if(indext == 1){
        
        [SHARE_APP showHud];
    }
    
    _dataSourceArr =[NSMutableArray array];
    
    NSDictionary * dic = @{@"page":@1,
                           @"rows":@10,
                           @"userType":@0};
    
    [ZHJQHttpToll GET:LPCNEWSCENTENT parameters:dic success:^(id responseObject) {
        
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCNEWSmodels * model = [LPCNEWSmodels yy_modelWithJSON:dic_json];
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            _indexPath ++ ;
            
            _dataSourceArr = [model.data.rows mutableCopy];
            
            if(_dataSourceArr.count == 0){
                
                [_foot setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_Tableview.mj_footer endRefreshingWithNoMoreData];
                
            }
            if(_dataSourceArr.count > 0){
                
                 [_Tableview.mj_footer resetNoMoreData];
                
            }
            
            if(indext == 2){
                
                [_Tableview.mj_header endRefreshing];
 
            }if(indext == 1){
                
                [SHARE_APP hideHud];
                
            }

            
            [_Tableview reloadData];
            
            return ;
        }

        
        [self MBShow:[self head:dic_json] backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
/**
 *  下拉刷新
 */
#pragma mark 下拉双刷新
-(void)loadNewData{
    
    [self retqset:2];
    
}

#pragma mark 上提刷新
/**
 *  上提刷新
 */
-(void)loadup{
    
    NSDictionary * dic = @{@"rows":@10,
                           @"page":[NSNumber numberWithInteger:_indexPath],
                           @"userType":@0};
    
    
    [ZHJQHttpToll GET:LPCNEWSCENTENT parameters:dic success:^(id responseObject) {
        
        NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        [_Tableview.mj_footer endRefreshing];
        
         LPCNEWSmodels * model = [LPCNEWSmodels yy_modelWithJSON:dic_json];
        
        if([[self headdic:dic_json] isEqualToString:@"0"]){
            
            if(_indexPath >= model.data.lastPage){
                
                [_foot setTitle:@"已加载显示完全部内容" forState:MJRefreshStateNoMoreData];
                
                [_Tableview.mj_footer endRefreshingWithNoMoreData];

                
            }
            
            if(model.data.rows.count > 0){
                
                for(newsRows * datamodel in [model.data.rows mutableCopy]){
                    
                    [_dataSourceArr addObject:datamodel];
                    
                }
                
                _indexPath ++ ;
                
            }if(model.data.rows.count < 10){
                
               
            }

            
            [_Tableview reloadData];
            
            return ;
        }
        
        
        [self MBShow:@"消息请求失败,重试" backview:self.view];
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 0 基本设置
    
    [self nav_title:@"消息中心"];
    
    [self left];
    
    // 1 页面布局
    
    [self  creat_UI];
    
    // 网络请求
    [self retqset:1];
    
    
    //当前页数
    _indexPath = 1;
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)creat_UI{
    
    if(!_Tableview){
        
        _Tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _Tableview.delegate = self;
        
        _Tableview .dataSource = self;
        
        _Tableview.tableFooterView = [UIView new];
        
        
        self.Tableview.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        _foot = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadup)];
        
        
        _Tableview.mj_footer = _foot;
        
        
        [self.view addSubview:_Tableview];
        
        _dataSourceArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"d21_tu1"], [UIImage imageNamed:@"d21_tu2"],nil];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger  row =  indexPath.row ;
    
    newsRows * model = _dataSourceArr[row];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, ((524/3) * (SCREEN_WIDTH -20)) / (1065/3) )];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"d21_tu1"]];
    
    [cell.contentView addSubview:imageView];
    
    //  内容
    
    UIView * backVIew = [[UIView alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height - 40, imageView.frame.size.width, 40)];
    
    backVIew.backgroundColor = COLOR(0, 0, 0, .5);
    
    [imageView addSubview:backVIew];
    
    
    UILabel * contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 0, backVIew.frame.size.width - 14, 25)];
    

    contentlabel.text = model.title;
    
    contentlabel.textAlignment = NSTextAlignmentLeft;
    
    contentlabel.textColor = [UIColor whiteColor];

    contentlabel.font = [UIFont systemFontOfSize:contentlabel.font.pointSize - 2];
    
    [backVIew addSubview:contentlabel];
    
    UILabel * timelabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 25, contentlabel.frame.size.width, 15)];
    
    timelabel.text = model.createDate;
    
    timelabel.textAlignment = NSTextAlignmentLeft;
    
    timelabel.font = [UIFont systemFontOfSize:contentlabel.font.pointSize - 4];
    
    timelabel.textColor = [UIColor whiteColor];
    
    [backVIew addSubview:timelabel];
    
    
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPCNewsDeleViewController * newViewController = [[LPCNewsDeleViewController alloc]init];
    
    newsRows * model = _dataSourceArr[indexPath.row];
    
    newViewController.model_row = model;
    
    [self push:newViewController];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _dataSourceArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ((524/3) * (SCREEN_WIDTH -20)) / (1065/3) +10;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
