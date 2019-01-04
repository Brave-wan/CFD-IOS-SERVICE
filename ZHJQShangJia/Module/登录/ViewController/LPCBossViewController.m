//
//  LPCBossViewController.m
//  ZHJQShangJia
//
//  Created by APP on 16/8/4.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "LPCBossViewController.h"
#import "HBHSheetView.h"
#import "QRadioButton.h"
#import "LGPhotoAssets.h"
#import "DLRadioButton.h"
#import "LPCUPPAWmodel.h"
#import "UIImageView+WebCache.h"

@interface LPCBossViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,LGPhotoPickerViewControllerDelegate>

@property (nonatomic, assign) LGShowImageType showType;

@property (nonatomic ,strong) DLRadioButton *firstRadioButton;

@property (nonatomic ,strong) DLRadioButton *radioButton;

@end

@implementation LPCBossViewController

-(void)RadioButton{
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
    NSString * string = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shifouyouyingyezhizhaobiaoshi"]]];
    
    if([string isEqualToString:@""]){
        
        [self getuserying:@"是"];
        
        string = @"是";
    }
    
    _firstRadioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(130, 7, 60, 30)];
    
  
    
    [_firstRadioButton setTitle:@"是" forState:UIControlStateNormal];
    
   
    
    [_firstRadioButton setTitleColor:[UIColor blackColor] forState:0];
    
    [_firstRadioButton addTarget:self action:@selector(firstbutton_click) forControlEvents:UIControlEventTouchUpInside];
    
    _firstRadioButton.icon = [UIImage imageNamed:@"radio_unchecked.png"];
    
    _firstRadioButton.iconSelected = [UIImage imageNamed:@"单选修改后的按钮.png"];
    
    _firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
   
    
    
    NSMutableArray *otherButtons = [NSMutableArray new];
    
    _radioButton = [[DLRadioButton alloc] initWithFrame:CGRectMake(200, 7, 60, 30)];
   
    [_radioButton setTitle:@"否" forState:UIControlStateNormal];
    
    [_radioButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _radioButton.icon = [UIImage imageNamed:@"radio_unchecked.png"];
    
    _radioButton.iconSelected = [UIImage imageNamed:@"单选修改后的按钮.png"];
    
    [_radioButton addTarget:self action:@selector(ridiobutton_click) forControlEvents:UIControlEventTouchUpInside];
    
    _radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [otherButtons addObject:_radioButton];
    
    _firstRadioButton.otherButtons = otherButtons;
    
    
    if([string isEqualToString:@"是"]){
        
        [_firstRadioButton setSelected:true];
        
        [_radioButton setSelected:false];
        
    }else{
       
         [self tableviewsection:2];
        
        [_firstRadioButton setSelected:false];
        
        [_radioButton setSelected:true];
        
    }
    
}

