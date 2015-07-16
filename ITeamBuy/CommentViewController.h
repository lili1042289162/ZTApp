//
//  CommentViewController.h
//  ITeamBuy
//
//  Created by anddward on 15/7/15.
//  Copyright (c) 2015年 TeamBuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCpmcModel.h"
#import "ZTTextContentView.h"
@interface CommentViewController : UIViewController<UITextViewDelegate>
@property(nonatomic,strong)OrderCpmcModel*value;
@property(nonatomic,strong)NSString*father;
@property(nonatomic,strong)ZTTextContentView*comment;
@end
