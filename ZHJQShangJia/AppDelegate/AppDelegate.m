//
//  AppDelegate.m
//  ZHJQShangJia
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "AppDelegate.h"

#import "ZHJQHLoginViewControll.h"

#import "ZHJQHTabBarController.h"

#import "IQKeyboardManager.h"

#import "JPUSHService.h"

#import <AdSupport/AdSupport.h>
#import "JPushModel.h"
#import "JPushShangPinViewController.h"
#import "JPushJiuDianViewController.h"
#import "JPushFandianViewController.h"


#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#import <UserNotifications/UserNotifications.h>

#endif


@interface AppDelegate ()<ZHJQHLoginViewControllDelegate>

{
    UIView * _vc;
    
}

@end

@implementation AppDelegate

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
-(void)rootViewConterller:(UIViewController *)viewcontroller{
    
    self.window.rootViewController = viewcontroller;
}
- (void)dealloc{
    //移除通知
    
    
}

-(void)addView:(UIScrollView *)scrollview{
    
    [self.window addSubview:scrollview];
    
}

-(void)addPage:(UIPageControl *)PageControl{
    
    [self.window addSubview:PageControl];
    
}

-(void)remoView:(UIScrollView *)scrollview{
    
    [scrollview removeFromSuperview];
}

-(void)remoPage:(UIPageControl *)PageControl{
    
    [PageControl removeFromSuperview];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    // 网络指示器
    
    [self Hudinit];
    
    
    //设置键盘样式
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;
    
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    
    manager.enableAutoToolbar = NO;

    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
    
    
    if(launchOptions){
        
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        JPushModel * model = [JPushModel yy_modelWithJSON:userInfo];
       
        if(model.type == 0){
            
            LPCNewsDeleViewController * Vewconroller = [[LPCNewsDeleViewController alloc]init];
            
            Vewconroller.type = @"1";
            
            Vewconroller.detaileID = model.detailId;
            
            Vewconroller.type_root = 1;
            
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:Vewconroller];
            
            [self rootViewConterller:nav];
            
            
        }else {
           
            NSUserDefaults * user = [NSUserDefaults  standardUserDefaults];
            
            if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"2"]){
                
                JPushJiuDianViewController * ViewCntrller = [JPushJiuDianViewController new];
                ViewCntrller.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
                
                ViewCntrller.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
                
                ViewCntrller.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
                
                ViewCntrller.type_root  = 1;
                
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:ViewCntrller];
                
                [self rootViewConterller:nav];
                
                
                //酒店
            }if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"3"]){
                
                JPushFandianViewController * Viewcontroller = [[JPushFandianViewController alloc]init];
                Viewcontroller.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
                
                Viewcontroller.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
                
                Viewcontroller.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
                
                Viewcontroller.type_root = 1;
                
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:Viewcontroller];
                
                [self rootViewConterller:nav];
                
                
                //饭店
            }if([[self getstring:[user objectForKey:@"KEY"]] isEqualToString:@"1"]){
                
                JPushShangPinViewController * jpush  = [[JPushShangPinViewController alloc]init];
                
                jpush.orderCode = [self getstring:[NSString stringWithFormat:@"%lld",model.orderCode]];
                
                jpush.siId = [self getstring:[NSString stringWithFormat:@"%lld",model.siId]];
                
                jpush.goodsType = [self getstring:[NSString stringWithFormat:@"%ld",(long)model.goodsType]];
                
                jpush.type_root = 1;
                
                UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:jpush];
                
                [self rootViewConterller:nav];

                
                //商品
            }

            
            
        }
        
    }else {
        
        
        
        ZHJQHLoginViewControll * loginViewController = [[ZHJQHLoginViewControll alloc] init];
        
        loginViewController.delegate = self;
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        NSString * string_shopId = [user objectForKey:@"shopId"];
        
        if([string_shopId isEqualToString:@""] || string_shopId == nil || [string_shopId isEqualToString:@"<null>"] || [string_shopId isEqualToString:@"(null)"]){
            
            self.window.rootViewController = nav;
            
        }else {
            
            [self  chooseRootViewController:string_shopId];
            
        }
        
    }

    
    return YES;
}
-(void)changeRootViewController:(NSString *)type{
    
    [self chooseRootViewController:type];
    
}

