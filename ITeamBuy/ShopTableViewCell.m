 //
//  ShopTableViewCell.m
//  ZhongTuan
//
//  Created by anddward on 15/5/22.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=CGRectMake(0, 0, 50, 30);
       _Bordercolor=[UIColor colorWithHex:COL_LINEBREAK];
       [self buildView];
       [self setSelectView];
    }
return  self;
}
-(void)buildView{
self.Shoptitle=[UILabel new];
self.Shoptitle.font=[UIFont systemFontOfSize:14];
self.Shoptitle.textColor=[UIColor colorWithHexTransparent:0x333333];
self.Shoptitle.textColor=[UIColor redColor];
 self.Shoptitle.numberOfLines=0;
     //debug
     self.Shoptitle.text=@"玩命加载中。。。。";
    [self addSubview:self.Shoptitle];

}
-(void)setSelectView{
UIView*bgView=[[UIView alloc]initWithFrame:self.bounds];
 bgView.backgroundColor=[UIColor greenColor];
 //bgView.backgroundColor=[UIColor colorWithHex:0xebebeb];
self.selectedBackgroundView=bgView;
}
-(void)layoutSubviews{
[[self.Shoptitle fitSize]setRectCenterInParent];
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
[super setSelected:selected animated:animated];
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


@end
