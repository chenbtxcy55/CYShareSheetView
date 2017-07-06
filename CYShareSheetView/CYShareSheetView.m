//
//  JQTShareSheetViewController.m
//  JQTWander
//
//  Created by yanliang on 17/1/21.
//  Copyright © 2017年 JunQiTech. All rights reserved.
//

#import "CYShareSheetView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UIColor+JCKit.h"

#define CYScreenWidth         ([UIScreen mainScreen].bounds.size.width)
#define CYScreenHeight         ([UIScreen mainScreen].bounds.size.height)

#define bgHeight 130
#define botlineY 93
#define cancelBtnX 25
#define cancelBtnHeight 18
#define btnHeight 79
#define btnY 15
#define imageW 39
@interface CYShareSheetView()
@property (nonatomic, copy)platformClick platform;
@property (nonatomic, strong) UIView *shadeView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CYShareSheetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];

        self.frame = CGRectMake(0, 0 , CYScreenWidth, CYScreenHeight);

        [window addSubview:self];
        self.hidden = YES;
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    CGFloat height = bgHeight;
    //
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [topView setBackgroundColor:[UIColor jc_colorWithHexString:@"121212" alpha:0.3]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [topView addGestureRecognizer:tap];
    [self addSubview:topView];
    self.shadeView = topView;
    //
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, height)];
    bgView.backgroundColor = [UIColor jc_colorWithHexString:@"efefef" alpha:1];
    [bgView setAlpha:1];
    [self addSubview:bgView];
    self.backgroundView = bgView;
    //

    //

    CGFloat lineY = botlineY;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, lineY, self.bounds.size.width, 0.5)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
        [bgView addSubview:line];
    
    NSArray *nameArray = @[@"微信",@"朋友圈",@"新浪微博"];
    NSArray *iconArray = @[@"fenxiangweixin", @"fenxiangpengyouquan",@"fenxiangweibo"];
    
    
    
    CGFloat btnwidth = CYScreenWidth/3;

    for (int i = 0; i < nameArray.count; i++) {
        UIButton *btn = [self makeButton:nameArray[i] withImage:iconArray[i] withFrame:CGRectMake(btnwidth*(i%3),btnY, btnwidth, btnHeight) withTag:1000+i];
        [bgView addSubview:btn];
    }
    
    //
    CGFloat cancelBtnH = cancelBtnHeight;
    CGFloat cancelBtnmargin = cancelBtnX;

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(cancelBtnmargin, lineY + (height - lineY - cancelBtnH)/2 , CYScreenWidth-(cancelBtnmargin*2), cancelBtnH)];
    [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor jc_colorWithHexString:@"6c6c6c" alpha:1] forState:UIControlStateNormal];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    cancelBtn.layer.cornerRadius = 6.0;
//    cancelBtn.backgroundColor = [UIColor jc_colorWithHexString:@"dcdcdc" alpha:1];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
    
}

- (UIButton *)makeButton:(NSString *)name withImage:(NSString *)image withFrame:(CGRect)aFrame withTag:(int)nTag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:aFrame];
    [button setBackgroundColor:[UIColor jc_colorWithHexString:@"#efefef" alpha:.1f]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *downImage = [self createImageWithColor:[UIColor jc_colorWithHexString:@"#efefef" alpha:.1f] size:aFrame.size];
    [button setBackgroundImage:downImage forState:UIControlStateHighlighted];
    [button setTag:nTag];
    //
    CGFloat btnwidth = CYScreenWidth/3;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((btnwidth - 39)/2, 0, imageW, imageW)];
    imageView.image = [UIImage imageNamed:image];
    [button addSubview:imageView];
    //
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 39+8, button.bounds.size.width, 12)];
    [nameLabel setText:name];
    nameLabel.textColor = [UIColor jc_colorWithHexString:@"6c6c6c" alpha:1];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setFont:[UIFont systemFontOfSize:12]];
    [button addSubview:nameLabel];
    
    return button;
}

- (void)cancelBtnClick:(UIButton *)btn
{
    [self dismiss];
}

- (void)buttonClick:(UIButton *)btn
{
    int index = ((int)(btn.tag)-1000);
    int platform = [self platformName:index];
    
    if (self.platform) {
        self.platform(platform);
    }
    [self dismiss];
}

- (void)platformClicked:(platformClick)platformClicked
{
    self.platform = platformClicked;
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self dismiss];
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        // 设置整个view弹出来以后的位置（最终位置）
        self.shadeView.alpha = 0.5f;
        self.hidden = NO;
        self.backgroundView.frame = CGRectMake(0, self.bounds.size.height-bgHeight, self.bounds.size.width, bgHeight);
        
    }completion:^(BOOL finished) {
        self.shadeView.alpha = 1.0f;

    }];
    
}

- (void)dismiss
{
    
    [UIView animateWithDuration:0.3f animations:^{
        //整个View的初始位置，
        self.shadeView.alpha = 0.1f;
self.backgroundView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgHeight);
    } completion:^(BOOL finished) {
        self.shadeView.alpha = 0.f;
        self.hidden = YES;
        [self removeFromSuperview];
        
    }];
}

#pragma mark-
#pragma mark -- share

- (int)platformName:(int)index
{
    if (index == 0) {
        return UMSocialPlatformType_WechatSession;
    }else if (index == 1) {
        return UMSocialPlatformType_WechatTimeLine;
    }else {
        return UMSocialPlatformType_Sina;
    }
}

#pragma mark-
#pragma mark--helper
- (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize {
    CGRect rect=CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
