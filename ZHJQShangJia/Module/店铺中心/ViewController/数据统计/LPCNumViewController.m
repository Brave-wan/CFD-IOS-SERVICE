//
//  LPCNumViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/2.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCNumViewController.h"

@interface LPCNumViewController ()

@end

@implementation LPCNumViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nav_title:@"数据统计"];
    
    [self left];
    
    
    
    NSUserDefaults  * user = [NSUserDefaults standardUserDefaults];
    
    NSString * key = [user objectForKey:@"KEY"];
    // 商品
    if([key isEqualToString:@"1"]){
        
        _type = @"1";
        
    }
    // 酒店
    if([key isEqualToString:@"2"]){
        
        _type = @"3";
        
    }
    // 饭店
    if([key isEqualToString:@"3"]){
        
        _type = @"2";
    }
    [self Creat_UI:_type];

     //  _type   饭店  2   酒店 3  商品 1
    
    // Do any additional setup after loading the view.
}
#pragma mark 页面布局
-(void)Creat_UI:(NSString *)string{
    
    //  string   饭店  2   酒店 3
    
    if(_TabelView == nil){
        
        _TabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT  - self.navigationController.navigationBar.frame.size.height)];
        
        _TabelView.delegate = self;
        
        _TabelView.dataSource = self;
        
        _dataSourceArr = [NSMutableArray array];
        
        _TabelView.tableFooterView = [UIView new];
        
        [self.view addSubview:_TabelView];
        
        
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
        
        headView.backgroundColor = COLOR(237, 242, 249, 1);
        
        _TabelView.tableHeaderView = headView;
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        
        imageView.image = [UIImage imageNamed:@"d5_beijing"];
        
        [headView addSubview:imageView];
        
        UILabel * manyLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH - 120, 45)];
        
        manyLabel.backgroundColor = [UIColor whiteColor];
        
        manyLabel.textAlignment = NSTextAlignmentCenter;
        
        manyLabel.layer.masksToBounds =true;
        
        manyLabel.layer.cornerRadius = 22.5;
        
        manyLabel.alpha = .8;
        
        manyLabel.tag = 11;
        
        manyLabel.text = [NSString stringWithFormat:@"进入订单共计 :    2"];
        
        if([string isEqualToString:@"2"])
            
            manyLabel.text  = [NSString stringWithFormat:@"进入订单共计 :    4"];
        
        if([string isEqualToString:@""])
            
            manyLabel.text  = [NSString stringWithFormat:@"进入订单共计 :    4"];
        
        manyLabel.font = [UIFont systemFontOfSize:manyLabel.font.pointSize - 6];
        
        [imageView addSubview:manyLabel];
        
        UILabel * nameLaebl = [[UILabel alloc]initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 35)];
        
        nameLaebl.text = @"  以下是今日订单明细:";
        
        nameLaebl.textColor = [UIColor lightGrayColor];
        
        nameLaebl.font = [UIFont systemFontOfSize:nameLaebl.font.pointSize - 4];
        
        nameLaebl.textAlignment = NSTextAlignmentLeft;
        
        [headView addSubview:nameLaebl];
        
        
        UILabel * hengLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 134.5, SCREEN_WIDTH, .5)];
        
        hengLabel.backgroundColor = [UIColor lightGrayColor];
        
        [headView addSubview:hengLabel];
        
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    
    if ([self.TabelView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.TabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.TabelView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [self.TabelView setLayoutMargins:UIEdgeInsetsZero];
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
    
    if([_type isEqualToString:@"1"]){
        
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
            
            
            
        }if(row == 2){
            
            if(section == 0){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"确认发货" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }
            if(section == 1){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:COLOR(0, 150, 224, 1)];
                
                [button setTitle:@"确认完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.layer.masksToBounds = true;
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }
            
        }
        
        
        
    }if([_type isEqualToString:@"2"]){
        
        
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
            
            if(section == 0 | section == 3)
                
                imageView.image = [UIImage imageNamed:@"b1_tu1"];
            
            if(section == 1 | section == 2 )
                
                imageView.image = [UIImage imageNamed:@"b1_tu2"];
            
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text = @"单品预定订单";
            
            if(section == 2 | section == 3)
                
                nameLabel.text = @"双人餐";
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            if(section == 0){
                
                timeLaebl.text = @"就餐时间 : 2016.06.21  18:30";
                
            }if(section == 1 || section == 2 | section == 3){
                
                timeLaebl.text = @"就餐时间 : 2016.06.21  18:30 \n数量 : 2";
                
            }
            
            timeLaebl.numberOfLines = 0 ;
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 5];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
            
            allLable.text = @"总额 : ￥750";
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"总额 : ￥750"];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, 3 + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
           
            
        }if(row == 2){
            
            if(section == 0 | section == 3){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"验证核销" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, 7, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
                
                
            }
            if(section == 1 | section == 2){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"交易完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.layer.masksToBounds = true;
                
                button.tag = section;
                
                button.enabled = false;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }
            
        }
        
        
        
    }
    
    if([_type isEqualToString:@"3"]){
        
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
            
            if(section == 0 | section == 3)
                
                imageView.image = [UIImage imageNamed:@"b1_tu1"];
            
            if(section == 1 | section == 2 )
                
                imageView.image = [UIImage imageNamed:@"b1_tu2"];
            
            
            
            [cell.contentView addSubview:imageView];
            
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + 10, imageView.frame.origin.y , SCREEN_WIDTH - 20 - imageView.frame.size.width, 30)];
            
            nameLabel.text = @"双人房";
            
            nameLabel.textAlignment = NSTextAlignmentLeft;
            
            nameLabel.adjustsFontSizeToFitWidth = true;
            
            [cell.contentView addSubview:nameLabel];
            
            
            
            UILabel * timeLaebl = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + 30, nameLabel.frame.size.width, 30)];
            
            timeLaebl.textAlignment = NSTextAlignmentLeft;
            
            timeLaebl.text = @"房间数 : 1间 \n入住 : 6月23日 离店:6月28日   5晚";
            
            timeLaebl.numberOfLines = 0 ;
            
            timeLaebl.textColor = [UIColor lightGrayColor];
            
            timeLaebl.font = [UIFont systemFontOfSize:timeLaebl.font.pointSize - 7];
            
            [cell.contentView addSubview:timeLaebl];
            
            
            UILabel * allLable = [[UILabel alloc]initWithFrame:CGRectMake(timeLaebl.frame.origin.x, timeLaebl.frame.size.height + timeLaebl.frame.origin.y + 5, timeLaebl.frame.size.width, 30)];
            
            allLable.text = @"总额 : ￥750";
            
            allLable.textColor = [UIColor blackColor];
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"总额 : ￥750"];
            
            UIColor * color = COLOR(255, 70, 78, 1);
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(5, 3 + 1)];
            
            allLable.attributedText = AttributedStr;
            
            
            [cell.contentView addSubview:allLable];
            
            
        }if(row == 2){
            
            if(section == 0 | section == 3){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:COLOR(255, 63, 81, 1)];
                
                [button setTitle:@"验证核销" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.layer.masksToBounds = true;
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.tag = section;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
                
                UIButton * button_one = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90-20-70, 7, 70, 30)];
                
                [button_one setBackgroundColor:[UIColor whiteColor]];
                
                [button_one setTitle:@"取消订单" forState:UIControlStateNormal];
                
                [button_one setTitleColor:COLOR(255, 63, 81, 1) forState:UIControlStateNormal];
                
                button_one.layer.masksToBounds = true;
                
                button_one.titleLabel.font = [UIFont systemFontOfSize:button_one.titleLabel.font.pointSize - 5];
                
                button_one.tag = section;
                
                button_one.layer.cornerRadius = 7;
                
                button_one.layer.borderColor = COLOR(255, 63, 81, 1).CGColor;
                
                button_one.layer.borderWidth = .5;
                
                [cell.contentView addSubview:button_one];
                
                
                
            }
            if(section == 1 | section == 2){
                
                UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 7, 70, 30)];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                
                [button setTitle:@"交易完成" forState:UIControlStateNormal];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                button.titleLabel.font = [UIFont systemFontOfSize:button.titleLabel.font.pointSize - 5];
                
                button.layer.masksToBounds = true;
                
                button.tag = section;
                
                button.enabled = false;
                
                button.layer.cornerRadius = 7;
                
                [cell.contentView addSubview:button];
                
            }
            
        }

        
        
    }
    
    
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    
   // 饭店(四种情况 : 单品 和 套餐---<预定 和  结束>)
    LPCHDetailsViewController  * HDViewcontroller = [[LPCHDetailsViewController alloc]init];
    
    // 酒店 已使用 3  未使用 1
    
    LPCJDelegaietViewController  * JDViewcontroller = [[LPCJDelegaietViewController alloc]init];
    
    LPCCommodityViewController * ViewController = [[LPCCommodityViewController alloc]init];
    
    if([_type isEqualToString:@"2"]){
        
        if(section == 0)
           
            HDViewcontroller.type = @"1";
    
        if(section == 1)
            
            HDViewcontroller.type = @"2";
    
        if(section == 2)
            
            HDViewcontroller.type = @"3";
    
        if(section == 3)
        
            HDViewcontroller.type = @"4";
    
    [self push:HDViewcontroller];
        
    }if([_type isEqualToString:@"3"]){
        
        if(section == 0)
            
            JDViewcontroller.type = @"1";
        
        if(section == 1)
            
            JDViewcontroller.type = @"3";
        
       
        
        [self push:JDViewcontroller];
        
        
    }if([_type isEqualToString:@"1"]){
        
        if(section == 0)
            
            ViewController .type = @"1";
        
        if(section == 1)
            
            ViewController.type = @"3";
        
        
        
        [self push:ViewController];
        
    }
    
       
    
    
    
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
    if([_type isEqualToString:@"1"] | [_type isEqualToString:@"3"])
        
        return 2;
    
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }
    
    return 5;
    
}


@end
