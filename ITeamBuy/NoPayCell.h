//
//  NoPayCell.h
//  ZhongTuan
//
//  Created by anddward on 15/4/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

typedef NS_ENUM(NSInteger, CartOrPayNow){
CartModel = 1,
PayNowModel = 2,
};

@interface NoPayCell : UITableViewCell
@property (nonatomic,strong) ZTImageLoader *pic;      //图片
@property (nonatomic,strong) UILabel *title;        //标题
@property (nonatomic,strong) UILabel *totolprice;     //总价
@property (nonatomic,strong) UILabel *quantity;        //数量
@property (strong,nonatomic) UIColor* borderColor;
@property(nonatomic,strong)  UIButton* paybtn;
@property (copy, nonatomic) void (^payactionBlock)(void);//去付款
@property(nonatomic,strong)  UIButton* show;
@property (copy, nonatomic) void (^showactionBlock)(void);//显示
@property(nonatomic,assign) CartOrPayNow modell;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (assign,nonatomic) CGFloat indicatorRightPadding;
@property(copy,nonatomic)NSString*tagg;
@property(nonatomic,strong)UILabel*Ordernum;                 //订单号
@property(nonatomic,strong)UILabel*TurePay;                 //实付款
@property(nonatomic,strong)UILabel*statue;                  //状态
@property (nonatomic,strong) ZTImageLoader *toppicone;      //图片
@property (nonatomic,strong) ZTImageLoader *toppictwo;      //图片
@property (nonatomic,strong) ZTImageLoader *toppicthird;      //图片
@property (nonatomic,strong) ZTImageLoader *toppicfour;      //图片
@end
