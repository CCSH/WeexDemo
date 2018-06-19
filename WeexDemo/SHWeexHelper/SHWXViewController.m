//
//  SHWXViewController.m
//  WeexDemo
//
//  Created by CSH on 2018/6/14.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWXViewController.h"
#import <WeexSDK/WXSDKInstance.h>
#import <WeexSDK/WXSDKManager.h>
#import <WeexSDK/WXDefine.h>

@interface SHWXViewController ()


//WXSDKInstance 属性
@property(nonatomic, strong) WXSDKInstance *instance;

// weex 视图
@property(nonatomic, strong)UIView *weexView;

@end

@implementation SHWXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //配置weex
    [self configWeex];
}

#pragma mark - 配置weex
- (void)configWeex{
    
    if (self.instance) {
        [self.instance destroyInstance];
    }
    
    // 设置weex
    self.instance = [[WXSDKInstance alloc] init];
    
    // 设置weexInstance所在的控制器
    self.instance.viewController = self;
    
    // 设置weexInstance的frame
    self.instance.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    // 设置weexInstance用于渲染JS的url路径
    [self.instance renderWithURL:self.wx_url options:@{@"bundleUrl":self.wx_url.absoluteString} data:nil];
    
    // 为避免循环引用 声明一个弱指针 self
    __weak typeof(self) weakSelf = self;
    
    // 设置weexInstance创建完的回调
    self.instance.onCreate = ^(UIView *view) {
        
        [weakSelf.weexView removeFromSuperview];
        
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    // 设置weexInstance出错时的回调
    
    self.instance.onFailed = ^( NSError *error) {
        
        NSLog(@"处理失败%@", error);
    };
    
    // 设置weexInstance渲染完成时的回调
    self.instance.renderFinish = ^(UIView *view) {
        
        NSLog(@"渲染完成");
        [weakSelf updateInstanceState:WeexInstanceAppear];
    };
}

#pragma mark - WX状态更新
- (void)updateInstanceState:(WXState)state{
    
    if (self.instance && self.instance.state != state) {
        
        self.instance.state = state;
        
        switch (state) {
            case WeexInstanceAppear:
            {
                 [[WXSDKManager bridgeMgr] fireEvent:self.instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
            }
                break;
            case WeexInstanceDisappear:
            {
                [[WXSDKManager bridgeMgr] fireEvent:self.instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
            }
                break;

            default:
                break;
        }
    }
}

#pragma mark - 界面周期
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self updateInstanceState:WeexInstanceAppear];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self updateInstanceState:WeexInstanceDisappear];
}

#pragma mark - 销毁
- (void)dealloc {
    
    [self.instance destroyInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
