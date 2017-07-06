//
//  ViewController.m
//  CYShareSheetView
//
//  Created by 小禹宝宝 on 2017/7/5.
//  Copyright © 2017年 cy55. All rights reserved.
//

#import "ViewController.h"
#import "CYShareSheetView.h"
#import "CYUMSocialManager.h"


static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_WebLink = @"https://bbs.umeng.com/";

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
    
    
    //这里就是要分享的各种参数 ,根据你自己的项目自己设定
    NSString *title = @"标题";  //标题
    NSString *content = @"分享的内容";  //内容
    //    UIImage *shareImage = [UIImage imageNamed:@"fenxiangweibo"]; // 缩略图
    NSString *shareUrl = UMS_WebLink;  //分享链接
    NSDictionary *shareinfo = @{@"title":title,@"subtitle":content,@"thumbImage":UMS_THUMB_IMAGE,@"shareurl":shareUrl};
    self.shareinfo = shareinfo;
}




- (void)share {
    [self.shareView show];
    [self.shareView platformClicked:^(int platform) {
            [CYUMSocialManager shareWebPageToPlatformType:platform info:self.shareinfo];
        }];
}

- (CYShareSheetView *)shareView {
    if (!_shareView) {
        _shareView = [[CYShareSheetView alloc] init];
    }
    return _shareView;
}
@end