- (void)chooseRootViewController:(NSString *)type{
    
    //设置tabbar
    ZHJQHTabBarController * tabbar = [[ZHJQHTabBarController alloc] init];
    
    tabbar.type = type;
    
    tabbar.tabBar.tintColor = [UIColor whiteColor];
    
    //    tabbar.tabBarItem.titlePositionAdjustment = UIOffsetMake(20, 20);
    
    //    [tabbar.tabBar setTintColor:[UIColor blueColor]];
    //设置tabbar的背景view和颜色
    
    _vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 50)];
    
    _vc.backgroundColor = COLOR(0, 154, 216, 1);
    
    [tabbar.tabBar addSubview:_vc];
    
    //    [tabbar.tabBarItem setValue:[UIColor redColor] forKey:@""];
    
    self.window.rootViewController = tabbar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedIndexChangClick) name:@"indexChang" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedIndexChangeClickHotel) name:@"hotel" object:nil];
    
    
}
/**
 *  删除userId  token  和 shopId
 */
-(void)removeUser{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:@"TOKEN"];
    
    [user removeObjectForKey:@"USERID"];
    
    [user removeObjectForKey:@"shopId"];
    
    [user removeObjectForKey:@"code"];
    
    [user removeObjectForKey:@"IDCARD"];
    
    [user removeObjectForKey:@"IDCARDYES"];

    [user removeObjectForKey:@"Shop_id_LPC"];
    
    [user removeObjectForKey:@"name"];
    
    [user removeObjectForKey:@"sex"];

    [user removeObjectForKey:@"IDCARDNO"];
    
    [user removeObjectForKey:@"yingyezhizhao"];
    
    [user removeObjectForKey:@"zhengshu"];

    [user removeObjectForKey:@"zhengshuqita"];
    
    [user removeObjectForKey:@"shangjianame"];
    
    [user removeObjectForKey:@"dianpuleixing"];
    
    [user removeObjectForKey:@"zhanghaoleixing"];
    
    [user removeObjectForKey:@"zhanghumingcheng"];
    
    [user removeObjectForKey:@"yihangzhanghu"];
    
    [user removeObjectForKey:@"shifouyouyingyezhizhaobiaoshi"];
    
    [user synchronize];
    
    
}
-(void)chageViewController{
    
    ZHJQHLoginViewControll * loginViewController = [[ZHJQHLoginViewControll alloc] init];
    
    loginViewController.delegate = self;
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    self.window.rootViewController = nav;
}

- (void)selectedIndexChangClick{
    
    _vc.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
    
}

- (void)selectedIndexChangeClickHotel{
    
    _vc.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 网络指示器的初始化
/**
 *  网络指示器初始化
 */
-(void)Hudinit{
  
    _hud = [[MBProgressHUD alloc] initWithWindow:self.window];
    
    [self.window addSubview:_hud];
    
    [self hideHud];
    
}
/**
 *  展示hud
 */
- (void)showHud{
    
    _hud.labelText =@"";
    
    [self.window bringSubviewToFront:_hud];
    
    [_hud show:true];
    
}
/**
 *  隐藏hud
 */
- (void)hideHud{
    
     [_hud hide:true];
}

#pragma mark 极光初始化
/**
 *  极光SDK 推送
 */
-(void)JushSDKAllocOptions:(NSDictionary *)launchOptions {
    
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];

    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
   
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
  
     NSLog(@"iOS10及以下系统，收到通知:%@", [self logDic:userInfo]);
    
    if([[UIDevice currentDevice].systemVersion floatValue]<10.0){
       
      // 点击通知进入指定页面
        if (application.applicationState != UIApplicationStateBackground && application.applicationState != UIApplicationStateActive) {
            
            NSNotification *notification =[NSNotification notificationWithName:@"JPush" object:nil userInfo:userInfo];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }
        
        
    }
    
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    //[JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        UIApplication *application = [UIApplication sharedApplication];
        if (application.applicationState != UIApplicationStateBackground && application.applicationState != UIApplicationStateActive) {
            
            NSNotification *notification =[NSNotification notificationWithName:@"JPush" object:nil userInfo:userInfo];
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        }
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
/**
 *   设置极光的别名
 *
 *  @param tags 别名字段
 */
-(void)jPushtags:(NSString *)alias{
    
    [JPUSHService setTags:nil alias:alias callbackSelector:nil object:nil];
}

@end
