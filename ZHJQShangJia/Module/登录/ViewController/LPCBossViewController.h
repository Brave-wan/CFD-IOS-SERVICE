//
//  LPCBossViewController.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/4.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import "ZHJQHRootViewController.h"
#import "QRadioButton.h"

@interface LPCBossViewController : ZHJQHRootViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic ,strong) UITableView * TabelView;

// 营业执照 和 证书 （2 个）的标示
@property (nonatomic ,strong) NSString    * type;

// 营业执照的图片
@property (strong           ) UIImage     * image;

// 第一个证书的图片
@property (strong           ) UIImage     * image_other;

// 第二个证书的图片
@property (strong           ) UIImage     * image_other_one;

// 是否有营业执照
@property (assign           ) BOOL        YesOrNo;

@property (assign           ) BOOL        NoOrYes;


// 商家名称
@property (strong           ) NSString    * MerchantNameString;

// 店铺类型
@property (strong           ) NSString    * StoreTypeString;

// 经营产品
@property (strong           ) NSString    * OperatingProductsString;

// 账号类型
@property (strong           ) NSString    * accounttypeString;

// 账号名称
@property (strong           ) NSString    * accountNameString;

// 银行账号
@property (strong           ) NSString    * BankaccountString;

// 开户行
@property (strong           ) NSString    * BankString;


// 店主名字
@property (strong           ) NSString    * nameString;
// 性别
@property (strong           ) NSString    * sexString;
// 身份证号
@property (strong           ) NSString    * codeString;
// 手持身份证照片
@property (strong           ) UIImage     * image_one;
//身份证正面
@property (strong           ) UIImage     * image_two;
// 身份证反面
@property (strong           ) UIImage     * image_three;



@end
