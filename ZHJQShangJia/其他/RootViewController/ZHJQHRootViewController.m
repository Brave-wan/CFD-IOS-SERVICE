//
//  ZHJQHRootViewController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "MBProgressHUD+Add.h"
#import "JPushModel.h"
#import "JPushFandianViewController.h"
#import "JPushShangPinViewController.h"
#import "JPushJiuDianViewController.h"
@interface ZHJQHRootViewController ()

@end

@implementation ZHJQHRootViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(iOS7){
        
        self.navigationController.tabBarController.tabBar.translucent = NO;
        
        self.navigationController.navigationBar.translucent = NO;
        
    }
    
    // nav tabbar self.view 颜色
    [self.navigationController.navigationBar setBarTintColor:COLOR(0,154, 218, 1)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedjpush:) name:@"JPush" object:nil];
    
}

-(void)selectedjpush:(NSNotification *)notic{
    
    
    JPushModel * model = [JPushModel yy_modelWithJSON:notic.userInfo];
    if(model.type == 0){
        
        LPCNewsDeleViewController * Vewconroller = [[LPCNewsDeleViewController alloc]init];
        
        Vewconroller.type = @"1";
        
        Vewconroller.detaileID = model.detailId;
        
        [self push:Vewconroller];
        
    }else {
        /*
         @property (nonatomic, copy) NSString *siId;
         
         @property (nonatomic, copy) NSString *type;
         
         @property (nonatomic, copy) NSString *orderCode;
         
         @property (nonatomic, copy) NSString *goodsType;
        
         */
        NSUserDefaults * user = [NSUserDefaults  standardUserDefaults];
        
        if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"2"]){
            
            JPushJiuDianViewController * ViewCntrller = [JPushJiuDianViewController new];
            ViewCntrller.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
            
            ViewCntrller.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
            
            ViewCntrller.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
            
            
            [self push:ViewCntrller];
            
            
            //酒店
        }if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"3"]){
            
            JPushFandianViewController * Viewcontroller = [[JPushFandianViewController alloc]init];
            Viewcontroller.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
            
            Viewcontroller.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
            
            Viewcontroller.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
            
            
            [self push:Viewcontroller];
            
            
            //饭店
        }if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"1"]){
            
            JPushShangPinViewController * jpush  = [[JPushShangPinViewController alloc]init];
            
            jpush.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
            
            jpush.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
            
             jpush.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
            
            
            [self push:jpush];
            
            
            //商品
        }
       
  
        
        
        
        
    }
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"JPush" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  nav 标题
 *
 *  @param title 文本内容
 */
-(void)nav_title:(NSString *)title{
    
    self.navigationItem.title = title;
    
}

/**
 *  返回
 */
-(void)left{
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"dl3_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, left];
        
}

#pragma mark 返回按钮的点击事件
-(void)click{
    
    [self.navigationController popViewControllerAnimated:true];
    
}

/**
 *  push 页面
 *
 *  @param viewcontroller 目标Controller
 */
-(void)push:(UIViewController *)viewcontroller{
    
    viewcontroller.hidesBottomBarWhenPushed = true;
    
    [self.navigationController pushViewController:viewcontroller animated:true];
    
}

/**
 *  self.view 的背景色
 *
 *  @param color 颜色
 */
-(void)backColor:(UIColor *)color{
    
    self.view.backgroundColor = color;
    
}

#pragma mark label 计算高度
/**
 *  label 计算高度
 *
 *  @param contentLabel 当前的label ---- 需要计算的
 *  @param poit         字体大小----- 当前的字体大小-(self)
 *  @param string       text
 *  @param roadLabel    根据某个label 创建的当前的label
 *
 *  @return height/width
 */
-(CGRect)gethegitLabel:(UILabel *)contentLabel sizepoit:(int)poit textString:(NSString *)string newLbale:(UILabel *)roadLabel{
    
    UIFont * tfont = [UIFont systemFontOfSize:poit];
    
    contentLabel.font = tfont;
    
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail ;
    
    contentLabel.text = string ;
    
    contentLabel.numberOfLines = 0;
    
    roadLabel.numberOfLines = 0;
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    
    CGSize size =CGSizeMake(contentLabel.frame.size.width,contentLabel.frame.size.height);
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    contentLabel.frame =CGRectMake(contentLabel.frame.origin.x , contentLabel.frame.origin.y,actualsize.width, actualsize.height);
    
    return contentLabel.frame;
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


/**
 *  网络指示器的展示
 */
-(void)MBPhudShow{
    
    [SHARE_APP showHud];
    
}

/**
 *  网络指示器消失
 */
-(void)MBhudhud{
    
    [SHARE_APP hideHud];
    
}

/**
 *  自定义网络指示器内容
 *
 *  @param string 自定义的内容
 */
-(void)MBShow:(NSString *)string backview:(UIView *)backview{
    
    [SHARE_APP hideHud];
    
    [MBProgressHUD showSuccess:string toView:backview];
    
}

/**
 *  判断字符串是不是<null>
 *
 *  @param string 需要判断的字符串
 *
 *  @return true ? false
 */
-(NSString *)getstring:(NSString *)string{
    
    if([string isEqualToString:@""] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [string isEqual:[NSNull null]] || string == nil){
        
        
        return @"";
    
    }
    
    return string;
    
}


/**
 *  判断iamge是不是<null>
 *
 *  @param image 需要判断的字符串
 *
 *  @return true ? false
 */
-(BOOL)getimage:(UIImage *)image{
    
    if(image == nil || [image isEqual:[NSNull null]] || [image isEqual:nil] )
    {
        
        return false;
        
    }
    
    return true;
}

#pragma mark  headDIc 的结果返回 ----- 已经和后台沟通好，这个字段肯定有值

-(NSString *)headdic:(NSDictionary *)dic{
    
    NSDictionary  * headDic = dic[@"header"];
    
    NSString * status = [NSString stringWithFormat:@"%@",headDic[@"status"]];
    
    return status;
    
}
#pragma mark  headDIc 的结果返回 ----- 已经和后台沟通好，这个字段肯定有值

-(NSString *)head:(NSDictionary *)headdic{
    
    NSDictionary  * headDic = headdic[@"header"];
    
    NSString * status = [NSString stringWithFormat:@"%@",headDic[@"msg"]];
    
    return status;
    
}

@end
