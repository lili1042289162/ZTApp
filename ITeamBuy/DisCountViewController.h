//
//  DisCountViewController.h
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleOrderViewController.h"
#import "ShopCartOrderInfoTableViewController.h"
@interface DisCountViewController : UIViewController
@property(nonatomic,strong)NSMutableArray*QuanArr;
@property(nonatomic,strong)SaleOrderViewController*delegate;
@property(nonatomic,strong)ShopCartOrderInfoTableViewController*delega;
@end
