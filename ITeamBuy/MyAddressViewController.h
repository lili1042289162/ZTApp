//
//  MyAddressViewController.h
//  ZhongTuan
//
//  Created by anddward on 15/2/4.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleOrderViewController.h"
#import "Address.h"
#import "ShopCartOrderInfoTableViewController.h"
//@protocol SaleOrderViewControllerDelegate<NSObject>
//@optional
//-(Address*)sendertags:(Address*)tag;
//@end
@interface MyAddressViewController : UIViewController
@property(nonatomic,strong) SaleOrderViewController* delegate;
@property(nonatomic,strong)ShopCartOrderInfoTableViewController*delega;
@property(nonatomic,copy)NSString*ttag;
@end
