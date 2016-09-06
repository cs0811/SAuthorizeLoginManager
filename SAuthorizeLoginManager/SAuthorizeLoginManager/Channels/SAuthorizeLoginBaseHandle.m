//
//  SAuthorizeLoginBaseHandle.m
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import "SAuthorizeLoginBaseHandle.h"

@implementation SAuthorizeLoginBaseHandle

+ (BOOL)canUsed {
    return NO;
}

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion {
    
}

+ (void)loginHandleOpenURL:(NSURL *)url completion:(AuthorizeLoginCompletionBlock)completion {
    
}

@end
