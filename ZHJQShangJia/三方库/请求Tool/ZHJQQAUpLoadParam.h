//
//  HXLUpLoadParam.h
//  HVLX_ios20
//
//  Created by 韩保贺 on 16/6/27.
//  Copyright © 2016年 Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHJQQAUpLoadParam : NSObject


@property (nonatomic,strong) NSData *data;          /**< 上传文件的二进制数据 */

@property (nonatomic,copy) NSString *name;          /**< 上传的参数名称 */

@property (nonatomic,copy) NSString *fileName;      /**< 上传到服务器的文件名称 */

@property (nonatomic,copy) NSString *mimeType;      /**< 上传文件的类型 */

@property (nonatomic, strong, ) UIImage *pic;

@end
