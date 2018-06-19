//
//  ViewController.m
//  WeexDemo
//
//  Created by CSH on 2018/6/14.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHWXViewController.h"

@interface ViewController ()


// URL属性(用于指定加载js的URL, 一般申明在接口中)
@property (nonatomic, strong) NSURL *url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SHWXViewController *view = [[SHWXViewController alloc]init];
    view.wx_url = [NSURL URLWithString:@"https://statictest.tf56.com/lujing/stageRax/myHelp/index.js?random=-1429796857"];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
