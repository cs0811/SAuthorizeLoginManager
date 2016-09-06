//
//  SAuthorizeLoginHandle_QQ.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SAuthorizeLoginHandle_QQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

static SAuthorizeLoginHandle_QQ * qq;
static TencentOAuth * tencentOAuth;
static AuthorizeLoginCompletionBlock _resultBlock;
static AuthorizeLoginCompletionBlock _handleOpenBlock;


@interface SAuthorizeLoginHandle_QQ ()<TencentSessionDelegate>

@end

@implementation SAuthorizeLoginHandle_QQ

+ (BOOL)canUsed {
    return YES;
}

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion {
    qq = [SAuthorizeLoginHandle_QQ new];
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:kLogin_QQID andDelegate:qq];
    NSArray * permissions= [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t",nil];
    [tencentOAuth authorize:permissions inSafari:NO];
    
    _resultBlock = completion;
}

+ (void)loginHandleOpenURL:(NSURL *)url completion:(AuthorizeLoginCompletionBlock)completion {
    [TencentOAuth HandleOpenURL:url];
    _handleOpenBlock = completion;
}

#pragma mark -- TencentSessionDelegate
//登陆完成调用
- (void)tencentDidLogin
{    
    if (tencentOAuth.accessToken && [tencentOAuth.accessToken length]!=0)
    {
        //  记录登录用户的OpenID、Token以及过期时间
        [tencentOAuth getUserInfo];
    }
    else
    {
        _resultBlock(nil,AuthorizeLoginType_Failed_NoAccessToken);
        _handleOpenBlock(nil,AuthorizeLoginType_Failed_NoAccessToken);
    }
}

//非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {
        _resultBlock(nil,AuthorizeLoginType_Failed_UserCancel);
        _handleOpenBlock(nil,AuthorizeLoginType_Failed_UserCancel);
    }else{
        _resultBlock(nil,AuthorizeLoginType_Failed_UnKnown);
        _handleOpenBlock(nil,AuthorizeLoginType_Failed_UnKnown);
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    _resultBlock(nil,AuthorizeLoginType_Failed_NoNetWork);
    _handleOpenBlock(nil,AuthorizeLoginType_Failed_NoNetWork);
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    _resultBlock(response.jsonResponse,AuthorizeLoginType_Success);
    _handleOpenBlock(response.jsonResponse,AuthorizeLoginType_Success);
}

@end
