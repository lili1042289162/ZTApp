//
//  OrderInfoTableViewCell.m
//  ITeamBuy
//
//  Created by anddward on 15/6/1.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "OrderInfoTableViewCell.h"

@implementation OrderInfoTableViewCell

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
    self.sl=[UILabel new];
    
    self.Producttitle.font = [UIFont systemFontOfSize:12.0];
    self.Producttitle.textColor = [UIColor colorWithHex:0x333333];
    
    
    
    self.cima.font = [UIFont systemFontOfSize:10.0];
    self.cima.textColor = [UIColor colorWithHex:0x333333];
    
    
    self.price.font = [UIFont systemFontOfSize:10.0];
    self.cima.textColor = [UIColor colorWithHex:0x333333];

self.sl.font=[UIFont systemFontOfSize:10.0];
self.sl.textColor=[UIColor colorWithHex:0x333333];

    
     self.liuyan = [ZTTextContentView new];
    self.liuyan.text =@"选填：给商家留言";
   
    
    self.liuyan.textContainerInset = UIEdgeInsetsMake(10, 30.0, 10, 30.0);
     self.liuyan.editable = YES;
     self.liuyan.scrollEnabled = NO;
     self.liuyan.font = [UIFont systemFontOfSize:10.0];
     self.liuyan.textColor = [UIColor colorWithHex:0x656565];
     self.liuyan.topBorder = YES;
     self.liuyan.bottomBorder = YES;
     self.liuyan.borderWidth = 0.5;
   self.liuyan.keyboardType = UIKeyboardAppearanceDefault;
    self.liuyan.returnKeyType = UIReturnKeyDone;

    [self addSubViews:@[self.ShopCartPic,self.Producttitle,self.cima,self.price,self.self.sl,self.liuyan]];


}
-(void)layoutSubviews{
[[[[self.ShopCartPic setRectWidth:75.0]setRectHeight:73.5]setRectMarginTop:7.5]setRectMarginLeft:20];
[[[[self.Producttitle fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:8.0]setRectMarginTop:15];
[[[[[self.cima fitSize]setRectOnRightSideOfView:self.ShopCartPic]addRectX:10]setRectBelowOfView:self.Producttitle]addRectY:4];
[[[self.price fitSize]setRectMarginRight:10]setRectMarginTop:20];
[[[[self.sl fitSize]setRectBelowOfView:self.price]addRectY:30]setRectMarginRight:15];
[[[[self.liuyan fitSize] setScreenWidth]setRectBelowOfView:self.ShopCartPic]addRectY:4];

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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
