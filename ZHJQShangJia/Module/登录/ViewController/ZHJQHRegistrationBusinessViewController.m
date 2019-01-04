//
//  ZHJQHRegistrationBusinessViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/28.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//


#import "ZHJQHRegistrationBusinessViewController.h"
#import "HBHSheetView.h"
#import "LPCBossViewController.h"
#import "LGPhotoAssets.h"
#import "UIButton+WebCache.h"

#import "SDImageCache.h"


@interface ZHJQHRegistrationBusinessViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,LGPhotoPickerViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arrayString;

@property (nonatomic, assign) LGShowImageType showType;

@property (nonatomic, strong) UITextField *genderField;

@end

@implementation ZHJQHRegistrationBusinessViewController

#pragma mark - 懒加载
- (NSArray *)arrayString{
    
    if (!_arrayString) {
        
        _arrayString = [[NSArray alloc] initWithObjects:@"店主姓名",@"店主性别",@"身份证号", nil];
    }
    return _arrayString;
}
#pragma mark 取值
/**
 *  user 存里面的值
 */
-(void)nameobject{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];

    NSString * nameString = [NSString stringWithFormat:@"%@",[user objectForKey:@"name"]];

    _name                 = [self getstring:nameString];


    _sex                  = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"sex"]]];

    _sex_No               = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"code"]]];
    
    
}
#pragma mark - lifteCliy
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航标题颜色
    UIColor * color = [UIColor whiteColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.view.backgroundColor = COLOR(236, 242, 247, 1);
    
    //创建视图
    [self creatUI];
    
    [self nav_title:@"实名注册"];
    
   // [self left];
    
    [self nameobject];
    
    self.navigationItem.hidesBackButton = true;
    
}

- (void)creatUI {
    
   
    
    //创建表
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];

    _tableView.delegate        = self;

    _tableView.dataSource      = self;

    _tableView.tableFooterView = [self creatTableViewFooterView];

    _tableView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:_tableView];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
}

