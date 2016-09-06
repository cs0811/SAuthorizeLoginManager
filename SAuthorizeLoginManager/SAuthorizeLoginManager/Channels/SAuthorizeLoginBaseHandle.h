//
//  SAuthorizeLoginBaseHandle.h
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAuthorizeLoginInfo.h"

typedef NS_ENUM(NSInteger,AuthorizeLoginType) {
    AuthorizeLoginType_Success = 0,             // 登录成功
    AuthorizeLoginType_Failed_UserCancel ,      // 登录失败,用户取消
    AuthorizeLoginType_Failed_NoNetWork ,       // 登录失败,失去网络链接
    AuthorizeLoginType_Failed_NoAccessToken ,   // 登录失败，没获取到token
    AuthorizeLoginType_Failed_UnKnown ,         // 登录失败，未知原因
};

typedef void(^AuthorizeLoginCompletionBlock)(NSDictionary * dic, AuthorizeLoginType resultType);

@interface SAuthorizeLoginBaseHandle : NSObject

+ (BOOL)canUsed;

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion;

+ (void)loginHandleOpenURL:(NSURL *)url completion:(AuthorizeLoginCompletionBlock)completion;


@end
