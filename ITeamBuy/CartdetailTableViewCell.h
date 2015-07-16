//
//  CartdetailTableViewCell.h
//  ITeamBuy
//
//  Created by anddward on 15/6/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
typedef NS_ENUM(NSInteger, DetailCartOrPayNow){
     DetailCartModel = 1,
     DetailPayNowModel = 2,
};

@interface CartdetailTableViewCell : UITableViewCell
@property(nonatomic,strong)ZTImageLoader *ShopCartPic;
@property(nonatomic,strong)UILabel*Producttitle;
@property(nonatomic,strong)UILabel*cima;
@property(nonatomic,strong)UILabel*price;
@property(nonatomic,strong)UILabel*sl;
@property(nonatomic,strong)UIColor*Bordercolor;
@property(nonatomic,assign)BOOL Topborder;
@property(nonatomic,assign)BOOL BottomBorder;
@property(nonatomic,assign)CGFloat BorderWidth;
@property(nonatomic,strong)  UIButton* detailpaybtn;
@property(nonatomic,assign) DetailCartOrPayNow detailmodell;

@property (copy, nonatomic) void (^detailpayactionBlock)(void);//去付款
@property(nonatomic,strong)  UIButton* detailshow;
@property (copy, nonatomic) void (^detailshowactionBlock)(void);//显示
@property(nonatomic,strong)NSString*ttarger;
@end
