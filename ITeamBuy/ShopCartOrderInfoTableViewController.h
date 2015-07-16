//
//  ShopCartOrderInfoTableViewController.h
//  ITeamBuy
//
//  Created by anddward on 15/5/30.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//
#import "Address.h"
#import <UIKit/UIKit.h>
#import "DisCountView.h"
@interface ShopCartOrderInfoTableViewController : UITableViewController<UITextViewDelegate>
@property(nonatomic,strong)Address*addres;
@property(nonatomic,strong)NSMutableArray*CartProids;
@property(nonatomic,copy)NSString*money;
@property(nonatomic,strong)DisCountView*discountview;  //优惠劵
@property(nonatomic,strong)DisCountView*ZTuanBi;      //中团劵
@property(nonatomic,strong)NSString*tuanbimoney;
@property(nonatomic,strong)NSString*Quanmcb;            //优惠劵描述
@property(nonatomic,strong)NSString*Quanzhib;          //优惠劵金额
@property(nonatomic,copy) NSString*quanhao;
@property(nonatomic,assign)long roww; //选中优惠劵
@end
