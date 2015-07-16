//
//  ShopModel.h
//  ZhongTuan
//
//  Created by anddward on 15/5/20.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Model.h"

@interface ShopModel : Model
@property (copy,nonatomic) NSString* adpic;//店铺图片网址
@property(nonatomic,copy)NSString*shopname; //店名
@property(nonatomic,copy)NSString*tel;//店铺电话
@property(nonatomic,copy)NSString*tgword;
@property(nonatomic,strong)NSNumber*sid;
@property(nonatomic,strong)NSNumber*collects;  //收藏
@property(nonatomic,strong)NSNumber*models;   //商品
@end
