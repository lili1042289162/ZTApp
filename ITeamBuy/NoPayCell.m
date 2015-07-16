//
//  NoPayCell.m
//  ZhongTuan
//
//  Created by anddward on 15/4/16.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "NoPayCell.h"
#import "ZTImageLoader.h"

@interface NoPayCell(){
    UILabel *_dolla;            //价格符号
    UILabel*_shuliang ;            //数量
    
   }
@end
@implementation NoPayCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 130.0);
        _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        [self buildViews];
       [self setSelectedView];
    }
    return self;
}
#pragma mark - construct

-(void)buildViews{
    self.Ordernum=[UILabel new];
    self.Ordernum.text=@"订单号：8888888888";
    [ self.Ordernum setFont:[UIFont systemFontOfSize:15.0]];
    
    self.statue=[UILabel new];
    self.statue.text=@"状态：待支付";
    [ self.statue setFont:[UIFont systemFontOfSize:12.0]];
    
        _pic = [ZTImageLoader new];
        _title = [[UILabel alloc] init];
        [_title setFont:[UIFont systemFontOfSize:12.0]];
        [_title setTextColor:[UIColor colorWithHexTransparent:0xff333333]];
    
    _totolprice= [[UILabel alloc] init];
    [_totolprice setFont:[UIFont systemFontOfSize:12.0]];
    [_totolprice setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _dolla = [[UILabel alloc] init];
    [_dolla setText:@"￥"];
    [_dolla  setFont:[UIFont systemFontOfSize:13.0]];
    [_dolla setTextColor:[UIColor colorWithHexTransparent:0xffff4978]];
    
    _shuliang = [[UILabel alloc] init];
    [_shuliang setText:@"数量: "];
    [_shuliang  setFont:[UIFont systemFontOfSize:10.0]];
    [_shuliang setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    _quantity = [[UILabel alloc] init];
    [_quantity setFont:[UIFont systemFontOfSize:9.6]];
    [_quantity setTextColor:[UIColor colorWithHexTransparent:0xff9b9b9b]];
    
    
    self.paybtn=[UIButton new];
      self.paybtn.backgroundColor=[UIColor redColor];
       // [self.paybtn setImage:[UIImage imageNamed:@"ggotopay"] forState:UIControlStateNormal];
        [self.paybtn addTarget:self action:@selector(didTapPayBtnn:) forControlEvents:UIControlEventTouchUpInside];
        self.paybtn.layer.cornerRadius=5.0;
        //[self.paybtn setTitle:@"去付款" forState:UIControlStateNormal];
    
    self.show=[UIButton new];
    [self.show addTarget:self action:@selector(didtapshowaction:) forControlEvents:UIControlEventTouchUpInside];
    self.show.layer.cornerRadius=5.0;
    //[self.paybtn setTitle:@"去付款" forState:UIControlStateNormal];

    
    
    self.TurePay=[[UILabel alloc]init];
    self.TurePay.text=@"实际付款￥000";
    [self.TurePay  setFont:[UIFont systemFontOfSize:13.0]];
    [self.TurePay setTextColor:[UIColor blackColor]];

   
   
   //多图
    self.toppicone=[ZTImageLoader new];
    self.toppicone.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backloding"]];
    
    self.toppictwo=[ZTImageLoader new];
    self.toppictwo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backloding"]];
    
    self.toppicthird=[ZTImageLoader new];
    self.toppicthird.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backloding"]];
    
    self.toppicfour=[ZTImageLoader new];
    self.toppicfour.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backloding"]];

   
        [self addSubViews:@[self.show,self.statue ,self.TurePay,self.paybtn,_pic,self.Ordernum, _title, _dolla, _totolprice,_shuliang,_quantity,self.toppicone,self.toppictwo,self.toppicthird,self.toppicfour]];
    
}

-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}

#pragma mark - layout

-(void)layoutSubviews{
    self.paybtn.backgroundColor=[UIColor redColor];
    [self.paybtn setTitle:@"售后" forState:UIControlStateNormal];
    [self.paybtn .titleLabel setFont:[UIFont systemFontOfSize:12]];
        [[[self.Ordernum fitSize]setRectMarginLeft:7.0]setRectMarginTop:3.0];
        [[[self.statue fitSize]setRectMarginRight:17] setRectMarginTop:10.0];
    [[[self.TurePay fitSize]setRectMarginBottom:5.0]setRectMarginLeft:10.0];
        [[[[self.paybtn setRectWidth:65]setRectHeight:22]setRectMarginBottom:5.0]setRectMarginRight:10.0];
    if ([self.tagg isEqualToString:@"first"]) {
        [self.paybtn setTitle:@"去付款" forState:UIControlStateNormal];

    }
    if ([self.tagg isEqualToString:@"two"]) {
        [self.paybtn setTitle:@"确认收货" forState:UIControlStateNormal];
         self.show.backgroundColor=[UIColor redColor];
    [self.show setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.show .titleLabel setFont:[UIFont systemFontOfSize:12]];
         [[[[[self.show setRectWidth:65]setRectHeight:22]setRectMarginBottom:5.0]setRectOnLeftSideOfView:self.paybtn]addRectX:-10.0];
    } if ([self.tagg isEqualToString:@"third"]) {
        [self.paybtn setTitle:@"去评价" forState:UIControlStateNormal];
    }
    
    
    switch (_modell) {
        case PayNowModel:
            [[[[_pic setRectWidth:75.0] setRectHeight:73.5] setRectMarginTop:27.5] setRectMarginLeft:7.5];
            
            [[[[_title fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:35.0];
            [[[[_dolla fitSize] setRectOnRightSideOfView:_pic] addRectX:10.0] setRectMarginTop:60.0];
            [[[_totolprice fitSize] setRectOnRightSideOfView:_dolla]setRectMarginTop:60.0];
            [[[ _shuliang fitSize] setRectMarginTop:60.0] setRectMarginRight:80.0];
            
            [[[_quantity fitSize] setRectMarginTop:60.0] setRectOnRightSideOfView:_shuliang];
            [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
            break;
            
        default:
         [[[[self.toppicone setRectWidth:65]setRectHeight:65]setRectMarginTop:27.5] setRectMarginLeft:12];
        [[[[[self.toppictwo setRectWidth:65]setRectHeight:65]setRectMarginTop:27.5]
       setRectOnRightSideOfView:self.toppicone]addRectX:12];
            [[[[[self.toppicthird setRectWidth:65]setRectHeight:65]setRectMarginTop:27.5]setRectOnRightSideOfView:self.toppictwo]addRectX:12];
          [[[[[self.toppicfour setRectWidth:65]setRectHeight:65]setRectMarginTop:27.5]setRectOnRightSideOfView:self.toppicthird]addRectX:12];
            [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
            break;
    }


}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    
    CGContextBeginPath(cotx);
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
    CGContextSetLineWidth(cotx, 0.5*[UIScreen mainScreen].scale*_borderWidth);

    if (_topBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    if (_bottomBorder) {
        CGContextBeginPath(cotx);
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
}

-(void)didTapPayBtnn:(UIButton*)btn{
    _payactionBlock();
}
-(void)didtapshowaction:(UIButton*)sender{
_showactionBlock();
}


@end
