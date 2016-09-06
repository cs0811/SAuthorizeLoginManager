//
//  SAuthorizeLoginManager.h
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SAuthorizeLoginChannelType) {
    SAuthorizeLoginChannelType_QQ    = 0,
    SAuthorizeLoginChannelType_WX   ,
    SAuthorizeLoginChannelType_Sina ,
};

typedef NS_ENUM(NSInteger,SAuthorizeLoginType) {
    SAuthorizeLoginType_Success = 0,                // 登录成功
    SAuthorizeLoginType_Failed_UserCancel ,         // 登录失败，用户取消
    SAuthorizeLoginType_Failed_NoNetWork ,          // 登录失败，失去网络链接
    SAuthorizeLoginType_Failed_NoAccessToken ,      // 登录失败，没获取到token
    SAuthorizeLoginType_Failed_UnKnown ,            // 登录失败，未知原因
    SAuthorizeLoginType_Failed_GetUserInfo ,        // 登录失败，获取个人信息失败
    SAuthorizeLoginType_Failed_NoChannel ,          // 登录失败，渠道不存在
    SAuthorizeLoginType_Failed_HandleOpenURLNil ,   // 登录失败，渠道不存在
};

typedef void(^SAuthorizeLoginCompletionBlock)(NSDictionary * dic, SAuthorizeLoginType reusltType);

@interface SAuthorizeLoginManager : NSObject

+ (void)loginWithChanelType:(SAuthorizeLoginChannelType)type completion:(SAuthorizeLoginCompletionBlock)completion;

+ (void)loginHandleOpenURL:(NSURL *)url completion:(SAuthorizeLoginCompletionBlock)completion;

@end
