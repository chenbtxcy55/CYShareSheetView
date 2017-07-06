//
//  BLUMSocialManager.h
//  BasketBallLeagues
//
//  Created by 小禹宝宝 on 2017/6/4.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface CYUMSocialManager : NSObject

/// UMshareSDK登录和分享配置
+ (void)configShareSDK;

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType info:(NSDictionary *)info;
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType;

@end
