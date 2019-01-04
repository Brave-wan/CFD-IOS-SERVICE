//
//  LPCSearcherjiudianViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/10/10.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCSearcherjiudianViewController.h"
#import "IQKeyboardManager.h"
#import "LPCsearchbarjiudianModel.h"
@interface LPCSearcherjiudianViewController ()<UITextFieldDelegate>
{
    BOOL _wasKeyboardManagerEnabled;
}

@end

@implementation LPCSearcherjiudianViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.keyBoardView.TextView resignFirstResponder];
   
    CGRect boxFrame = self.keyBoardView.frame;
    
    boxFrame.origin.y = SCREEN_HEIGHT  - 64 - 44;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.keyBoardView.frame = boxFrame;
        
    }];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self left];
    
    // 酒店
    
    _searchBar = [[LPCCustomTextFild alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH -100, 30)];
    
    _searchBar.placeholder = @"  订单号(须不少于8位)、下单人";
    
    [_searchBar setValue:COLOR(61, 162, 230, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    _searchBar.returnKeyType= UIReturnKeySearch;
    
    [_searchBar setValue:[UIFont systemFontOfSize:_searchBar.font.pointSize -4] forKeyPath:@"_placeholderLabel.font"];
    
    _searchBar.font = [UIFont systemFontOfSize:_searchBar.font.pointSize - 4];
    
    [_searchBar setBackgroundColor:COLOR(26, 122, 187, 1)];
    
    _searchBar.layer.masksToBounds = true;
    
    _searchBar.delegate = self;
    
    _searchBar.layer.cornerRadius = _searchBar.frame.size.height/2;
    
    _searchBar.leftView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, _searchBar.frame.size.height)];
    
    _searchBar.textColor = [UIColor whiteColor];
    
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView * rihgt = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, _searchBar.frame.size.height)];
    
    rihgt.image = [UIImage imageNamed:@"a2_sousuo"];
    
    rihgt.contentMode = UIViewContentModeCenter;
    
    rihgt.userInteractionEnabled = true;
    
    UITapGestureRecognizer* singleRecognizer;
   
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    
    singleRecognizer.numberOfTapsRequired = 1;
    
    [rihgt addGestureRecognizer:singleRecognizer];
    
    
    _searchBar.rightView = rihgt;
    
    _searchBar.rightViewMode = UITextFieldViewModeAlways;
    
    _searchBar.returnKeyType = UIReturnKeySearch;
    
    self.navigationItem.titleView = _searchBar;
    
    [self Creat_UI];
    
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([self stringisPureNull:textField.text] == true){
        
        _string_search = _searchBar.text ;
        
        if([self isPureNumandCharacters:textField.text] == true){
            
             _isNumber = YES;
            
            [self request:textField.text type:@"数字" isfrese:1];
            
        }else {
            
            _isNumber = NO;
            
            [self request:textField.text type:@"字符串" isfrese:1];
            
        }
        
    }else {
        
        
        [self MBShow:@"请填写下单人、订单号" backview:self.view];
        
    }
    
    return true;
    
}

-(void)handleSingleTapFrom{
    
    if([self stringisPureNull:_searchBar.text] == true){
        
         _string_search = _searchBar.text ;
        
        if([self isPureNumandCharacters:_searchBar.text] == true){
            
            _isNumber = YES;
            
            [self request:_searchBar.text type:@"数字" isfrese:1];
            
            
        }else {
           
            _isNumber = YES;
            
            [self request:_searchBar.text type:@"字符串" isfrese:1];
            
        }
        
    }else {
        
        [self MBShow:@"请填写下单人、订单号" backview:self.view];
        
    }
    
}
#pragma mark 网络请求
-(void)request:(NSString *)string type:(NSString *)type isfrese:(int)isfrese{
    
    [_searchBar resignFirstResponder];
    
    [SHARE_APP showHud];
    
    NSDictionary * dict = [NSDictionary dictionary];
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
    
    if([type isEqualToString:@"数字"]){
        
        dict  = @{@"siId":user_id,
                  
                  @"orderCode":string,
                  
                  @"type":@1,
                  
                  @"name":@""
                  
                  };
        
    }if([type isEqualToString:@"字符串"]){
        
        dict  = @{@"siId":user_id,
                  
                  @"orderCode":@"",
                  
                  @"type":@1,
                  
                  @"name":string
                  
                  };
        
    }
    
    
    
    [ZHJQHttpToll GET:LPCDINGDANSOUS  parameters:dict success:^(id responseObject) {
        
         NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        LPCsearchbarjiudianModel * model = [LPCsearchbarjiudianModel yy_modelWithJSON:dic_json];
        
        if(model.header.status == 0){
            
            [SHARE_APP hideHud];
            
            self.dataSouceArr = [model.data.orderList  mutableCopy];
            
            if(isfrese == 2){
                
                [self.MytableView.mj_header endRefreshing];
                
            }
            
            [self.MytableView reloadData];
            
            
            return ;
        }
        
        [self MBShow:model.header.msg backview:self.view];
        
    } failure:^(NSError *error) {
        
        [self MBShow:@"服务器繁忙" backview:self.view];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Creat_UI{
    
    if(_MytableView == nil){
        
        _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height )];
        
        _MytableView.delegate = self;
        
        _MytableView.dataSource = self;
        
        _MytableView.tableFooterView = [UIView new];
        
        _MytableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
            
            [_MytableView.mj_header beginRefreshing];
            
            [self request:2];
            
        }];
        
        
        
        [self.view addSubview:_MytableView];
        
    }
    
    _keyBoardView = [[LPCkeyBoardView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - State_HEIGHT - self.navigationController.navigationBar.frame.size.height, SCREEN_WIDTH, 44)];
    
    _keyBoardView.object = self;
    
    //[self.view addSubview:_keyBoardView];
    
    
    
    _dataSouceArr =[NSMutableArray array];
}

