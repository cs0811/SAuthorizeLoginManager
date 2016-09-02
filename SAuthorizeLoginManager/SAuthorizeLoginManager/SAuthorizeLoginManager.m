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

+ (void)loginWithChanelType:(SAuthorizeLoginType)type completion:(SAuthorizeLoginCompletionBlock)completion {
    
    NSString * tempType = @"";
    if (type == SAuthorizeLoginType_QQ) {
        tempType = @"QQ";
    }else if (type == SAuthorizeLoginType_WX) {
        tempType = @"WX";
    }else if (type == SAuthorizeLoginType_Sina) {
        tempType = @"Sina";
    }
    Class class = NSClassFromString([NSString stringWithFormat:@"SAuthorizeLoginHandle_%@",tempType]);
    if (![class canUsed]) {
        completion(nil,@"渠道不存在");
        return;
    }
    
    [class loginCompletion:^(NSDictionary * dic, NSString * error){
        completion(dic,error);
    }];
}

@end
