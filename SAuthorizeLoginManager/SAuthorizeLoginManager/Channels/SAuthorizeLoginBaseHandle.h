//
//  SAuthorizeLoginBaseHandle.h
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AuthorizeLoginCompletionBlock)(NSDictionary * dic, NSString * error);

@interface SAuthorizeLoginBaseHandle : NSObject

+ (BOOL)canUsed;

+ (void)loginCompletion:(AuthorizeLoginCompletionBlock)completion;

@end
