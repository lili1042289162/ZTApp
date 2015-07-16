//
//  ShopCartTableViewCell.m
//  ITeamBuy
//
//  Created by anddward on 15/5/26.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ShopCartTableViewCell.h"

@implementation ShopCartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buidview];
        self.backgroundColor=[UIColor clearColor];
    
    NSLog(@"caocellllllll");
    }
    return self;
}
-(void)buidview{
        self.ShopCartPic=[ZTImageLoader new];
        self.Producttitle=[UILabel new];
        self.price=[UILabel new];
        self.cima=[UILabel new];
    
    self.selectbutton=[UIButton new];
    self.btnSelect=NO;
    [_selectbutton setImage:[UIImage imageNamed:@"cart_sure_num"] forState:UIControlStateNormal];
    [_selectbutton addTarget:self action:@selector(didTapSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    
        self.Producttitle.font = [UIFont systemFontOfSize:12.0];
        self.Producttitle.textColor = [UIColor colorWithHex:0x333333];
    
    
        
        self.cima.font = [UIFont systemFontOfSize:10.0];
        self.cima.textColor = [UIColor colorWithHex:0x333333];
         self.cima.text=@"未定义尺码";
    
     self.price.font = [UIFont systemFontOfSize:10.0];
    self.cima.textColor = [UIColor colorWithHex:0x333333];
    
    
    
    // add sub
    _title = [UILabel new];
    _title.text = @"数量";
    _title.font = [UIFont systemFontOfSize:16.0];
    _addBtn = [UIButton new];
    [_addBtn setImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(didTapAddBtnn:) forControlEvents:UIControlEventTouchUpInside];
    _subBtn = [UIButton new];
    [_subBtn setImage:[UIImage imageNamed:@"btn_sub"] forState:UIControlStateNormal];
    [_subBtn addTarget:self action:@selector(didTapSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    _countLabel = [UITextField new];
    _countLabel.background = [UIImage imageNamed:@"bg_price"];
    _countLabel.enabled = NO;
    _countLabel.textAlignment = NSTextAlignmentCenter;
   
   _addBtn.hidden=YES;
   _subBtn.hidden=YES;
   _countLabel.hidden=YES;
    _kcTag = [UILabel new];
    _kcTag.text = @"x1";
    _kc = [UIButton new];
    // debug
    [_kc setImage:[UIImage imageNamed:@"Alterbtn"] forState:UIControlStateNormal];
        [_kc addTarget:self action:@selector(didTapXGBtn:) forControlEvents:UIControlEventTouchUpInside];
    self .btnStatus=YES;
    
    for (UILabel *label in @[_kcTag]) {
        label.textColor = [UIColor colorWithHex:0x313131];
        label.font = [UIFont systemFontOfSize:15.0];
    }
     [self addSubViews:@[_title,_addBtn,_countLabel,_subBtn,_kcTag,_kc]];
    
        [self addSubViews:@[self.ShopCartPic,self.Producttitle,self.cima,self.price,self.selectbutton]];

}

-(void)layoutSubviews{
    [[[_title fitSize] setRectMarginLeft:150.0] setRectMarginTop:30.0];
    [[[[_subBtn fitSize] setRectMarginLeft:150.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[[_countLabel setRectWidth:45.0] setRectHeight:23.0] setRectOnRightSideOfView:_subBtn] addRectX:5.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[_addBtn fitSize] setRectOnRightSideOfView:_countLabel] addRectX:5.0] setRectBelowOfView:_title] addRectY:10.0];
    [[[[[_kcTag fitSize] setRectOnRightSideOfView:_addBtn] addRectX:10.0] setRectBelowOfView:_addBtn] addRectY:-_kcTag.bounds.size.height+10];
    [[[_kc fitSize] setRectOnRightSideOfView:_kcTag] setRectY:_kcTag.frame.origin.y];
    



[[[[self.selectbutton setRectHeight:15]setRectWidth:15]setRectCenterVertical]setRectMarginLeft:5];
   [[[[self.ShopCartPic setRectWidth:75.0]setRectHeight:73.5]setRectMarginTop:7.5]setRectMarginLeft:26];
   [[[[self.Producttitle fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:8.0]setRectMarginTop:15];
   [[[[[self.cima fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:10]setRectBelowOfView:self.Producttitle]addRectY:4];
   [[[self.price fitSize]setRectMarginRight:10]setRectMarginTop:20];
       [self.subviews[0]setBackgroundColor:[UIColor clearColor]];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)drawRect:(CGRect)rect{
   
        CGContextRef cotx = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(cotx, 1.0);
        //CGContextSetStrokeColorWithColor(cotx, [UIColor colorWithHex:COL_LINEBREAK].CGColor);
         CGContextSetStrokeColorWithColor(cotx, _Bordercolor.CGColor);
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
        
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);

   // CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _Bordercolor.CGColor);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_BorderWidth);
    if (_Topborder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_BorderWidth) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
}

#pragma mark - onClick Events
-(void)didTapAddBtnn:(UIButton*)btn{
    _didTapAddBtn();
}

-(void)didTapSubBtn:(UIButton*)btn{
    _didTapSubBtn();
}
-(void)didTapXGBtn:(UIButton*)btn{

    if ( self.btnStatus  ==YES) {
        _countLabel.hidden=NO;
        _subBtn.hidden=NO;
        _addBtn.hidden=NO;
         [_kc setImage:[UIImage imageNamed:@"Cart_select"] forState:UIControlStateNormal];
    }
    else{
        _countLabel.hidden=YES;
        _subBtn.hidden=YES;
        _addBtn.hidden=YES;
    [_kc setImage:[UIImage imageNamed:@"Alterbtn"] forState:UIControlStateNormal];
        _didTapXGBtn();
    }
    self.btnStatus =!self.btnStatus;
}
-(void)didTapSelectBtn:(UIButton*)sender{
    if (self.btnSelect==NO) {
    
     [self.selectbutton setImage:[UIImage imageNamed:@"cart_sure_num_select"] forState:UIControlStateNormal];
    }else{
     [self.selectbutton setImage:[UIImage imageNamed:@"cart_sure_num"] forState:UIControlStateNormal];
    //_didTapSelectBtn();
    }
     _didTapSelectBtn();
self.btnSelect =!self.btnSelect;
}



@end
