//
//  WSBaseNetworkManager.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSBaseNetworkManager.h"
#import "WSNetworkHelper.h"


@interface WSBaseNetworkManager ()

@property (nonatomic) NSInteger requestId;

@end

@implementation WSBaseNetworkManager

- (NSInteger)loadData {
    [self.interceptor beforeCallRequest:self];
    self.requestId = [[WSNetworkHelper sharedInstance] callRequest:self.requestObject completion:^(NSDictionary *response, NSError *error) {
        if (error) {
            [self.delegate calledRequestFailed:self];
        } else {
            [self.delegate calledRequestSuccess:self];
        }
        [self.interceptor afterCallRequest:self];
    }];
    return self.requestId;
}

- (void)cancelRequest {
    [[WSNetworkHelper sharedInstance] cancelRequestWithRequestID:@(self.requestId)];
}

@end
