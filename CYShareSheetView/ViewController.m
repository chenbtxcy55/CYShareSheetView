//
//  ViewController.m
//  CYShareSheetView
//
//  Created by 小禹宝宝 on 2017/7/5.
//  Copyright © 2017年 cy55. All rights reserved.
//

#import "ViewController.h"
#import "CYShareSheetView.h"
@interface ViewController ()
@property (nonatomic, strong) CYShareSheetView *shareView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试咯";
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.shareView show];
    
//    [self.shareSheetView platformClicked:^(int platform) {
//        
//        [BLUMSocialManager shareWebPageToPlatformType:platform info:self.shareinfo];
//    }];


}

- (CYShareSheetView *)shareView {
    if (!_shareView) {
        _shareView = [CYShareSheetView new];
    }
    return _shareView;
}
@end