-(void)imageorstringorther{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];

    _MerchantNameString = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shangjianame"]]];
    
    _StoreTypeString = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"dianpuleixing"]]];
    
    _OperatingProductsString = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"jingyingchanpin"]]];
    

    _accounttypeString = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"zhanghaoleixing"]]];
    
    _accountNameString = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"zhanghumingcheng"]]];
    
    _BankaccountString  =[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"yihangzhanghu"]]];
    
    _BankString  =[self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"kaihuahang"]]];
    
    
    //  营业执照
    id idcardyes = [user objectForKey:@"yingyezhizhao"];
    
    UIImage* image_yes;
    
    if([idcardyes isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"yingyezhizhao"];
        
        image_yes = [UIImage imageWithData:imageData_yes];
        
        
        
        
    }else{
        
        NSString * string_url = idcardyes;
        
        UIImageView  *  imageView = [[UIImageView alloc]init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
        
        image_yes = imageView.image;
        
    }
    
    if([self getimage:image_yes] == true){
        
        
        _image = image_yes;
        
    }else{
        
        _image = [UIImage imageNamed:@"dl3_tianjia"];

    }
    
    
    
    // 证书
    
    
    id image_zhengshu_one = [user objectForKey:@"zhengshu"];
    
    UIImage* image_zhengshu;
    
    if([image_zhengshu_one isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"zhengshu"];
        
        image_zhengshu = [UIImage imageWithData:imageData_yes];
        
        
    }else{
        
        NSString * string_url = image_zhengshu_one;
        
        UIImageView  *  imageView = [[UIImageView alloc]init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
        image_zhengshu = imageView.image;
        
    }
    
    if([self getimage:image_zhengshu] == true){
        
        
        _image_other = image_zhengshu;
        
    }else{
        
        _image_other = [UIImage imageNamed:@"dl3_tianjia"];
        
    }
    
    
    
    
    // 其他证书
    
    id image_zhengshu_two = [user objectForKey:@"zhengshuqita"];
    
    UIImage* image_zhengshu_two_other;
    
    if([image_zhengshu_two isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"zhengshuqita"];
        
        image_zhengshu_two_other = [UIImage imageWithData:imageData_yes];
        
        
    }else{
        
        NSString * string_url = image_zhengshu_two;
        
        UIImageView  *  imageView = [[UIImageView alloc]init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
        image_zhengshu_two_other = imageView.image;
        
    }
    
    if([self getimage:image_zhengshu_two_other] == true){
        
        
        _image_other_one = image_zhengshu_two_other;
        
    }else{
        
        _image_other_one = [UIImage imageNamed:@"dl3_tianjia"];
        
    }
    
   
    
    
    
    _YesOrNo = true;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self left];
  
    [self nav_title:@"注册——商家认证"];
    
    [self imageorstringorther];
    
    [self Creat_UI];
    
    [self RadioButton];
    
    // Do any additional setup after loading the view.
}

-(void)Creat_UI{
    
    if (!_TabelView) {
        
        _TabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - State_HEIGHT - self.navigationController.navigationBar.frame.size.height)];
        
        _TabelView.delegate  =self;
        
        _TabelView.dataSource = self;
        
        UIView * FootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        
        FootView.backgroundColor  =COLOR(237, 243, 238, 1);
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 30)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"dl3_xiayibu"] forState:0];
        
        [button setTitle:@"提交注册申请" forState:0];
        
        [button addTarget:self action:@selector(button_click) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:[UIColor whiteColor] forState:0];
        
        
        [FootView addSubview:button];
        
        
        UILabel * lbael = [[UILabel alloc]initWithFrame:CGRectMake(0, button.frame.origin.y +  button.frame.size.height + 5, SCREEN_WIDTH, 40)];
        
        lbael.text = @"隐私声明:我们承诺此信息仅用于核实商家信息,不做任何其他用途!";
        
        lbael.backgroundColor = [UIColor clearColor];
        
        lbael.textAlignment = NSTextAlignmentCenter;
        
        lbael.textColor = [UIColor lightGrayColor];
        
        lbael.font = [UIFont systemFontOfSize:lbael.font.pointSize - 2];
        
        lbael.adjustsFontSizeToFitWidth = true;
        
        [FootView addSubview:lbael];
        
        _TabelView.tableFooterView = FootView;
        
        [self.view addSubview:_TabelView];
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


