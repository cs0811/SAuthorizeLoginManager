//
//  SAuthorizeLoginHandle_QQ.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SAuthorizeLoginHandle_QQ.h"


static AuthorizeLoginCompletionBlock _resultBlock;

@interface SAuthorizeLoginHandle_QQ ()

@end

@implementation SAuthorizeLoginHandle_QQ

+ (BOOL)canUsed {
    return YES;
}

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion {
    
}

@end
