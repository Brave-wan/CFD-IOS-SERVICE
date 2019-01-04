//
//  LPCSPYEVC.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSPYEVC.h"
#import "LPCTXViewController.h"

@interface LPCSPYEVC ()

@end

@implementation LPCSPYEVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:false];
}
-(void)tixianhuitiao{
    
    [self request];
    
}
#pragma mark 商家余额
/**
 *  商家余额
 */
-(void)request{
    
    [SHARE_APP showHud];
    
    [ZHJQHttpToll GET:LPCMERCHANTBALANCE parameters:nil success:^(id responseObject) {
        
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        LPCMerchantBalanceModel * model = [LPCMerchantBalanceModel yy_modelWithJSON:dic];
        
        if(model.header.status == 0){
            
            [SHARE_APP hideHud];
            
            self.dataSourceArr = [model.data.tradeLogList mutableCopy];
            
            _numLabel.text = [NSString stringWithFormat:@"%ld",(long)model.data.balanceMap.balance];
            
            [_TableView reloadData];
           
            return ;
        }
        
        [self MBShow:@"请求失败,请重试" backview:self.view];
        
       
        
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"商铺余额"];
    
    [self left];
    
    [self TableViewinit];
    
    [self dataSourceArrinit];
    
    // Do any additional setup after loading the view.
    
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 懒加载

-(void)TableViewinit{
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        [self.view addSubview:_TableView];
        
        UIView  * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        headView.backgroundColor = [UIColor blueColor];
        
        UIImageView * backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
        backImage.image = [UIImage imageNamed:@"d_shanghuyue"];
        
        [headView addSubview:backImage];
        
        
        // 账户余额 label
        UILabel * contentLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150/4)];
       
        contentLabel.text = @"账户余额(元)";
        
        contentLabel.textColor =[UIColor whiteColor];
        
        contentLabel.textAlignment = NSTextAlignmentCenter;
        
        contentLabel.font =[UIFont systemFontOfSize:contentLabel.font.pointSize - 4];
        
        [headView addSubview:contentLabel];
        
        
        // 网络获取剩余
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150/4, SCREEN_WIDTH, 150/2.00 - 30)];
        
        _numLabel.text = @"";
        
        _numLabel.textColor = [UIColor whiteColor];

        _numLabel.textAlignment = NSTextAlignmentCenter;
        
        _numLabel.font = [UIFont systemFontOfSize:_numLabel.font.pointSize + 9];
        
        [headView addSubview:_numLabel];
        
        
        // 提现
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /2 - 60,  headView.frame.size.height/2 + 20, 120, 35)];
        
        [button setTitle:@"提现" forState:0];
        
        [button setTitleColor:[UIColor whiteColor] forState:0];
        
        button.backgroundColor = COLOR(255, 63, 81, 1);
        
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [headView addSubview:button];
        
        
        
        _TableView.tableHeaderView = headView;
        
        _TableView.tableFooterView = [[UIView alloc]init];
    }
    
}
#pragma mark 提现
-(void)buttonClick{
  
    LPCTXViewController * ViewController = [LPCTXViewController new];
    
    ViewController.object =self;
    
    ViewController.string_num = _numLabel.text;
    
    [self push:ViewController];
    
}
-(void)dataSourceArrinit{
    
    _dataSourceArr = [NSMutableArray array];
    
}
#pragma mark tableview 的delegate

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
    
    MerchanTradeloglist * model = _dataSourceArr[row];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
        
     UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH/2, 30)];
    
    
    
    [cell.contentView addSubview:label];
    
    
    UILabel * label_one = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /2, 5, SCREEN_WIDTH/2 - 7, 30)];
    
    if(model.type == 0){
        
        label.text = @"充值";
        
        label_one.text = [NSString stringWithFormat:@"+ %ld",(long)model.price];
        
    }if(model.type == 1){
        
        label.text = @"提现";
        
        label_one.text = [NSString stringWithFormat:@"- %ld",(long)model.price];
        
    }if(model.type == 2){
        
        label.text = [NSString stringWithFormat:@"收到%@的付款",model.nick_name];
        
        label_one.text = [NSString stringWithFormat:@"+ %ld",(long)model.price];
        
    }if(model.type == 4){
        
        label.text = [NSString stringWithFormat:@"退款给%@",model.nick_name];
        
        label_one.text = [NSString stringWithFormat:@"- %ld",(long)model.price];
        
    }
    
    
    
    label_one.font = [UIFont systemFontOfSize:label_one.font.pointSize - 3];
    
    label_one.textAlignment = NSTextAlignmentRight;
    
    [cell.contentView addSubview:label_one];
    
    
    
    UILabel * label_ = [[UILabel alloc]initWithFrame:CGRectMake(5, 35, SCREEN_WIDTH/2, 20)];
    
    label_.text = [NSString stringWithFormat:@"余额  :%ld",(long)model.balance];
    
    label_.textColor = [UIColor lightGrayColor];
    
    label_.font = [UIFont systemFontOfSize:label_.font.pointSize - 4];
    
    [cell.contentView addSubview:label_];
    
 
    
    UILabel * label_two = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /2, 30, SCREEN_WIDTH/2 - 7, 30)];
    
    NSString * data_string = [model.createTime substringToIndex:10];
    
    label_two.text = data_string;
   
    
    label_two.textAlignment = NSTextAlignmentRight;
    
    label_two.textColor = [UIColor lightGrayColor];
    
    label_two.font = [UIFont systemFontOfSize:label_two.font.pointSize - 4];
    
    [cell.contentView addSubview:label_two];

    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  * sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 44.0f)];
    
    contentLabel.text = @"收支明细";
    
    contentLabel.textColor = COLOR(0, 148, 229, 1);
    
    [sectionView addSubview:contentLabel];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.0f, SCREEN_WIDTH, 1.0f)];
    
    lable.backgroundColor = COLOR(0, 148, 229, 1);
    
    [sectionView addSubview:lable];
 
    return sectionView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    return _dataSourceArr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
