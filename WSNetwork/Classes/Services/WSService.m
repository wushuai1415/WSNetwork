//
//  WSService.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSService.h"

@interface WSService ()

@property (nonatomic, weak, readwrite) id<WSServiceProtocol> child;

@end

@implementation WSService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(WSServiceProtocol)]) {
            self.child = (id<WSServiceProtocol>)self;
        }
    }
    return self;
}

- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName {
    NSString *urlString = nil;
    urlString = [NSString stringWithFormat:@"%@%@", self.apiBaseUrl, methodName];
    return urlString;
}

#pragma mark - getter

- (NSString *)apiBaseUrl {
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

@end
