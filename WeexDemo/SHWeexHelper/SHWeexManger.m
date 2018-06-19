//
//  SHWeexManger.m
//  WeexDemo
//
//  Created by CSH on 2018/6/14.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWeexManger.h"

//自定义帮助类
#import "SHWXImageHandler.h"

//模块
#import "SHWXModule.h"
#import "SHWXEventModule.h"

//组件
#import "SHWXListComponent.h"

@implementation SHWeexManger

#pragma mark - 配置Weex
- (void)configWeex{
    
    //业务配置，非必需
    [WXAppConfiguration setAppGroup:@"WeexDemo"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //初始化SDK环境
    [WXSDKEngine initSDKEnvironment];
    
    //注册协议的实现类，非必需
    [WXSDKEngine registerHandler:[SHWXImageHandler new] withProtocol:@protocol(WXImgLoaderProtocol)];
    
    //注册模块
    [WXSDKEngine registerModule:@"dataBridge" withClass:[SHWXModule class]];
    [WXSDKEngine registerModule:@"actionBridge" withClass:[SHWXEventModule class]];
    
    //注册组件
    [WXSDKEngine registerModule:@"richtext" withClass:[SHWXListComponent class]];

    //设置Log输出等级：调试环境默认为Debug，正式发布会自动关闭。
    [WXLog setLogLevel:WXLogLevelError];
}

@end
