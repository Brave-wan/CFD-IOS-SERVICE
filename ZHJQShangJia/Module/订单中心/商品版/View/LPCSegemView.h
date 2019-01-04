//
//  LPCSegemView.h
//  ZHJQShangJia
//
//  Created by APP on 16/8/3.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol indextDelegate <NSObject>

- (void)index:(NSInteger )segmentindex type:(NSString *)type;

@end

@interface LPCSegemView : UIView

-(id)initWithFrame:(CGRect)frame name:(NSMutableArray *)name ;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (strong) UILabel  * hengLabel ;

@property (nonatomic, strong) id delegate;

// 角标的集合
@property (nonatomic ,strong) NSMutableArray * title_numLabelArr;

/**
 *  label 的集合
 */
@property (nonatomic ,strong) NSMutableArray * label_dataSoureArr;


@end
