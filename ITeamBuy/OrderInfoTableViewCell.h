//
//  OrderInfoTableViewCell.h
//  ITeamBuy
//
//  Created by anddward on 15/6/1.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"
#import "ZTTextContentView.h"
@interface OrderInfoTableViewCell : UITableViewCell<UITextFieldDelegate,UIApplicationDelegate>
@property(nonatomic,strong)ZTImageLoader *ShopCartPic;
@property(nonatomic,strong)UILabel*Producttitle;
@property(nonatomic,strong)UILabel*cima;
@property(nonatomic,strong)UILabel*price;
@property(nonatomic,strong)UILabel*sl;
@property(nonatomic,strong)UIColor*Bordercolor;
@property(nonatomic,assign)BOOL Topborder;
@property(nonatomic,assign)BOOL BottomBorder;
@property(nonatomic,assign)CGFloat BorderWidth;
@property(nonatomic,strong)ZTTextContentView*liuyan;
@end
