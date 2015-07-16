//
//  MeBtnview.h
//  ITeamBuy
//
//  Created by anddward on 15/6/29.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MeBtnviewAlignMode){
    ZTIconButtonAlignModeCenterr = 1,
    ZTIconButtonAlignModeLeftt = 2,
};

@interface MeBtnview : UIView
@property (strong,nonatomic) UIImageView *icon;
@property (assign,nonatomic) CGFloat  iconTopGap;
@property (assign,nonatomic) CGFloat  iconContentGap;
@property (assign,nonatomic) CGFloat  bottomLabelMoveDown;
@property (strong,nonatomic) UILabel* labelTop;
@property (strong,nonatomic) UILabel* labelBottom;
@property (assign,nonatomic) MeBtnviewAlignMode alignMode;
@property (assign,nonatomic) BOOL topBorder;
@property (assign,nonatomic) BOOL bottomBorder;
@property (assign,nonatomic) BOOL leftBorder;
@property (assign,nonatomic) BOOL rightBorder;
@property (assign,nonatomic) CGFloat borderWidth;
@property (strong,nonatomic) UIColor* borderColor;
@property(strong,nonatomic)NSString*tagg;
-(void)setTarget:(id)target trigger:(SEL)selector;


@end