- (BOOL)isPureInt:(NSString*)string{
  
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
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
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if(section == 0){
        
        NSMutableArray * name =[NSMutableArray arrayWithObjects:@"商家名称",@"店铺类型",@"经营产品",nil];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 70, 30)];
        
        label.text = name[row];
        
        [cell.contentView addSubview:label];
        
        UITextField  * placeTextFild = [[UITextField alloc]initWithFrame:CGRectMake(80, 7, SCREEN_WIDTH - 90-30, 30)];
        
        placeTextFild.delegate = self;
        
        placeTextFild.tag = 100 + indexPath.row;
        
        placeTextFild.placeholder = @"请输入";
        
        if(row == 0){
            
            placeTextFild.placeholder = @"请输入商家名称";
            
            
            placeTextFild.text =  [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shangjianame"]]];
            
        }
        if(row == 1){
            
            placeTextFild.placeholder = @"请输入商铺类型";
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.tag = 10 + section;
            
            button.frame = CGRectMake(tableView.frame.size.width - 40, 4, 40, 40);
            
            [button addTarget:self action:@selector(chooseGender:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setBackgroundColor:[UIColor clearColor]];
            
            [button setImage:[UIImage imageNamed:@"dl3_jiantou"] forState:UIControlStateNormal];
            
            [cell.contentView addSubview:button];
            
            
            if([self isPureInt:_StoreTypeString] == true){
                
                if([_StoreTypeString intValue] == 1){
                    
                    _StoreTypeString= @"酒店";
                    
                }
                if([_StoreTypeString intValue] == 2){
                    
                    _StoreTypeString= @"特产";
                    
                    
                }if([_StoreTypeString intValue] == 3){
                    
                    _StoreTypeString= @"饭店";
                    
                }
                if([_StoreTypeString intValue] == 4){
                    
                    
                    _StoreTypeString = @"小吃";
                    
                }
                
                
            }
            
            placeTextFild.text   =  _StoreTypeString;
            
            placeTextFild.enabled   = false;
            
        }
        if(row == 2){
            
            placeTextFild.placeholder = @"请输入经营产品";
            
            placeTextFild.text = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"jingyingchanpin"]]];//_OperatingProductsString;
            
        }
        
        [cell.contentView addSubview:placeTextFild];
        
        
    }
    
    
    if(section == 1){
        
        
        NSMutableArray * name =[NSMutableArray arrayWithObjects:@"账号类型",@"账户名称",@"银行账号",@"开户行",nil];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 70, 30)];
        
        label.text = name[row];
        
        [cell.contentView addSubview:label];
        
        UITextField  * placeTextFild = [[UITextField alloc]initWithFrame:CGRectMake(80, 7, SCREEN_WIDTH - 90-30, 30)];
        
        placeTextFild.delegate = self;
        
        placeTextFild.tag = 200  +  indexPath.row;
        
        if(row == 0){
            
            placeTextFild.placeholder = @"请输入商家账户类型";
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(tableView.frame.size.width - 40, 5, 40, 40);
            
            button.tag = 10 + section;
            
            [button addTarget:self action:@selector(chooseGender:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setImage:[UIImage imageNamed:@"dl3_jiantou"] forState:UIControlStateNormal];
            
            [cell.contentView addSubview:button];
            
            
            placeTextFild.text = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"zhanghaoleixing"]]];
            
            placeTextFild.enabled   = false;
            
        }
        if(row == 1){
            
            placeTextFild.placeholder = @"请输入店主名字或公司名称";
            
            placeTextFild.text = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"zhanghumingcheng"]]];
            
        }
        if(row == 2){
            
            placeTextFild.placeholder = @"请输入银行账号";
            
            placeTextFild.keyboardType = UIKeyboardTypeNumberPad;
            
            placeTextFild.text = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"yihangzhanghu"]]];
            
            
        } if(row == 3){
            
            placeTextFild.placeholder = @"请输入银行名称";
            
            placeTextFild.text = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"kaihuahang"]]];
            
        }
        
        placeTextFild.font = [UIFont systemFontOfSize:placeTextFild.font.pointSize - 2];
        
        [cell.contentView addSubview:placeTextFild];
        
        
    }
    
    if(section == 2){
        
        
        if(row == 0){
            
            
            UILabel * lanel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 120, 30)];
            
            lanel.text = @"是否有营业执照";
            
            [cell.contentView addSubview:lanel];
            
            
            [cell.contentView addSubview:_firstRadioButton];
                
            [cell.contentView addSubview:_radioButton];
            
            
        }if(row == 1){
            
            
            
            
            id idcardyes = [user objectForKey:@"yingyezhizhao"];
            
            UIImage* image_yes;
            
            if([idcardyes isKindOfClass:[NSData class]]){
                
                NSData* imageData_yes = [user objectForKey:@"yingyezhizhao"];
                
                image_yes = [UIImage imageWithData:imageData_yes];
                
                
                
                
            }else{
                
                NSString * string_url = idcardyes;
                
                UIImageView  *  imageView = [[UIImageView alloc]init];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
                
                
                image_yes = imageView.image;
                
            }
            
            
            
            for (int i = 0 ; i < 2;  i ++) {
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * i, 10, SCREEN_WIDTH/2, 20)];
                
                label.text  = @"营业执照";
                
                if(i == 1){
                    
                    label.text = @"照片示例";
                    
                }
                
                
                
                label.textAlignment =  NSTextAlignmentCenter;
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                label.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:label];
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4 - 75/2) + i * (SCREEN_WIDTH/2), label.frame.origin.y + label.frame.size.height + 10, 75, 75)];
                
                if(i == 0){
                    
                    if([self getimage:image_yes] == true){
                        
                        imageView.image = image_yes;
                        
                    }else{
                        
                        imageView.image = [UIImage imageNamed:@"dl3_tianjia"];
                    }
                    
                    imageView.userInteractionEnabled = true;
                    
                    imageView.contentMode = UIViewContentModeScaleToFill;
                    
                    UITapGestureRecognizer* singleRecognizer;
                   
                    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
                    singleRecognizer.numberOfTapsRequired = 1;
                    
                    [imageView addGestureRecognizer:singleRecognizer];
                    
                } if(i == 1){
                    
                    imageView.image = [UIImage imageNamed:@"d26_tu3"];
                }
                
                [cell.contentView addSubview:imageView];
            }
            
        }
        
    }if(section == 3){
        
        if(row == 0){
            
            
            UILabel * lanel = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 120, 30)];
            
            lanel.text = @"其他证书";
            
            [cell.contentView addSubview:lanel];
            
            
        }if(row == 1){
            
           
            
            id image_zhengshu_one = [user objectForKey:@"zhengshu"];
            
            UIImage* image_yes;
            
            if([image_zhengshu_one isKindOfClass:[NSData class]]){
                
                NSData* imageData_yes = [user objectForKey:@"zhengshu"];
                
                image_yes = [UIImage imageWithData:imageData_yes];
                
                
            }else{
                
                NSString * string_url = image_zhengshu_one;
                
                UIImageView  *  imageView = [[UIImageView alloc]init];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
                
                image_yes = imageView.image;
                
            }

            
        
            id image_zhengshu_two = [user objectForKey:@"zhengshuqita"];
            
            UIImage* image_no;
            
            if([image_zhengshu_two isKindOfClass:[NSData class]]){
                
                NSData* imageData_yes = [user objectForKey:@"zhengshuqita"];
                
                image_no = [UIImage imageWithData:imageData_yes];
                
                
            }else{
                
                NSString * string_url = image_zhengshu_two;
                
                UIImageView  *  imageView = [[UIImageView alloc]init];
                
                [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
                
                image_no = imageView.image;
                
            }
            
            
            for (int i = 0 ; i < 2;  i ++) {
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * i, 10, SCREEN_WIDTH/2, 20)];
                
                label.text  = @"其他证书";
                
                label.textAlignment =  NSTextAlignmentCenter;
                
                label.font = [UIFont systemFontOfSize:label.font.pointSize - 3];
                
                label.adjustsFontSizeToFitWidth = true;
                
                [cell.contentView addSubview:label];
                
                
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4 - 75/2) + i * (SCREEN_WIDTH/2), label.frame.origin.y + label.frame.size.height + 10, 75, 75)];
                
                imageView.contentMode = UIViewContentModeScaleToFill;
                
                if (i == 0) {
                    
                    
                    if([self getimage:image_yes] == true){
                    
                        imageView.image = image_yes;
                        
                    }else {
                        
                        
                        imageView.image = [UIImage imageNamed:@"dl3_tianjia"];
                    }
                   
                    
                }else{
                    
                    if([self getimage:image_no] == true){
                        
                        imageView.image = image_no;
                        
                    }else {

                        imageView.image = [UIImage imageNamed:@"dl3_tianjia"];
                        
                    }
                    
                }
                
                imageView.userInteractionEnabled = true;
                
                UITapGestureRecognizer*  singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTaptwo:)];
                singleRecognizer.numberOfTapsRequired = 1;
                
                [imageView addGestureRecognizer:singleRecognizer];
                
                imageView.tag = i ;
                
                [cell.contentView addSubview:imageView];
                
            }
            
        }

        
    }
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}
#pragma mark  是否有营业执照 是
-(void)firstbutton_click{
    
    _YesOrNo = true;
    
    [self getuserying:@"是"];
    
    [self tableviewsection:2];
    
}
#pragma mark  是否有营业执照 否
-(void)ridiobutton_click{
    
    _YesOrNo = false;
    
    [self getuserying:@"否"];
    
    [self tableviewsection:2];
    
}
#pragma mark 是否有营业执照的存储
-(void)getuserying:(NSString *)string{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:string forKey:@"shifouyouyingyezhizhaobiaoshi"];
    
    [user synchronize];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0)
        
        return 3;
    
    if(section == 1)
        
        return 4;
    
    if(section == 3)
        
        return 2 ;
    
    if(section == 2){
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        

        NSString * string = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"shifouyouyingyezhizhaobiaoshi"]]];
        
        if([string isEqualToString:@""] ||  [string isEqualToString:@"是"]){
            
            return 2;
        }
        
        return 1;
        
    }
        
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 2 | indexPath.section == 3){
        
         if(indexPath.row == 1)
             
             return 135;
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
        
        label.text  =@"   添加结算账户信息";
        
        label.font = [ UIFont systemFontOfSize:label.font.pointSize - 3];
        
        label.backgroundColor = COLOR(228, 233, 238, 1);
        
        label.textColor = COLOR(255, 63, 81, 1);
        
        return label;
        
        
    }
        
        
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 0;
        
    }if(section == 1){
        
        return 30;
    }
    
    return 5;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat sectionHeaderHeight = 40;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
    
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
    
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    
    }
}
-(void)chooseGender:(UIButton *)sender{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if(sender.tag  == 10){
     
        NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"酒店",@"饭店",@"特产",@"小吃", nil];
        
        HBHSheetView * sheetView = [[HBHSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withArray:array];
        
        
    
        
        [sheetView setChooseBlock:^(NSString * string) {
            
            UITextField * textfild = (UITextField *)[self.TabelView viewWithTag:101];
            
            textfild.text = string;
            
            _StoreTypeString = string;
            
            [user setObject:_StoreTypeString forKey:@"dianpuleixing"];
            
            
        }];
        
        [sheetView show];
        
    }if(sender.tag == 11){
        
        NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"个人",@"对公", nil];
        
        HBHSheetView * sheetView = [[HBHSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withArray:array];
        
        
        [sheetView setChooseBlock:^(NSString * string) {
            
            _accounttypeString = string;
            
            UITextField * textfild = (UITextField *)[self.TabelView viewWithTag:200];
            
            textfild.text = string;
            
            [user setObject:_accounttypeString forKey:@"zhanghaoleixing"];

            
        }];
        
        [sheetView show];
        
    }
    
    [user synchronize];
    
}

