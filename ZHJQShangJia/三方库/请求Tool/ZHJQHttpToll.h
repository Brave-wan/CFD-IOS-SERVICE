//
//  HVLXHttpToll.h
//  HVLX_ios20
//
//  Created by 韩保贺 on 16/6/27.
//  Copyright © 2016年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHJQQAUpLoadParam;
#import "ZHJQQAUpLoadParam.h"
@interface ZHJQHttpToll : NSObject

/**
 *  GET方法请求
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void(^)(id responseObject))success
    failure:(void(^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
        hud:(BOOL)hud
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  微信支付GET方法
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
+ (void)paymentGET:(NSString *)URLString
        parameters:(id)parameters
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
         hud:(BOOL)hud
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数（非字典类型)
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)nonJSONPOST:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

+ (void)nonJSONPOST:(NSString *)URLString
         parameters:(id)parameters
                hud:(BOOL)hud
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;


/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(ZHJQQAUpLoadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;



@end