- (UIView *)creatTableViewFooterView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 760)];
    
    view.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
    
    label.text = @"请上传证件照片";
    
    label.textColor = COLOR(253, 88, 95, 1);
    
    [view addSubview:label];
    
    UIView * photoView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 500)];
    
    photoView.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:photoView];
    
    //手持身份证
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
  
    
    UILabel * labelHand = [self creatLabelWith:@"手持身份证"];
    
    labelHand.center = CGPointMake(SCREEN_WIDTH/4, 30);
    
    [photoView addSubview:labelHand];
    
    UIButton * buttonHand = [self creatButtonWithTitle:nil image:[UIImage imageNamed:@"dl3_tianjia"] tag:13];
    
    
    id idcard = [user objectForKey:@"IDCARD"];
    
    if([idcard isKindOfClass:[NSData class]]){
        
        NSData* imageData = [user objectForKey:@"IDCARD"];
        
        UIImage* IDimage = [UIImage imageWithData:imageData];
        
        if([self getimage:IDimage] == true){
            
            [buttonHand setImage:IDimage forState:0];
            
        }
        
    }else{
        
        NSString * string_url = idcard;
        
        [buttonHand sd_setImageWithURL:[NSURL URLWithString:string_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
    
    }
    
    

    [buttonHand addTarget:self action:@selector(head_imageView) forControlEvents:UIControlEventTouchUpInside];
    
    buttonHand.center = CGPointMake(SCREEN_WIDTH / 4, 90);
    
    [photoView addSubview:buttonHand];
    
    //示例
    UILabel * labelPhoto1 = [self creatLabelWith:@"照片示例"];
    
    labelPhoto1.center = CGPointMake(SCREEN_WIDTH / 4 * 3, 30);
    
    [photoView addSubview:labelPhoto1];
    
    UIImageView * iamge = [self creatImageView:[UIImage imageNamed:@"dl3_zhapian1"]];
    
    iamge.center = CGPointMake(SCREEN_WIDTH / 4 *3, 90);
    
    [photoView addSubview:iamge];
    
    //身份证正面
    UILabel * labelPositive = [self creatLabelWith:@"身份证正面"];
    
    labelPositive.center = CGPointMake(SCREEN_WIDTH/4, 190);
    
    [photoView addSubview:labelPositive];
    
    UIButton * buttonPositive = [self creatButtonWithTitle:nil image:[UIImage imageNamed:@"dl3_tianjia"] tag:14];
    
    
    id idcardyes = [user objectForKey:@"IDCARDYES"];
    
    if([idcard isKindOfClass:[NSData class]]){
        
        NSData* imageData_yes = [user objectForKey:@"IDCARDYES"];
        
        UIImage* image_yes = [UIImage imageWithData:imageData_yes];
        
        if([self getimage:image_yes] == true){
            
            [buttonPositive setImage:image_yes forState:0];
            
        }
        
    }else{
        
        NSString * string_url = idcardyes;
        
        [buttonPositive sd_setImageWithURL:[NSURL URLWithString:string_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
    }
    
    
    
    
    [buttonPositive addTarget:self action:@selector(head_up) forControlEvents:UIControlEventTouchUpInside];
    
    buttonPositive.center = CGPointMake(SCREEN_WIDTH / 4, 250);
    
    [photoView addSubview:buttonPositive];
    
    //示例身份证
    UILabel * labelPhoto2 = [self creatLabelWith:@"照片示例"];
    
    labelPhoto2.center = CGPointMake(SCREEN_WIDTH / 4 * 3, 140 + 40 + 10);
    
    [photoView addSubview:labelPhoto2];
    
    UIImageView * iamge2 = [self creatImageView:[UIImage imageNamed:@"dl3_tupian3"]];
    
    iamge2.center = CGPointMake(SCREEN_WIDTH / 4 *3, 250);
    
    [photoView addSubview:iamge2];
    
    //身份证反面
    UILabel * labelReverse = [self creatLabelWith:@"身份证反面"];
    
    labelReverse.center = CGPointMake(SCREEN_WIDTH/4, 190 + 160);
    
    [photoView addSubview:labelReverse];
    
    UIButton * buttonReverse = [self creatButtonWithTitle:nil image:[UIImage imageNamed:@"dl3_tianjia"] tag:15];
    
    
    
    id idcardno = [user objectForKey:@"IDCARDNO"];
    
    if([idcard isKindOfClass:[NSData class]]){
        
        
        NSData* imageData_no = [user objectForKey:@"IDCARDNO"];
        
        UIImage* image_no = [UIImage imageWithData:imageData_no];
        
        if([self getimage:image_no] == true){
            
            [buttonReverse setImage:image_no forState:0];
            
        }
        
    }else{
        
        NSString * string_url = idcardno;
        
        [buttonReverse sd_setImageWithURL:[NSURL URLWithString:string_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dl3_tianjia"]];
        
    }
    
    
    
    
   
    
    [buttonReverse addTarget:self action:@selector(back_head) forControlEvents:UIControlEventTouchUpInside];
    
    buttonReverse.center = CGPointMake(SCREEN_WIDTH / 4, 250 + 160);
    
    [photoView addSubview:buttonReverse];
    
    //示例身份证反面
    UILabel * labelPhoto3 = [self creatLabelWith:@"照片示例"];
    
    labelPhoto3.center = CGPointMake(SCREEN_WIDTH / 4 * 3, 190 + 160);
    
    [photoView addSubview:labelPhoto3];
    
    UIImageView * iamge3 = [self creatImageView:[UIImage imageNamed:@"dl3_tupian2"]];
    
    iamge3.center = CGPointMake(SCREEN_WIDTH / 4 *3, 250 + 160);
    
    [photoView addSubview:iamge3];
    
    //提交按钮下一步
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(15, photoView.frame.origin.y + photoView.frame.size.height + 20, SCREEN_WIDTH - 30, 40);
    
    ViewRadius(button, 10);
    
    [button setBackgroundImage:[UIImage imageNamed:@"dl3_xiayibu"] forState:UIControlStateNormal];
    
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(button_next_click) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTintColor:[UIColor whiteColor]];
    
    [view addSubview:button];
    
    //解释说明
    UILabel * labelFid = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x + 20, button.frame.origin.y + 40 + 10, button.frame.size.width - 20, 20)];
    
    labelFid.text = @"隐私声明：我们承诺此信息仅用于核实商家信息，不做任何其他用途!";
    
    labelFid.textColor = COLOR(176, 180, 181, 1);
    
    labelFid.font = [UIFont systemFontOfSize:13];
    
    labelFid.adjustsFontSizeToFitWidth = YES;
    
    [view addSubview:labelFid];
    
    return view;
}

- (UILabel *)creatLabelWith:(NSString *)title{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    label.text = title;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = COLOR(97, 98, 99, 1);
    
    label.font = [UIFont systemFontOfSize:17];
    
    return label;
    
}
//创建button
- (UIButton *)creatButtonWithTitle:(NSString* )titl image:(UIImage* )image tag:(int)tag{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 0, 80, 80);
    
    [button setImage:image forState:UIControlStateNormal];
    
    button.tag = tag;
    
    [button addTarget:self action:@selector(addPhotoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}
//创建imageView
- (UIImageView *)creatImageView:(UIImage *)image{
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    imageView.image = image;
    
    return imageView;
    
    
}


#pragma mark - sendMessge
//返回上一级
- (void)backButtonClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//添加照片
- (void)addPhotoClick:(id)sender {
    
}

#pragma mark - 表的协议方法

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.text = self.arrayString[indexPath.row];
    
    cell.tintColor = COLOR(97, 98, 99, 1);
    
    UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(95, 11, tableView.frame.size.width - 80, 22 )];
    
    field.placeholder = [NSString stringWithFormat:@"请输入%@",self.arrayString[indexPath.row]];
    
    field.tag = indexPath.row;
    
    field.delegate = self;
    
    [cell.contentView addSubview:field];
    
    if(indexPath.row == 0){
        
        field.text = _name;
        
    }if(indexPath.row == 1){
        
        field.text = _sex;
        
    }if(indexPath.row == 2){
        
        field.text = _sex_No;
    }
    
    if (indexPath.row == 1) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(tableView.frame.size.width - 40, 5, 40, 40);
        
        [button addTarget:self action:@selector(chooseGender) forControlEvents:UIControlEventTouchUpInside];
        
        [button setImage:[UIImage imageNamed:@"dl3_jiantou"] forState:UIControlStateNormal];
        
        [cell.contentView addSubview:button];
        
        field.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}
#pragma mark - textFieldDelegata

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSLog(@"%@  %ld",textField.text,(long)textField.tag);
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
    
    if (textField.tag == 0) {
        //获取到的姓名
        
        _name = textField.text;
        
    
        [user setObject:_name forKey:@"name"];
        
        
    }else if (textField.tag == 1){
        //性别
        
        [user setObject:textField.text forKey:@"sex"];
        
    }else if (textField.tag ==2){
        //身份证号
        
        _sex_No = textField.text;
        
        if([self validateIDCardNumber:textField.text]== true){
            
             [user setObject:_sex_No forKey:@"code"];
            
            
            
        }else{
            
            
            textField.text = @"";
            
            [self MBShow:@"身份证号错误,请重新填写" backview:self.view];
            
        }
        
       
        
    }
    
    [user synchronize];
    
    return YES;
}
#pragma mark 身份证号
/**
 *  判断身份证号
 *
 *  @param identityCard string
 *
 *  @return TRUE ? FALSE 
 */
