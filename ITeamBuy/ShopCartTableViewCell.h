//
//  ShopCartTableViewCell.h
//  ITeamBuy
//
//  Created by anddward on 15/5/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageLoader.h"

@interface ShopCartTableViewCell : UITableViewCell
@property(nonatomic,strong)ZTImageLoader *ShopCartPic;
@property(nonatomic,strong)UILabel*Producttitle;
@property(nonatomic,strong)UILabel*cima;
@property(nonatomic,strong)UILabel*price;
@property(nonatomic,strong)UIColor*Bordercolor;
@property(nonatomic,assign)BOOL Topborder;
@property(nonatomic,assign)BOOL BottomBorder;
@property(nonatomic,assign)CGFloat BorderWidth;
//  todo select and number
@property(nonatomic,strong)UIButton*selectbutton;
@property(nonatomic,strong)NSNumber*cartctid;
@property(nonatomic,assign)NSInteger ccont;

// add sub 
@property (nonatomic,strong) UILabel *title;        // 数量标题
@property (nonatomic,strong) UITextField *countLabel;  // 计数框
@property (nonatomic,strong) UIButton *addBtn;      // 加按钮
@property (nonatomic,strong) UIButton *subBtn;      // 减按钮
@property (nonatomic,strong) UILabel *kcTag;        // 数量
@property (nonatomic,strong) UIButton *kc;           // 修改
// call back
@property (nonatomic, assign) BOOL btnStatus; // 状态标识
@property (nonatomic, assign) BOOL btnSelect;  //选中状态
@property (nonatomic,copy) void (^didTapSelectBtn)();
@property (nonatomic,copy) void (^didTapAddBtn)();
@property (nonatomic,copy) void (^didTapSubBtn)();
@property (nonatomic,copy) void (^didTapXGBtn)();

@end
