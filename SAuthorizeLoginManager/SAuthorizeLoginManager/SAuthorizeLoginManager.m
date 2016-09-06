//
//  SAuthorizeLoginManager.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SAuthorizeLoginManager.h"
#import "SAuthorizeLoginBaseHandle.h"
#import "SAuthorizeLoginHandle_QQ.h"


@implementation SAuthorizeLoginManager

+ (void)loginWithChanelType:(SAuthorizeLoginChannelType)type completion:(SAuthorizeLoginCompletionBlock)completion {
    
    NSString * tempType = @"";
    if (type == SAuthorizeLoginChannelType_QQ) {
        tempType = @"QQ";
    }else if (type == SAuthorizeLoginChannelType_WX) {
        tempType = @"WX";
    }else if (type == SAuthorizeLoginChannelType_Sina) {
        tempType = @"Sina";
    }
    Class class = NSClassFromString([NSString stringWithFormat:@"SAuthorizeLoginHandle_%@",tempType]);
    if (![class canUsed]) {
        completion(nil,SAuthorizeLoginType_Failed_NoChannel);
        return;
    }
    
    [class loginCompletion:^(NSDictionary * dic, AuthorizeLoginType resultType){
        completion(dic,(SAuthorizeLoginType)resultType);
    }];
}

+ (void)loginHandleOpenURL:(NSURL *)url completion:(SAuthorizeLoginCompletionBlock)completion {
    if (!url) {
        completion(nil,SAuthorizeLoginType_Failed_HandleOpenURLNil);
        return;
    }
    
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"tencent%@://qzapp/mqzone/0?generalpastboard=1",kLogin_QQID]]) {
        if ([SAuthorizeLoginHandle_QQ canUsed]) {
            [SAuthorizeLoginHandle_QQ loginHandleOpenURL:url completion:^(NSDictionary *dic, AuthorizeLoginType resultType) {
                completion(dic,(SAuthorizeLoginType)resultType);
            }];
        }
    }

}

@end