-(BOOL)validateIDCardNumber:(NSString *)identityCard {
    
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
    
}
- (void)chooseGender {
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithObjects:@"男",@"女", nil];
    
    HBHSheetView * sheetView = [[HBHSheetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withArray:array];
    
    [sheetView setChooseBlock:^(NSString * string) {
        
        _sex = string;
        
        UITextField * textfild = (UITextField *)[self.tableView viewWithTag:1];
        
        textfild.text = string;
        
        [user setObject:_sex forKey:@"sex"];
        
        [user synchronize];
        
    }];
    
    [sheetView show];
    

    
}

#pragma mark 下一步
-(void)button_next_click{
    
    UIButton * button = (UIButton *)[self.tableView viewWithTag:13];
    
    UIImage * buton_image = button.imageView.image;
    
    
    UIButton * button_one = (UIButton *)[self.tableView viewWithTag:14];

    UIImage * buton_image_one = button_one.imageView.image;
    
    UIButton * button_two = (UIButton *)[self.tableView viewWithTag:15];

    UIImage * buton_image_two = button_two.imageView.image;
    
    
    if([_name isEqualToString:@""] || [_sex isEqualToString:@""] || [_sex_No isEqualToString:@""]|| [self getimage:buton_image]== false || [self getimage:buton_image_one]== false  || [self getimage:buton_image_two]== false ){
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您尚未填写完整" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
      
        [alertController addAction:okAction];
        
        
        [self presentViewController:alertController animated:true completion:nil];


        return;
        
    }
    LPCBossViewController  * viewcontroller = [[LPCBossViewController alloc]init];

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    /*
     _name                 = [self getstring:nameString];
     
     
     _sex                  = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"sex"]]];
     
     _sex_No               = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"code"]]];
     */
    
    viewcontroller.nameString               = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"name"]]];
    

    viewcontroller.sexString                = [self getstring:[NSString stringWithFormat:@"%@",[user objectForKey:@"sex"]]];

    viewcontroller.codeString               = _sex_No;

    viewcontroller.image_one                = buton_image;

    viewcontroller.image_two                = buton_image_one;

    viewcontroller.image_three              = buton_image_two;

    [self.navigationController pushViewController:viewcontroller animated:true];
    
}

