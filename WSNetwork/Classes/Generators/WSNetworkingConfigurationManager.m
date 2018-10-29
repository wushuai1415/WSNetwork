//
//  WSNetworkingConfigurationManager.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSNetworkingConfigurationManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation WSNetworkingConfigurationManager

+ (instancetype)sharedInstance
{
    static WSNetworkingConfigurationManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSNetworkingConfigurationManager alloc] init];
        sharedInstance.shouldCache = YES;
        sharedInstance.serviceIsOnline = NO;
        sharedInstance.apiNetworkingTimeoutSeconds = 20.0f;
        sharedInstance.cacheOutdateTimeSeconds = 300;
        sharedInstance.cacheCountLimit = 1000;
        sharedInstance.shouldSetParamsInHTTPBodyButGET = YES;
        sharedInstance.HTTPRequestHeaders = @{@"Content-Type":@"application/json; charset=utf-8"};

        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

@end
