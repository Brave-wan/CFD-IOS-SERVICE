//
//  HVLXHttpToll.m
//  HVLX_ios20
//
//  Created by 韩保贺 on 16/6/27.
//  Copyright © 2016年 Han. All rights reserved.
//

#import "ZHJQHttpToll.h"
#import "AFNetworking.h"

#define Token_Key @"TOKEN"

#define USERID_KEY   @"USERID"

#define USERDEFAULTS [NSUserDefaults standardUserDefaults]



@implementation ZHJQHttpToll

//GET方法请求
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure {
	
    [self GET:URLString parameters:parameters hud:YES success:success failure:failure];
    
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
        hud:(BOOL)hud
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure {
	
    if (hud) {
//        [SVProgressHUD show] ;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString * Tokenstring =   [USERDEFAULTS objectForKey:Token_Key];
    
    [manager.requestSerializer setValue:Tokenstring forHTTPHeaderField:@"Authorization"];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
            }
        }
        
//        [SHARE_APP hideHud];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            
            failure(error);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
            }
        }
        
//        [SHARE_APP hideHud];
    }];
    
    
    
    
}


//微信支付get方法请求
+ (void)paymentGET:(NSString *)URLString
        parameters:(id)parameters
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure {
	
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (success) {
            success(json);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//post方法请求，发送与编辑通知

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
	
    [self POST:URLString parameters:parameters  hud:YES success:success failure:failure];

    
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
         hud:(BOOL)hud
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure {
	
    if (hud) {
//        [SVProgressHUD show] ;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 发送POST请求
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // NSLog(@"json:%@", json);
        
        if (success) {
            success(json);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
//                [SHARE_APP hideHud];
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSLog(@"%@", error);
        if (failure) {
            failure(error);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
            }
        }
        
//        [SHARE_APP hideHud];
        
    }];
    
}


// post方法请求
+ (void)nonJSONPOST:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
	
    [self nonJSONPOST:URLString parameters:parameters hud:YES success:success failure:failure];
    
}

+ (void)nonJSONPOST:(NSString *)URLString
         parameters:(id)parameters
                hud:(BOOL)hud
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
	
    if (hud) {
//        [SVProgressHUD show] ;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
//    NSString * token = tokenID;
    
//    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString * Tokenstring =   [USERDEFAULTS objectForKey:Token_Key];
    
    [manager.requestSerializer setValue:Tokenstring forHTTPHeaderField:@"Authorization"];
    
    // 发送POST请求
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         id json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        
        if (success) {
            success(json);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
            }
        }
        
//        [SHARE_APP hideHud];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // NSLog(@"%@", error);
        if (failure) {
            failure(error);
            
            if (hud) {
//                [SVProgressHUD dismiss] ;
            }
        }
        
//        [SHARE_APP hideHud];
        
    }];
    
}
/** UPLOAD方法请求 */
+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(ZHJQQAUpLoadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    

    
 NSString * Tokenstring =   [USERDEFAULTS objectForKey:Token_Key];
    
    [manager.requestSerializer setValue:Tokenstring forHTTPHeaderField:@"Authorization"];
    
    // 发送UPLOAD请求
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传的文件全部拼接到formData
       
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            success(responseObject);
       
        }
        
//        [SHARE_APP hideHud];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        if (failure) {
            
            failure(error);
        }
        
//        [SHARE_APP hideHud];
        
    }];
    
}
@end
