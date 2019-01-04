//
//  LPCAlearyUseViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCAlearyUseViewController.h"

@interface LPCAlearyUseViewController ()

@end

@implementation LPCAlearyUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MyTableView                 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height - 40)];
    
    _MyTableView.tableFooterView = [UIView new];
    
    _MyTableView.delegate        = self;
    
    _MyTableView.dataSource      = self;
    
    _MyTableView.backgroundColor = COLOR(237, 242, 249, 1);
    
    [self.view addSubview:_MyTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews {
    
    if ([self.MyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.MyTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.MyTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.MyTableView setLayoutMargins:UIEdgeInsetsZero];
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
    
    
    if(row == 0){
        
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
        
        
        
    }if(row == 1){
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
        
        
        
        
        UILabel * allLabel = [[UILabel alloc]initWithFrame:CGRectMake(pirceLabel.frame.origin.x , pirceLabel.frame.origin.y + pirceLabel.frame.size.height + 5, nameLabel.frame.size.width  , 30)];
        
        
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
        
        
        
    }if(row == 2){
        
#warning 2016.8.5 修改 LPC 确认修改 和 确认完成的状态值
        if(section == 0){
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"已使用" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = true;
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        if(section == 1){
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
            
            [button setBackgroundColor:[UIColor lightGrayColor]];
            
            [button setTitle:@"已完成" forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
            
            button.layer.masksToBounds = true;
            
            button.tag = section;
            
            button.layer.cornerRadius = 7;
            
            [cell.contentView addSubview:button];
            
        }
        
    }
    
    
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0 || indexPath.row == 2)
        
        return 44;
    
    
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    
    return 4;
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
