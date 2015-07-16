//
//  DisCountView.h
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisCountView : UIView
// 个人信息
@property (nonatomic,strong) UILabel* QuanLabel;
@property (nonatomic,strong) UILabel* QuanZhi;
// 位置参数
@property (nonatomic,assign) CGFloat leftPadding;           // 左缩进距离
@property (nonatomic,assign) CGFloat rightPadding;          // 距离右边indicator 的距离
@property (nonatomic,assign) CGFloat indicatorRightPadding; // indicator 距离右边距离
@property (nonatomic,assign) CGFloat borderWidth;           // 边框宽度
@property (nonatomic,strong) UIColor *borderColor;          // 边框颜色

@end
