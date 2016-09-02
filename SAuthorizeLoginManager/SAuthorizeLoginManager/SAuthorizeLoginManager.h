//
//  SAuthorizeLoginManager.h
//  SAuthorizeLoginManager
//
//  Created by tongxuan on 16/9/2.
//  Copyright © 2016年 tongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SAuthorizeLoginType) {
    SAuthorizeLoginType_QQ    = 0,
    SAuthorizeLoginType_WX   ,
    SAuthorizeLoginType_Sina ,
};

typedef void(^SAuthorizeLoginCompletionBlock)(NSDictionary * dic);

@interface SAuthorizeLoginManager : NSObject

+ (void)loginWithChanelType:(SAuthorizeLoginType)type completion:(SAuthorizeLoginCompletionBlock)completion;

@end
