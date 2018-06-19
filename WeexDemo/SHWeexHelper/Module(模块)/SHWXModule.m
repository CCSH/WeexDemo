//
//  SHWXModule.m
//  WeexDemo
//
//  Created by CSH on 2018/6/15.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWXModule.h"

@implementation SHWXModule

WX_EXPORT_METHOD(@selector(getAppStoken:callback:))

#pragma mark 获取 token
- (void)getAppStoken:(id)paramsDic callback:(WXModuleKeepAliveCallback)callback{
    
    if (callback) {
        callback(@"5a7418d8e0e0d95065dac68adbf3d5fc_567972351" , NO);
    }
}


@end
