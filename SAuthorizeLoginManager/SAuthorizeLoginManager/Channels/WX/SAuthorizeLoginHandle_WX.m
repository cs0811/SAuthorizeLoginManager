//
//  SAuthorizeLoginHandle_WX.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/6.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SAuthorizeLoginHandle_WX.h"
#import "WXApi.h"

static SAuthorizeLoginHandle_WX * wx;
static NSMutableDictionary * _dic;
static AuthorizeLoginCompletionBlock _resultBlock;
static AuthorizeLoginCompletionBlock _handleOpenBlock;

@interface SAuthorizeLoginHandle_WX ()<WXApiDelegate>

@end

@implementation SAuthorizeLoginHandle_WX

+ (BOOL)canUsed {
    return YES;
}

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion {
    wx = [SAuthorizeLoginHandle_WX new];
    _resultBlock = completion;
    _dic = [NSMutableDictionary dictionary];
    [_dic setObject:@"wx" forKey:@"channel"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    [WXApi registerApp:kLogin_WXID withDescription:app_Name];
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }
}

+ (void)loginHandleOpenURL:(NSURL *)url completion:(AuthorizeLoginCompletionBlock)completion {
    [WXApi handleOpenURL:url delegate:wx];
    _handleOpenBlock = completion;
}

#pragma mark WXApiDelegate 
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        if (!temp.code || temp.code.length<=0) {
            _resultBlock(nil,AuthorizeLoginType_Failed_UnKnown);
            _handleOpenBlock(nil,AuthorizeLoginType_Failed_UnKnown);
            return;
        }
        [SAuthorizeLoginHandle_WX getAccess_tokenWithCode:temp.code];
    }
}

+ (void)getAccess_tokenWithCode:(NSString *)code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kLogin_WXID,kLogin_WXSecret,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                NSString * access_token = [dic objectForKey:@"access_token"];
                NSString * openid = [dic objectForKey:@"openid"];
                
                if (!access_token || !openid || access_token.length<=0 || openid.length<=0) {
                    _resultBlock(nil,AuthorizeLoginType_Failed_NoAccessToken);
                    _handleOpenBlock(nil,AuthorizeLoginType_Failed_NoAccessToken);
                }else {
                    [_dic setObject:access_token forKey:@"accessToken"];
                    [SAuthorizeLoginHandle_WX getUserInfoWithToken:access_token openID:openid];
                }
            }
        });
    });
}

+ (void)getUserInfoWithToken:(NSString *)token openID:(NSString *)openId
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
//                self.nickname.text = [dic objectForKey:@"nickname"];
//                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                if (!dic || [dic allValues].count<=0) {
                    _resultBlock(nil,AuthorizeLoginType_Failed_GetUserInfo);
                    _handleOpenBlock(nil,AuthorizeLoginType_Failed_GetUserInfo);
                }else {
                    [_dic addEntriesFromDictionary:dic];
                    _resultBlock(_dic,AuthorizeLoginType_Success);
                    _handleOpenBlock(_dic,AuthorizeLoginType_Success);
                }
            }
        });
        
    });
}

@end
