//
//  JQTShareSheetViewController.h
//  JQTWander
//
//  Created by yanliang on 17/1/21.
//  Copyright © 2017年 JunQiTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^platformClick)(int platform);

@interface CYShareSheetView : UIView

- (void)platformClicked:(platformClick)platform;

- (void)show;

@end
