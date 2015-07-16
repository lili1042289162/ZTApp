//
//  DisCountTableViewCell.m
//  ITeamBuy
//
//  Created by anddward on 15/6/8.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "DisCountTableViewCell.h"
@interface DisCountTableViewCell(){
UILabel*disha;
UILabel*dishb;

}
@end
@implementation DisCountTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)buildViews{
self.infoGrup=[ZTSessionView new];
self.infoGrup.topBorder=YES;
self.infoGrup.bottomBorder=YES;
self.infoGrup.borderWidth=1.0;

self.DisCountType=[ZTSessionTitle new];
self.DisCountType.borderWidth=0.5;
self.DisCountType.topBorder=YES;
  

    [self InitLabels:@[@"etime",@"stime",@"tmQuanmc",@"DisCountMoney",@"LimitMoney",@"tmquno"]];
[self.infoGrup addSubViews:@[_etime,_stime,_tmQuanmc,_DisCountMoney,_LimitMoney,_DisCountType,_tmquno]];
[self addSubview:self.infoGrup];

}
-(void)InitLabels:(NSArray*)labels{
    for (NSString*labelName in labels) {
        UILabel*tmpLabe=[UILabel new];
        tmpLabe.font=[UIFont systemFontOfSize:13.0];
        tmpLabe.textColor=[UIColor colorWithHex:0x33333];
        [self setValue:tmpLabe forKey:labelName];
    }
}
-(void)layoutSubviews{
[[[self.tmQuanmc fitSize]setRectMarginLeft:10.0]setRectMarginTop:15.0];
[[[[self.tmquno fitSize]setRectMarginTop:16.0]setRectOnRightSideOfView:self.tmQuanmc]addRectX:5];

[[[[self.DisCountMoney fitSize]setRectMarginLeft:25.0]setRectBelowOfView:self.tmQuanmc]addRectY:10.0];

[[[[[self.stime fitSize]setRectBelowOfView:_tmquno]addRectY:10]  setRectOnRightSideOfView:self.DisCountMoney]addRectX:110];

    [[[[[self.etime fitSize]setRectBelowOfView:_tmquno]addRectY:10]setRectOnRightSideOfView:self.stime]addRectX:2];

[[[[[self.DisCountType fitSize]setScreenWidth] setRectBelowOfView:self.DisCountMoney]addRectY:15.0]setRectHeight:33.0];
[self.infoGrup wrapContents];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