-(void)sendbuttonclick:(NSString *)string{
    
    
    NSLog(@"%@",string);
    
}
-(void)changeFrame:(CGFloat)heghit keyheghit:(CGFloat)keyheghit{
    
    CGRect  frame = _keyBoardView.frame;
    
    frame.origin.y = heghit;
    
    frame.size.height = SCREEN_HEIGHT - heghit -keyheghit;
    
    _keyBoardView.frame = frame;
        
}

-(void)viewDidLayoutSubviews {
    
    if ([self.MytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MytableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.MytableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MytableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    cell.backgroundColor = [UIColor whiteColor];
    
    serachbarjiudianOrderlist * model = _dataSouceArr[indexPath.section];
    
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
    
    nameLabel.text = model.goods_name;//@"双人房";
    
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
    
    
    UILabel * henglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, allLable.frame.origin.y + allLable.frame.size.height, SCREEN_WIDTH, .4)];
    
    henglabel.backgroundColor = [UIColor lightGrayColor];
    
    [cell.contentView addSubview:henglabel];
    
    
  
    
    // 酒店未使用订单
    if(model.order_state == 2){
        
        
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
        
        //[cell.contentView addSubview:button_one];
        
    }
    
    //酒店申请退款
    if(model.order_state == 3){
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:COLOR(255, 63, 81, 1)];
        
        [button setTitle:@"申请退款" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(jiudiantongyituikuai:) forControlEvents:UIControlEventTouchUpInside];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
        UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, button.frame.origin.y, 70, 30)];
        
        [button_one setBackgroundColor:[UIColor whiteColor]];
        
        [button_one setTitle:@"驳回请求" forState:UIControlStateNormal];
        
        [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
        
        [button_one addTarget:self action:@selector(jiudianbohuishenqing:) forControlEvents:UIControlEventTouchUpInside];
        
        button_one.layer.masksToBounds = true;
        
        button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
        
        button_one.tag = row;
        
        button_one.layer.cornerRadius = 7;
        
        button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
        
        button_one.layer.borderWidth = .5;
        
        [cell.contentView addSubview:button_one];
        
    }
   
    //酒店已使用
    if(model.order_state == 4){
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"已使用" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
    
        
    }
    //酒店已过期
    if(model.order_state == 5){
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"已过期" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
    }
    //酒店申请退款成功
    if(model.order_state == 6){
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"已退款" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
    }
    //酒店退款驳回
    if(model.order_state == 7){
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 35 + imageView.frame.origin.y + imageView.frame.size.height, 70, 30)];
        
        [button setBackgroundColor:[UIColor lightGrayColor]];
        
        [button setTitle:@"已驳回退款" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.masksToBounds = true;
        
        button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
        
        button.tag = row;
        
        button.layer.cornerRadius = 7;
        
        [cell.contentView addSubview:button];
        
        
    }
    

    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    serachbarjiudianOrderlist * model = _dataSouceArr[indexPath.section];
    
    // 未使用的界面
    if(model.order_state == 2){
        
        LPCHotelNOViewController  * JDViewcontroller = [[LPCHotelNOViewController alloc]init];

        JDViewcontroller.idString = model.order_code;
        
        JDViewcontroller.object= self;
        
        [self push:JDViewcontroller];
    
    }
    
    //  已申请退款的界面
    
    if(model.order_state == 3){
        
        LPCJDNoViewController * noviewcontroller = [LPCJDNoViewController new];
        
        noviewcontroller.okNostring = @"全部";
            
        noviewcontroller.object  = self;
            
        noviewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
        
        [self push:noviewcontroller];
    }
    
    //  已使用的界面
    
    if(model.order_state == 4){
        
        LPCHotelOkViewController  * OkViewController = [[LPCHotelOkViewController alloc]init];
        
        OkViewController.idString = model.order_code;
        
        [self push:OkViewController];
        
        
    }
    
    //  已过期的界面
    
    if(model.order_state == 5){
        
        LPCHoteloverdueViewController * Viewcontroller = [[LPCHoteloverdueViewController alloc]init];
        
        Viewcontroller.idString = model.order_code;
        
        [self push:Viewcontroller];
        
    }
    
    
    //  退款成功的界面
    
    if(model.order_state == 6){
        
        LPCJDNoViewController * noviewcontroller = [LPCJDNoViewController new];

        
        noviewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];

        noviewcontroller.okNostring =@"退款成功";
            
        [self push:noviewcontroller];
            
      
    }
    
    // 退款失败的界面
    
    if(model.order_state == 7){
        
        LPCJDNoViewController * noviewcontroller = [LPCJDNoViewController new];

        noviewcontroller.idString = [NSString stringWithFormat:@"%@",model.order_code];
        noviewcontroller.okNostring =@"退款失败";
        
        [self push:noviewcontroller];
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120 + 44 *2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   return _dataSouceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = COLOR(237, 242, 249, 1);
    
    return view;
    
    
}

