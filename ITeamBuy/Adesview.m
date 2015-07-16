//
//  Adesview.m
//  ZhongTuan
//
//  Created by anddward on 15/5/12.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import "Adesview.h"

@interface Adesview(){
    id delegate;
    SEL triggerMethod;
}
@end
@implementation Adesview
-(instancetype)initWithFrame:(CGRect)frame Withpicurl:(NSString*)picurl{
    
    

    self = [super initWithFrame:frame];
    if (self) {
        [self buildViews];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapButton:)];
        [self addGestureRecognizer:gesture];
        // _borderColor = [UIColor colorWithHex:COL_LINEBREAK];
        self.backgroundColor = [UIColor whiteColor];
        [self.pic setImageFromUrl:picurl];
        self.pic.frame=frame;
        self.backgroundColor = [UIColor colorWithHexTransparent:0xffeeeeee];
    }
    return self;
}

-(void)buildViews{
    
    _pic=[ZTImageLoader new];
    _pic.backgroundColor=[UIColor whiteColor];
    [self addSubview:_pic];
    
}

#pragma mark - public methods

-(void)setTarget:(id)target trigger:(SEL)selector{
    delegate = target;
    triggerMethod = selector;
}
#pragma mark button click event

-(void)didTapButton:(UITapGestureRecognizer*)recognizer{
 //用来判断是否有以某个名字命名的方法(被封装在一个selector的对象里传递)
    if ([delegate respondsToSelector:triggerMethod]) {
        [delegate performSelector:triggerMethod withObject:self afterDelay:0];
    }
}



@end
