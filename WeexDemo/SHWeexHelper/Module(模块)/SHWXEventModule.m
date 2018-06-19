//
//  SHWXEventModule.m
//  WeexDemo
//
//  Created by CSH on 2018/6/15.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWXEventModule.h"
#import "SHWXViewController.h"

@implementation SHWXEventModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(openUrl:callback:))
WX_EXPORT_METHOD(@selector(close:callback:))
WX_EXPORT_METHOD(@selector(setNavBarTitle:callback:))
//同步
//WX_EXPORT_METHOD_SYNC(<#method#>)

- (void)openUrl:(id)paramsJSON callback:(WXModuleKeepAliveCallback)callback{
    
    NSLog(@"%@",paramsJSON);
    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"点击响应" message:paramsJSON delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [ale show];
}

- (void)close:(id)paramsJSON callback:(WXModuleKeepAliveCallback)callback{
    
    NSLog(@"%@",paramsJSON);
//    NSDictionary *paramsDic = [self getDicWithStr:paramsJSON];
    [weexInstance.viewController.navigationController popViewControllerAnimated:YES];
    if (callback) {
        callback(@"", NO);
    }
}

- (void)setNavBarTitle:(id)paramsJSON callback:(WXModuleKeepAliveCallback)callback{
    
    NSLog(@"%@",paramsJSON);
    NSDictionary *paramsDic = [self getDicWithStr:paramsJSON];
    if ( paramsDic && [paramsDic.allKeys containsObject:@"title"]) {
        SHWXViewController *wxController = (SHWXViewController *)weexInstance.viewController;
        wxController.title = paramsDic[@"title"];
    }
    if (callback) {
        callback(@"", NO);
    }
}

- (NSDictionary *)getDicWithStr:(NSString *)str{
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:NSJSONReadingMutableContainers
                                             error:nil];
}

@end
