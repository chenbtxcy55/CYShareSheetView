//
//  BLUMSocialManager.m
//  BasketBallLeagues
//
//  Created by 小禹宝宝 on 2017/6/4.
//  Copyright © 2017年 kenshin. All rights reserved.
//
//#define kUMENGAppKey  @"5873577ff5ade41f8e000fe3"
#define kUMENGAppKey  @"5861e5daf5ade41326001eab"  //友盟key demo

//微信
#define kWeChatAppSecret @"3baf1193c85774b3fd9d18447d76cab0"
#define kWeChatAppID @"wxdc1e388c3822c80b"
#define kWeChatdirectURL @"http://mobile.umeng.com/social"

//新浪

#define kSinaAppSecret @"04b48b094faeb16683c32669824ebdad"
#define kSinaredirectURL @"https://sns.whalecloud.com/sina2/callback"
#define kSinaAppId     @"3921700954"


#import "CYUMSocialManager.h"

@implementation CYUMSocialManager
+ (void)configShareSDK
{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMENGAppKey];
    
    // 获取友盟social版本号
    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWeChatAppID appSecret:kWeChatAppSecret redirectURL:kWeChatdirectURL];
    // 设置分享到QQ互联的appID
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppId/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppId  appSecret:kSinaAppSecret redirectURL:kSinaredirectURL];
}


+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType info:(NSDictionary *)info {
    [self shareWebPageToPlatformType:platformType url:info[@"shareurl"] thumbImage:info[@"thumbImage"] title:info[@"title"] content:info[@"subtitle"]];
}


//  @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType url:(NSString *)url thumbImage:(id)thumbImage title:(NSString *)title content:(NSString *)content {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象

    // 此处thumbURL 不能为空，为空新浪微博就会报错 应该提供一个固定的缩略图image或url，最好是项目logo
    if (!thumbImage) {
        thumbImage = [UIImage imageNamed:@"logo"];
    }
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:thumbImage];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            if (error.code != 2009) {
                [CYUMSocialManager alertWithError:error];
            }
            
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                [self ks_showToast:@"分享成功哦"];
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

//网页分享
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    
}

+ (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"分享失败，错误码 %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
