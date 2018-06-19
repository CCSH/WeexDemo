//
//  SHWXImageHandler.m
//  WeexDemo
//
//  Created by CSH on 2018/6/14.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHWXImageHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SHWXImageHandler

#pragma mark WXImgLoaderProtocol
- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock{
    
    if ([url hasPrefix:@"//"]) {
        
        url = [@"http:" stringByAppendingString:url];
    }
    
    return (id<WXImageOperationProtocol>)[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        if (completedBlock) {
            
            completedBlock(image, error, finished);
            
        }
    }];
}

@end
