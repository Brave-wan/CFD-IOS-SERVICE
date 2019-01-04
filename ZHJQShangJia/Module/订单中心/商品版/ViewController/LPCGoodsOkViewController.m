//
//  LPCGoodsOkViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/5.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCGoodsOkViewController.h"

@interface LPCGoodsOkViewController ()

@end

@implementation LPCGoodsOkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  0 基本设置
    
    [self nav_title:@"订单详情"];
    
    [self left];
    
    [self Creat_UI];
    
    //  商品版已完成
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 页面布局
-(void)Creat_UI{
    
    if(!_TableView){
        
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TableView.delegate = self;
        
        _TableView.dataSource = self;
        
        _TableView.tableFooterView = [UIView new];
        
        _TableView.backgroundColor = COLOR(237, 242, 249, 1);
        
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
    
    
    
    if(section == 0){
        
        UILabel * orlderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, SCREEN_WIDTH -10, 30)];
        
        orlderLabel.textAlignment = NSTextAlignmentLeft;
        
        orlderLabel.text = @"订单号 : 306954231";
        
        orlderLabel.font = [UIFont systemFontOfSize:orlderLabel.font.pointSize - 3];
        
        [cell.contentView addSubview:orlderLabel];
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 7, 30, 30)];
        
        imageView.image  =[UIImage imageNamed:@"d19_touxaing"];
        
        [cell.contentView addSubview:imageView];
        
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 7, 80, 30)];
        
        nameLabel.text = @"爱旅行的小疯子";
        
        nameLabel.adjustsFontSizeToFitWidth = true;
        
        [cell.contentView addSubview:nameLabel];
        
        
        
    }
    
    if(section == 1){
        
        if( row == 0){
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 110, 90)];
            
            if(section == 0)
                
                imageView.image = [UIImage imageNamed:@"c1_tu1"];
            
            if(section == 1)
                
                imageView.image = [UIImage imageNamed:@"c1_tu2"];
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text = @"这里是商品名称";
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            UILabel * pirceLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30 + 5, nameLabel.frame.size.width/3 -15, 30)];
            
            pirceLabel.text = @"￥120";
            
            pirceLabel.textAlignment  = NSTextAlignmentLeft;
            
            pirceLabel.font = [UIFont systemFontOfSize:pirceLabel.font.pointSize - 8];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"￥120"];
            
            UIColor * color;
            
            color = COLOR(255, 70, 78, 1);
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(0, 3 + 1)];
            
            
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:[UIFont systemFontOfSize:pirceLabel.font.pointSize + 3]
             
                                  range:NSMakeRange(0, 3 + 1)];
            
            
            
            pirceLabel.attributedText = AttributedStr;
            
            [cell.contentView addSubview:pirceLabel];
            
            UILabel * pirceLabel_other = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x + pirceLabel.frame.size.width, nameLabel.frame.origin.y + 30 + 7.5, nameLabel.frame.size.width/3 * 2 + 15, 30)];
            
            pirceLabel_other.text = @"￥120";
            
            pirceLabel_other.textAlignment  = NSTextAlignmentLeft;
            
            pirceLabel_other.font = [UIFont systemFontOfSize:pirceLabel_other.font.pointSize - 8];
            
            NSMutableAttributedString *AttributedStr_ = [[NSMutableAttributedString alloc]initWithString:@"￥150      配送费:￥0.00"];
            
            
            [AttributedStr_ addAttribute:NSForegroundColorAttributeName
             
                                   value:[UIColor lightGrayColor]
             
                                   range:NSMakeRange(0, AttributedStr_.length)];
            
            
            
            [AttributedStr_ addAttribute:NSStrikethroughStyleAttributeName
             
                                   value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
             
                                   range:NSMakeRange(0, 3 + 1)];
            
            pirceLabel_other.attributedText = AttributedStr_;
            
            [cell.contentView addSubview:pirceLabel_other];
            
            
            
            
            UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x , pirceLabel.frame.origin.y + pirceLabel.frame.size.height + 5, nameLabel.frame.size.width, 30)];
            
            
            allLabel.text = @"总额 ￥120           X 1";
            
            allLabel.textAlignment  = NSTextAlignmentLeft;
            
            allLabel.font = [UIFont systemFontOfSize:allLabel.font.pointSize - 8];
            
            
            NSMutableAttributedString * AttributedSt = [[NSMutableAttributedString alloc]initWithString:@"总额 ￥120           X 1"];
            
            
            allLabel.textColor = [UIColor lightGrayColor];
            
            
            [AttributedSt addAttribute:NSForegroundColorAttributeName
             
                                 value:color
             
                                 range:NSMakeRange(3, 3 + 1)];
            
            
            [AttributedSt addAttribute:NSFontAttributeName
             
                                 value:[UIFont systemFontOfSize:allLabel.font.pointSize + 3]
             
                                 range:NSMakeRange(3, 3 + 1)];
            
            
            allLabel.attributedText = AttributedSt;
            
            [cell.contentView addSubview:allLabel];
            
            
            
            
        }
        
        
        if(row == 1){
            
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                                
                [button setTitle:@"已完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
            
                button.enabled = false;
            
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            
        }
        
    }  if(section == 2){
        
        if(row == 0){
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
            label.text = @"  订单信息";
            
            label.textAlignment = NSTextAlignmentLeft;
            
            label.textColor = [UIColor lightGrayColor];
            
            label.font = [UIFont systemFontOfSize:label.font.pointSize - 4];
            
            [cell.contentView addSubview:label];
            
            
        }if(row == 2){
            
            
            NSMutableArray * dataArr = [NSMutableArray arrayWithObjects:@"  创建时间 : 2016-06-15  13:20:21",@"  付款时间 : 2016-06-15  13:22:59",@"  支付方式 : 在线支付",@"  数      量 : 韩宝河",@"  配送方式 :  1",@"   配 送 费 :￥0.00 ",@"  总      额  : ￥120", nil];
            
            for(int i = 0 ; i < dataArr.count ; i ++){
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5 + i * 20 , SCREEN_WIDTH, 20)];
                
                label.textColor = [UIColor lightGrayColor];
                
                label.text = dataArr[i];
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 6];
                
                [cell.contentView addSubview:label];
                
                
                
            }
            
        }if(row == 1){
            
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 39/3, 66/3)];
            
            imageView.image = [UIImage imageNamed:@"c2_ditu"];
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5, SCREEN_WIDTH - 30, 15)];
            
            namelabel.text = @"收货人 :    韩宝河";
            
            namelabel.textAlignment = NSTextAlignmentLeft;
            
            namelabel.font = [UIFont systemFontOfSize:namelabel.font.pointSize - 6];
            
            [cell.contentView addSubview:namelabel];
            
            UILabel * telLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 + 13, 5, SCREEN_WIDTH - 35, 15)];
            
            telLabel.text = @"13633215523";
            
            telLabel.textAlignment = NSTextAlignmentRight;
            
            telLabel.font = [UIFont systemFontOfSize:telLabel.font.pointSize - 6];
            
            [cell.contentView addSubview:telLabel];
            
            
            UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(namelabel.frame.origin.x , namelabel.frame.origin.y + namelabel.frame.size.height , namelabel.frame.size.width, 15)];
            
            addressLabel.text = @"河北省石家庄市高新区天山大街266号放大科技园3号楼508室";
            
            addressLabel.textColor = [UIColor lightGrayColor];
            
            addressLabel.font = [UIFont systemFontOfSize:addressLabel.font.pointSize - 6];
            
            addressLabel.adjustsFontSizeToFitWidth = true;
            
            
            [cell.contentView addSubview:addressLabel];
            
            
        }
        
        
        
    }
    
    
    return cell;
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if(section == 0)
        
        return 1;
    
    if(section == 1)
        
        return 2;
    
    if(section == 2)
        
        return 3;
    
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if(indexPath.section == 0)
        
        return 44;
    
    if(indexPath.section == 1){
        
        if(indexPath.row == 1){
            
            return 44;
            
        }
        
        return 120;
        
    }if(indexPath.section == 2){
        
        if(indexPath.row == 0){
            
            return 44;
            
        }if(indexPath.row == 1){
            
            return 10 + 10 + 22;
            
        }
        
    }
    
    
    
    
    return 180;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    view.backgroundColor = self.TableView.backgroundColor;
    
    return view;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    
    return 5;
    
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
