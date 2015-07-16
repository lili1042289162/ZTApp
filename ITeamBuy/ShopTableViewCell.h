//
//  ShopTableViewCell.h
//  ZhongTuan
//
//  Created by anddward on 15/5/22.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShopTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel*Shoptitle;
@property(nonatomic,strong)UIColor*Bordercolor;
@property(nonatomic,assign)BOOL Topborder;
@property(nonatomic,assign)BOOL BottomBorder;
@property(nonatomic,assign)CGFloat BorderWidth;
@end