#pragma mark  ======================= 酒店 验证、取消、申请退款、驳回退款 （开始）==================
#pragma mark 验证
-(void)yanzhenghexiao:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否验证核销该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        serachbarjiudianOrderlist * model = _dataSouceArr[sender.tag];
        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCYANZHENGHEXIAO parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                 [self request:1];
                
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
#pragma mark ============ 取消订单

-(void)quxiaodingdan:(UIButton *)sender{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否取消该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        serachbarjiudianOrderlist * model = _dataSouceArr[sender.tag];
        
        NSDictionary  *  dic = @{@"orderCode":model.order_code};
        
        [ZHJQHttpToll GET:LPCQUXIAODINGDAN parameters:dic success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [SHARE_APP  hideHud];
                
                [self request:1];
                
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
#pragma mark 酒店的同意退款
-(void)jiudiantongyituikuai:(UIButton *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否同意退款该订单?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [SHARE_APP showHud];
        
        serachbarjiudianOrderlist * model = _dataSouceArr[sender.tag];
        
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
                
                [self request:1];
                
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
        
        serachbarjiudianOrderlist * model = _dataSouceArr[sender.tag];
        
        NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
        
        NSString * user_id = [NSString stringWithFormat:@"%@",[user  objectForKey:@"Shop_id_LPC"]];
        
        
        NSDictionary * dic_request = @{@"orderCode":model.order_code ,@"siId":user_id,@"orderState":@"7",@"type":@1};
        
        
        [ZHJQHttpToll GET:LPCZITIJIEJKOU parameters:dic_request success:^(id responseObject) {
            
            NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            
            if([[self headdic:dic_json] isEqualToString:@"0"]){
                
                [self MBShow:@"驳回成功" backview:self.view];
                
               [self request:1];
                
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
    
    [self request:1];
    
}

#pragma mark 酒店验证核销的协议
- (void)chooserefre:(NSString *)type{
    
    [self request:1];
}

-(void)request:(int)isfrese{
    
    if(_isNumber == true){
        
        //数字
        [self request:_string_search type:@"数字" isfrese:isfrese];
        
    }else {
        
        // 字符串
        [self request:_string_search type:@"字符串" isfrese:isfrese];
    }
    
}
#pragma mark  ======================= 酒店 验证、取消、申请退款、驳回退款 （结束）==================

/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的值
 *
 *  @return YES ? NO
 */
-(BOOL)stringisPureNull:(NSString *)string{
    
    if([string isEqualToString:@""]){
        
        return false;
        
    }
    
    return true;
    
}

/**
 * 判断字符串是否是纯数字
 *
 *  @param string 需要判断的值
 *
 *  @return YES ? NO
 */
-(BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }else {
        

        return YES;
    }
    
    
    return NO;
}
@end
