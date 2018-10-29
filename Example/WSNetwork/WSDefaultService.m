//
//  WSDefaultService.m
//  WSNetwork_Example
//
//  Created by ws on 2018/10/26.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSDefaultService.h"

@implementation WSDefaultService

- (BOOL)isOnline {
    return NO;
}

- (NSString *)offlineApiBaseUrl {
    return @"http://192.168.2.25:9004";
}
- (NSString *)onlineApiBaseUrl {
    return @"";
}

- (NSDictionary *)extraParmas {
    return nil;
}

// 设置请求头
- (NSDictionary *)extraHttpHeadParmasWithMethodName:(NSString *)method {
    return nil;
}

// 提供拦截器集中处理Service错误问题，比如token失效要抛通知等
- (BOOL)shouldCallBackByFailedOnCallingAPI:(NSDictionary *)response {
    return false;
}

@end