#pragma mark 手持身份证
-(void)head_imageView{
    
     _type = @"1";
    
    [self showsheet];
    
}

#pragma mark 身份证正面
-(void)head_up{
    
    _type = @"2";
    
    [self showsheet];
    
}
#pragma mark 身份证 反面
-(void)back_head{
    
    _type = @"3";
    
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
    
// 存储图片
    [self userimage:asset.thumbImage];
    
    //  手持身份证
    if([_type isEqualToString:@"1"]){
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:13];
        
        [button setImage:asset.thumbImage forState:0];
        
     

    }
    
    //  身份证正面
    if([_type isEqualToString:@"2"]){
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:14];
        
        [button setImage:asset.thumbImage forState:0];
        

    }
    
    //  身份证反面
    if([_type isEqualToString:@"3"]){
        
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:15];
        
        [button setImage:asset.thumbImage forState:0];
        

    }
    

    
}

#pragma mark 相机
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
    
    //  手持身份证
    if([_type isEqualToString:@"1"]){
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:13];
        
        [button setImage:image forState:0];
        
    }
    
    //  身份证正面
    if([_type isEqualToString:@"2"]){
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:14];
        
        [button setImage:image forState:0];
        
    }
    
    //  身份证反面
    if([_type isEqualToString:@"3"]){
        
        UIButton * button = (UIButton *)[self.tableView viewWithTag:15];
        
        [button setImage:image forState:0];
        
    }
    [self userimage:image];
    
    [picker dismissViewControllerAnimated:true completion:^{
        
        
    }];
    
}

#pragma mark images 的存储
-(void)userimage:(UIImage *)imge{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
    //  手持身份证
    if([_type isEqualToString:@"1"]){
        
     
        [user setObject:UIImagePNGRepresentation(imge) forKey:@"IDCARD"];
    }
    
    //  身份证正面
    if([_type isEqualToString:@"2"]){
        
       
        [user setObject:UIImagePNGRepresentation(imge) forKey:@"IDCARDYES"];
    }
    
    //  身份证反面
    if([_type isEqualToString:@"3"]){
        
        
        [user setObject:UIImagePNGRepresentation(imge) forKey:@"IDCARDNO"];
    }
    
    [user synchronize];
}
@end
