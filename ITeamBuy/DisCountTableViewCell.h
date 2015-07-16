//
//  DisCountTableViewCell.h
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSessionView.h"
#import "ZTSessionTitle.h"
@interface DisCountTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel*etime;
@property(nonatomic,strong)UILabel*stime;
@property(nonatomic,strong)UILabel*tmQuanmc;
@property(nonatomic,strong)UILabel*DisCountMoney;
@property(nonatomic,strong)ZTSessionTitle*DisCountType;
@property(nonatomic,strong)UILabel*LimitMoney;
@property(nonatomic,strong)UILabel*tmquno;
@property(nonatomic,strong)ZTSessionView*infoGrup;
@end
