//
//  ZHJQHTabBarController.m
//  ZHJQShangJia
//
//  Created by 韩保贺 on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHTabBarController.h"
#import "ZHJQHShopCenterViewController.h"
#import "ZHJQHGoodsViewController.h"
#import "ZHJQHHotelViewController.h"
#import "ZHJQHMealHotelViewController.h"




@interface ZHJQHTabBarController ()

@end

@implementation ZHJQHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

   

    
//    [self setUpChildViewController];
    
}

#pragma mark - 添加所有的子控制器
- (void)setType:(NSString *)type{
    
    _type = type;
    
    ZHJQHRootViewController * mainVC = nil;
    
    NSUserDefaults * user = [NSUserDefaults  standardUserDefaults];
    
    
    
    if ([_type isEqualToString:@"1"]) {
        
        //酒店订单中心
        mainVC = [[ZHJQHHotelViewController alloc] init];
        
        [user setObject:@"2" forKey:@"KEY"];
       
        
    }else if ([_type isEqualToString:@"2"]){
       
        //饭店订单中心
        mainVC = [[ZHJQHMealHotelViewController alloc] init];
        
        [user setObject:@"3" forKey:@"KEY"];
        
       
        
    }else{
        
        
        //商品订单中心
        mainVC = [[ZHJQHGoodsViewController alloc] init];
        
        [user setObject:@"1" forKey:@"KEY"];

       
        
    }
   
    [user synchronize];
    
    [self setUpOneChildViewController:mainVC image:[UIImage imageNamed:@"订单管理"] selectedImage:[UIImage imageNamed:@"订单管理白"] title:nil ];
    
        
    //店铺管理中心
    ZHJQHShopCenterViewController *  myVC = [[ZHJQHShopCenterViewController alloc] init];
    [self setUpOneChildViewController:myVC image:[UIImage imageNamed:@"店铺中心"] selectedImage:[UIImage imageNamed:@"店铺中心白"] title:nil];
    
    
    
}

#pragma mark - 加入tabbar
- (void)setUpOneChildViewController:(UIViewController *)vc
                              image:(UIImage *)image
                      selectedImage:(UIImage *)selectedImage
                              title:(NSString *)title {
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    
    
    //设置导航
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    [self addChildViewController:nav];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
