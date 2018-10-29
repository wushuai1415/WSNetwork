//
//  WSTestDataManager.m
//  WSNetwork_Example
//
//  Created by ws on 2018/10/26.
//  Copyright © 2018 ws. All rights reserved.
//

#import "WSTestDataManager.h"

@interface WSTestDataManager () <WSNetManagerCallBackDelegate>

@end

@implementation WSTestDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.delegate = self;
        
        WSRequestObject *requestObject = [WSRequestObject new];
        requestObject.serviceIdentifier = @"DefaultService";
        requestObject.methodName = @"/start/getStartConfig.do";
        requestObject.requestParams = @{};
        requestObject.method = RequestMethodPost;
        
        self.requestObject = requestObject;
    }
    return self;
}

#pragma mark - WSNetManagerCallBackDelegate

- (void)calledRequestSuccess:(WSBaseNetworkManager *)manager {
    NSLog(@"---------------success");
}

- (void)calledRequestFailed:(WSBaseNetworkManager *)manager {
    NSLog(@"---------------failed");
}

@end

