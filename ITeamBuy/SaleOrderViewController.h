//
//  SaleOrderViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/3/6.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTTitleLabel.h"
#import "ZTSessionTitle.h"
#import "ZTProductItem.h"
#import "ZTAddressItem.h"
#import "ZTBuyItem.h"
#import "ZTNumberItem.h"
#import "PurchaseViewController.h"
#import "Address.h"
#import "ZTTextContentView.h"
#import "DisCountView.h"
@interface SaleOrderViewController : UIViewController<UITextViewDelegate,UIApplicationDelegate>
// 导航栏
@property (nonatomic,strong) ZTTitleLabel *titleView;
// 收货信息
@property (nonatomic,strong) ZTProductItem  *productItem;   //产品闲情
@property (nonatomic,strong) ZTNumberItem   *numberItem;  //增减产品数量
@property (nonatomic,strong) ZTAddressItem  *addItem;   // 添加地址
@property (nonatomic,strong) ZTBuyItem      *buyItem;  //立即购买
@property(nonatomic,strong)ZTTextContentView*invoice;  //发票
@property(nonatomic,strong)DisCountView*discountview;  //优惠劵
@property(nonatomic,strong)DisCountView*Tuanbi;  //团币

// data
@property (nonatomic,strong) NSNumber *productId;
@property(nonatomic,strong)Address*reviseaddress;
 @property(nonatomic,copy)NSString*ordernumber;
 @property(nonatomic,strong)NSNumber*cimaid;//尺码id
 @property(nonatomic,strong)NSNumber*buynumbers;

 @property(nonatomic,strong)NSString*Quanmc;
 @property(nonatomic,strong)NSString*Quanzhi;//优惠劵金额
@property(nonatomic,copy) NSString*quanno;
@property(nonatomic,copy)NSString*TBmoney;//团币金额
@property(nonatomic,assign)long rrow;//某个优惠劵
@end
