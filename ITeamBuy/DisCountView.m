//
//  DisCountView.m
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "DisCountView.h"
@interface DisCountView(){
UIView*_DisContents;
}
@end
@implementation DisCountView

-(instancetype)init{
    if (self = [super init]) {
        [self initViews];
    }
    return self;
}

#pragma mark - build views

-(void)initViews{
    _DisContents = [UIView new];
    self.QuanLabel = [UILabel new];
    self.QuanZhi = [UILabel new];
    
    NSArray *labels = @[self.QuanLabel,self.QuanZhi];
    for (UILabel* label in  labels) {
        label.textColor = [UIColor colorWithHex:0x919191];
        label.font = [UIFont systemFontOfSize:14.0];
    }
    
    [_DisContents addSubViews:@[self.QuanLabel,self.QuanZhi]];
    [self addSubview:_DisContents];
    
}

-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cotx, _borderColor.CGColor);
    CGContextSetLineWidth(cotx, _borderWidth);
    
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(cotx);
    
    CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(cotx);
    
    CGContextMoveToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)-5.0);
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding, CGRectGetMidY(rect));
    CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-_indicatorRightPadding-5.0, CGRectGetMidY(rect)+5.0);
    CGContextStrokePath(cotx);
}

#pragma mark - layout views
-(void)layoutSubviews{
    [self.QuanLabel sizeToFit];
    [[[self.QuanZhi fitSize] setRectOnRightSideOfView:self.QuanLabel] addRectX:100];
    
    [[[_DisContents wrapContents] setRectCenterVertical] setRectMarginLeft:_leftPadding];
}

@end
