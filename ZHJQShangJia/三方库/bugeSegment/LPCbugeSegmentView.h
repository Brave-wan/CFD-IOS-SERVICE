//
//  LPCbugeSegmentView.h
//  ZHJQShangJia
//
//  Created by APP on 16/9/6.
//  Copyright © 2016年 曲宗哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol segmentDelegate <NSObject>

- (void)index:(NSInteger)segmentindex type:(NSString *)type;

@end

@interface LPCbugeSegmentView : UIView

-(id)initWithFrame:(CGRect)frame name:(NSMutableArray *)name ;

@property (nonatomic ,strong) NSMutableArray * dataSourceArr;

@property (strong           ) UILabel  * hengLabel      ;

@property (strong           ) UILabel  * bugeLabel      ;

@property (nonatomic ,strong) NSString * bugeString;

@property (strong           ) UILabel  * bugeLabel_one      ;

@property (nonatomic ,strong) NSString * bugeString_one;

@property (strong           ) UILabel  * bugeLabel_two      ;

@property (nonatomic ,strong) NSString * bugeString_two;

@property (strong           ) UILabel  * bugeLabel_three      ;

@property (nonatomic ,strong) NSString * bugeString_three;


@property (nonatomic, strong) id             delegate;

@end
