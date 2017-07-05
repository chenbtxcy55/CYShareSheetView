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
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 25)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor colorWithRed:0.64 green:0.81 blue:0.26 alpha:1] forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor whiteColor]];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}




- (void)share {
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