#pragma mark 营业执照
-(void)handleSingleTapFrom{
    
    _type = @"1";
    
    [self showsheet];
    
}
#pragma mark 其他证书
-(void)handleSingleTaptwo:(UITapGestureRecognizer *)faly{
    
    if(faly.view.tag == 0){
        
        _type = @"2";
        
    }else{
        
        _type = @"3";
    
    }
    
    [self showsheet];
    
}

#pragma mark 展示sheet
-(void)showsheet{
    
    WFActionSheet * sheet = [[WFActionSheet alloc]initWithTitle:@"请选择来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"图库",@"相机", nil];
    
    [sheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        
        [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
        
    } if(buttonIndex == 1){
        
        [self creat_ma];
        
    }
    
    
}

#pragma mark 图库的选择
- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style {
    
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    
    pickerVc.status = PickerViewShowStatusCameraRoll;
    
    pickerVc.maxCount = 1 ;
    
    pickerVc.delegate = self;
    
    self.showType = style;
    
    [pickerVc showPickerVc:self];
    
}
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    
    LGPhotoAssets * asset   =  assets[0];

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if([_type isEqualToString:@"1"]){
        
        _image = asset.thumbImage;

        [user setObject:UIImagePNGRepresentation(asset.thumbImage) forKey:@"yingyezhizhao"];

        
        [self section:2 row:1];
        
    }if([_type isEqualToString:@"2"]){
        
        _image_other = asset.thumbImage;
        
        [user setObject:UIImagePNGRepresentation(asset.thumbImage) forKey:@"zhengshu"];
        
        [self section:3 row:1];
        
    }if([_type isEqualToString:@"3"]){
        
        _image_other_one = asset.thumbImage;
        
        [user setObject:UIImagePNGRepresentation(asset.thumbImage) forKey:@"zhengshuqita"];
        
        [self section:3 row:1];
        
    }
    [user synchronize];
    
}
-(void)creat_ma{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.allowsEditing = false;
    
    picker.sourceType = sourceType;
    
    [self presentViewController:picker animated:true completion:^{
        
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    //  营业执照
    if([_type isEqualToString:@"1"]){
        
        _image = image;
        
        [user setObject:UIImagePNGRepresentation(image) forKey:@"yingyezhizhao"];
        
        [self section:2 row:1];
        
    }
    
    //  证书
    if([_type isEqualToString:@"2"]){
        
        _image_other  = image;
        
        [user setObject:UIImagePNGRepresentation(image) forKey:@"zhengshu"];
        
         [self section:3 row:1];
        
    }
    
    //  证书
    if([_type isEqualToString:@"3"]){
        
        _image_other_one = image;
        
        [user setObject:UIImagePNGRepresentation(image) forKey:@"zhengshuqita"];
        
         [self section:3 row:1];
        
    }
    
    [user synchronize];
    
    [picker dismissViewControllerAnimated:true completion:^{
        
    }];
    
}

#pragma mark tabelview 刷新
-(void)section:(NSInteger )section  row:(NSInteger )row
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:section];
    
    [_TabelView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


#pragma mark section 刷新
-(void)tableviewsection:(NSInteger )section{
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    
    [_TabelView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if(textField.tag == 100){
        
        _MerchantNameString = textField.text;
        
        [user setObject:_MerchantNameString forKey:@"shangjianame"];
        
    }if(textField.tag == 101){
        
        _StoreTypeString = textField.text;
        
        
        
    }if(textField.tag == 102){
        
        _OperatingProductsString = textField.text;
        
        [user setObject:_OperatingProductsString forKey:@"jingyingchanpin"];
        
    }if(textField.tag == 200){
        
        _accounttypeString = textField.text;
        
        [user setObject:_accounttypeString forKey:@"zhanghaoleixing"];
        
    }if(textField.tag == 201){
        
        _accountNameString = textField.text;
        
        [user setObject:_accountNameString forKey:@"zhanghumingcheng"];
        
    }if(textField.tag == 202){
        
        _BankaccountString = textField.text;
        
        if([self checkCardNo:_BankaccountString] == false){
            
            [self MBShow:@"银行账号错误,请重新输入" backview:self.view];
            
            textField.text = @"";
            
            return;
            
        }
        
        [user setObject:_BankaccountString forKey:@"yihangzhanghu"];
        
    }if(textField.tag == 203){
        
        _BankString = textField.text;
        
        [user setObject:_BankString forKey:@"kaihuahang"];
        
    }
    
    [user synchronize];
    
}

#pragma mark 银行卡号
/**
 *  判断银行卡号
 *
 *  @param cardNo 字符串
 *
 *  @return true ? false
 */
- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


#pragma mark 提交申请
-(void)button_click{
    
    
    NSUserDefaults * user= [NSUserDefaults standardUserDefaults];
    
    id image_zhengshu_one = [user objectForKey:@"zhengshu"];
    
    UIImage* image_yes;
    
    if([image_zhengshu_one isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"zhengshu"];
        
        image_yes = [UIImage imageWithData:imageData_yes];
        
        
    }else{
        
        NSString * string_url = image_zhengshu_one;
        
        UIImageView  *  imageView = [[UIImageView alloc]init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
        image_yes = imageView.image;
        
    }
    
    id image_zhengshu_two = [user objectForKey:@"zhengshuqita"];
    
    UIImage* image_no;
    
    if([image_zhengshu_two isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"zhengshuqita"];
        
        image_no = [UIImage imageWithData:imageData_yes];
        
        
    }else{
        
        NSString * string_url = image_zhengshu_two;
        
        UIImageView  *  imageView = [[UIImageView alloc]init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
        image_no = imageView.image;
        
    }
    

    if(_YesOrNo == true){
        
       
        if([ [self getstring:_MerchantNameString] isEqualToString:@""] || [ [self getstring:_StoreTypeString] isEqualToString:@""] || [[ self getstring: _OperatingProductsString] isEqualToString:@""] || [[self getstring:_accounttypeString] isEqualToString:@""] || [[self getstring:_accountNameString] isEqualToString:@""] || [[self getstring:_BankaccountString] isEqualToString:@""] ||[[self getstring:_BankString] isEqualToString:@""] || [self getimage:image_yes] == false  || [self getimage:image_no] == false){
            
            
            [self showHint:@"请填写完整"];
            
            
            
        }else {
            
            //  有营业执照的方法
            [self UPData:@"有"];
        }

        
    }else {
        
        
        if([ [self getstring:_MerchantNameString] isEqualToString:@""] || [ [self getstring:_StoreTypeString] isEqualToString:@""] || [[ self getstring: _OperatingProductsString] isEqualToString:@""] || [[self getstring:_accounttypeString] isEqualToString:@""] || [[self getstring:_accountNameString] isEqualToString:@""] || [[self getstring:_BankaccountString] isEqualToString:@""] ||[[self getstring:_BankString] isEqualToString:@""] || [self getimage:image_yes] == false  || [self getimage:image_no] == false){
            
            
            [self showHint:@"请填写完整"];
            
            
            
        }else {
            
            //  无营业执照的方法
            
            [self UPData:@"无"];
            
        }
        
    }
    
 

}

-(void)UPData:(NSString *)string{
 
    [self MBPhudShow];

   
    NSString * sex = @"";
    
    if([_sexString isEqualToString:@"男"]){
        
        sex = @"0";
        
    }else {
        
        sex = @"1";
        
    }
#warning LPC 2016.9.9 年龄字段 暂时定死 1
    
    NSString * agestring = @"1";
    
#pragma mark 有无营业执照
    NSString * haveString = @"";
    
    if([string isEqualToString:@"有"]){
        
        haveString = @"1";
    
    }else{
     
        haveString = @"0";
        
    }
    
#pragma mark 店铺类型
    
    NSString * type_shop = @"";
    
    if([_StoreTypeString isEqualToString:@"酒店"]){
        
        type_shop = @"1";
    }
    if([_StoreTypeString isEqualToString:@"特产"]){
        
        type_shop = @"3";
    }
    if([_StoreTypeString isEqualToString:@"饭店"]){
        
        type_shop = @"2";
    }
    if([_StoreTypeString isEqualToString:@"小吃"]){
        
        type_shop = @"4";
    }
    
#pragma mark 账号类型
    
    NSString * type_num= @"";
    
    if([_accounttypeString isEqualToString:@"个人"]){
        
        type_num = @"1";
        
    } if([_accounttypeString isEqualToString:@"对公"]){
        
        type_num = @"0";
    }
    
    NSDictionary * dict = @{@"realName": _nameString ,@"idCard":_codeString,@"sex":sex ,@"age":agestring,@"name":_MerchantNameString ,@"shopId":type_shop ,@"businessScope":_OperatingProductsString,@"accountType":type_num,@"accountName":_accountNameString,@"bankCard":_BankaccountString,@"accountBank":_BankString,@"isLicense":haveString};
    
    // holdCardImg 手持身份证  faceCardImg 身份证正面 backCardImg 身份证反面
    
    //上传图片
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];

    NSDictionary * dic_type = @{@"type":@"1"};
    
    
    // 发送UPLOAD请求
    [manager POST:LPCPHOTOUP parameters:dic_type constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传的文件全部拼接到formData
        NSData * eachImageData = UIImageJPEGRepresentation(_image_one, 0.5);
        
        [formData appendPartWithFileData:eachImageData name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
        
        
        NSData * eachImageData_one = UIImageJPEGRepresentation(_image_two, 0.5);
        
        [formData appendPartWithFileData:eachImageData_one name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
        
        
        NSData * eachImageData_two = UIImageJPEGRepresentation(_image_three, 0.5);
        
        [formData appendPartWithFileData:eachImageData_two name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
        
        
        // 在user 中往外取值，保证数据选择过。
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        id idcardyes = [user objectForKey:@"yingyezhizhao"];
        
        UIImage* image_yes;
        
        if([idcardyes isKindOfClass:[NSData class]]){
            
            NSData* imageData_yes = [user objectForKey:@"yingyezhizhao"];
            
             image_yes = [UIImage imageWithData:imageData_yes];
            
            
            
            
        }else{
            
            NSString * string_url = idcardyes;
            
            UIImageView  *  imageView = [[UIImageView alloc]init];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
            
            
            image_yes = imageView.image;
            
        }
        
        
      
        
        

        id image_zhengshu_one = [user objectForKey:@"zhengshu"];
        
        UIImage* image;
        
        if([image_zhengshu_one isKindOfClass:[NSData class]]){
            
            NSData* imageData_yes = [user objectForKey:@"zhengshu"];
            
            image = [UIImage imageWithData:imageData_yes];
            
            
        }else{
            
            NSString * string_url = image_zhengshu_one;
            
            UIImageView  *  imageView = [[UIImageView alloc]init];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
            
            image = imageView.image;
            
        }

        
        id image_zhengshu_two = [user objectForKey:@"zhengshuqita"];
        
        UIImage* image_other;
        
        if([image_zhengshu_two isKindOfClass:[NSData class]]){
            
            NSData* imageData_yes = [user objectForKey:@"zhengshuqita"];
            
            image_other = [UIImage imageWithData:imageData_yes];
            
            
        }else{
            
            NSString * string_url = image_zhengshu_two;
            
            UIImageView  *  imageView = [[UIImageView alloc]init];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:string_url] placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
            
            image_other = imageView.image;
            
        }

        
        
        
        if([string isEqualToString:@"有"]){
            
            NSData * eachImageData_three = UIImageJPEGRepresentation(image_yes, 0.5);
            
            [formData appendPartWithFileData:eachImageData_three name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
            
        }
        
        
        NSData * eachImageData_four = UIImageJPEGRepresentation(image, 0.5);
        
        [formData appendPartWithFileData:eachImageData_four name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
        
        
        NSData * eachImageData_five = UIImageJPEGRepresentation(image_other, 0.5);
        
        [formData appendPartWithFileData:eachImageData_five name:@"file" fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/png"];
        

        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        LPCUPPAWmodel * model = [LPCUPPAWmodel yy_modelWithJSON:dic];

        
        
        if(model.header.status == 0){
            
            
            if(model.data.count > 0){
                
                
                [self upload:dict dataSource:[model.data mutableCopy] type:string];
                
                return ;
                
            }
            
            
            [self MBShow:@"提交失败,请重新提交" backview:self.view];
            
            
            return;
            
        }
        
        
        [self MBShow:[self head:dic] backview:self.view];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [self MBShow:@"服务器繁忙,请重新上传" backview:self.view];
        
        
    }];


    
}
#pragma mark 上传资料文本类型
-(void)upload:(NSDictionary *)dic dataSource:(NSMutableArray *)dataSource type:(NSString *)type{
    
    NSLog(@"%@",dic);
    
    // holdCardImg 手持身份证  faceCardImg 身份证正面 backCardImg 身份证反面 licenseImg 营业执照   otherImg1  其他证件照1  otherImg2 其他证件照2
    NSMutableDictionary * dict = [dic mutableCopy];
    
    NSString * holdCardString = @"" ;
    
    NSString * faceCardString = @"";
    
    NSString * backCardString = @"";
    
    NSString * licenseString = @"";
    
     NSString * other_oneString= @"";
    
     NSString * other_twoString= @"";
    
    // 有营业执照
    if([type isEqualToString:@"有"]){
        
        // 0 手持身份证
        holdCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[0]]];
        // 1 身份证正面
        faceCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[1]]];
        // 2 身份证反面
       backCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[2]]];
        // 3 营业执照
         licenseString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[3]]];
        // 4 其他证书 1
        
        other_oneString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[4]]];
        
        // 4 其他证书 1
        
         other_twoString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[5]]];
        
        
        [dict setObject:holdCardString forKey:@"holdCardImg"];
        
        [dict setObject:faceCardString forKey:@"faceCardImg"];

        [dict setObject:backCardString forKey:@"backCardImg"];
        
        [dict setObject:licenseString forKey:@"licenseImg"];

        [dict setObject:other_oneString forKey:@"otherImg1"];
        
        [dict setObject:other_twoString forKey:@"otherImg2"];

        
        
    }else{
        
        
        
        // 0 手持身份证
        holdCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[0]]];
        // 1 身份证正面
        faceCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[1]]];
        // 2 身份证反面
        backCardString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[2]]];
        
        // 3 其他证书 1
        
        other_oneString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[3]]];
        
        // 4 其他证书 1
        
        other_twoString = [self getstring:[NSString stringWithFormat:@"%@",dataSource[4]]];
        
        
        
        [dict setObject:holdCardString forKey:@"holdCardImg"];
        
        [dict setObject:faceCardString forKey:@"faceCardImg"];
        
        [dict setObject:backCardString forKey:@"backCardImg"];
        
        [dict setObject:other_oneString forKey:@"otherImg1"];
        
        [dict setObject:other_twoString forKey:@"otherImg2"];
        
    }
    
    
    [ZHJQHttpToll GET:LPCRESGINUP parameters:dict success:^(id responseObject) {
       
        NSDictionary *dic_model = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        
        if([[self headdic:dic_model] isEqualToString:@"0"]){
            
            
          [self MBShow:[self head:dic_model] backview:self.view];
            
           [self performSelector:@selector(nest) withObject:self afterDelay:.5];
            
            return ;
        }
        
        [self MBShow:[self head:dic_model] backview:self.view];
    } failure:^(NSError *error) {
        
         [self MBShow:@"服务器繁忙,请重新上传" backview:self.view];
        
    }];
    
}
-(void)nest{
    
      [self.navigationController popToRootViewControllerAnimated:true];
    
}
@end
