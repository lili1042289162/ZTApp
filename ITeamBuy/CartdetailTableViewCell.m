//
//  CartdetailTableViewCell.m
//  ITeamBuy
//
//  Created by anddward on 15/6/5.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "CartdetailTableViewCell.h"

@implementation CartdetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buidview];
        self.backgroundColor=[UIColor clearColor];
        [self setSelectedView];
    }
    return self;
}
-(void)buidview{
    
    self.ShopCartPic=[ZTImageLoader new];
    self.Producttitle=[UILabel new];
    self.price=[UILabel new];
    self.cima=[UILabel new];
    self.sl=[UILabel new];
    
    self.Producttitle.font = [UIFont systemFontOfSize:12.0];
    self.Producttitle.textColor = [UIColor colorWithHex:0x333333];
    
    
    
    self.cima.font = [UIFont systemFontOfSize:10.0];
    self.cima.textColor = [UIColor colorWithHex:0x333333];
    
    
    self.price.font = [UIFont systemFontOfSize:10.0];
    self.cima.textColor = [UIColor colorWithHex:0x333333];
    
    self.sl.font=[UIFont systemFontOfSize:10.0];
    self.sl.textColor=[UIColor colorWithHex:0x333333];
    
    
    
    self.detailpaybtn=[UIButton new];
    self.detailpaybtn.backgroundColor=[UIColor redColor];
   // [self.detailpaybtn setImage:[UIImage imageNamed:@"ggotopay"] forState:UIControlStateNormal];
    [self.detailpaybtn addTarget:self action:@selector(diddetailTapPayBtnn:) forControlEvents:UIControlEventTouchUpInside];
    self.detailpaybtn.layer.cornerRadius=5.0;
    //[self.paybtn setTitle:@"去付款" forState:UIControlStateNormal];
    
    self.detailshow=[UIButton new];
    self.detailshow.backgroundColor=[UIColor redColor];
    //[self.detailshow setImage:[UIImage imageNamed:@"ggotopay"] forState:UIControlStateNormal];
    [self.detailshow addTarget:self action:@selector(diddetailtapshowaction:) forControlEvents:UIControlEventTouchUpInside];
    self.detailshow.layer.cornerRadius=5.0;

    
    
    
    [self addSubViews:@[self.detailpaybtn,self.detailshow,self.ShopCartPic,self.Producttitle,self.cima,self.price,self.self.sl]];
    
    
}
-(void)layoutSubviews{
    [[[[self.ShopCartPic setRectWidth:75.0]setRectHeight:73.5]setRectMarginTop:7.5]setRectMarginLeft:20];
    [[[[self.Producttitle fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:8.0]setRectMarginTop:15];
    [[[[[self.cima fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:10]setRectBelowOfView:self.Producttitle]addRectY:4];
    [[[self.price fitSize]setRectMarginRight:15]setRectMarginTop:35];
    //[[[[self.sl fitSize]setRectBelowOfView:self.price]addRectY:10]setRectMarginRight:15];
    
    
    switch (_detailmodell) {
        case DetailPayNowModel:
            if ([self.ttarger isEqualToString:@"third"]) {
                [self.detailpaybtn setTitle:@"去评价" forState:UIControlStateNormal];
                [ self.detailpaybtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
                 [[[[self.detailpaybtn setRectWidth:65]setRectHeight:22]setRectMarginBottom:5.0]setRectMarginRight:10.0];
            }else{
                [self.subviews[0] setBackgroundColor:[UIColor clearColor]];}
            break;
            
        default:
        [self.detailpaybtn setTitle:@"确认收货" forState:UIControlStateNormal];
       [ self.detailpaybtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.detailshow setTitle:@"查看物流" forState:UIControlStateNormal ];
        [self.detailshow.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [[[[self.detailpaybtn setRectWidth:65]setRectHeight:22]setRectMarginBottom:5.0]setRectMarginRight:10.0];
            
            [[[[[self.detailshow setRectWidth:65]setRectHeight:22]setRectMarginBottom:5.0]setRectOnLeftSideOfView:self.detailpaybtn]addRectX:-10.0];
            [self.subviews[0] setBackgroundColor:[UIColor clearColor]];
            break;
    }
    
    

    
    
    
    [self.subviews[0]setBackgroundColor:[UIColor clearColor]];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
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
-(void)setSelectedView{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor colorWithHex:0xebebeb];
    self.selectedBackgroundView = bgView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(void)diddetailTapPayBtnn:(UIButton*)btn{
    _detailpayactionBlock();
    
    
}
-(void)diddetailtapshowaction:(UIButton*)sender{
   _detailshowactionBlock();


}
@end
