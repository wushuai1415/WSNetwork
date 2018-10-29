//
//  WSNetworkHelper.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSNetworkHelper.h"
#import "WSRequestGenerator.h"
#import "WSNetworkingConfigurationManager.h"
#import <AFNetworking/AFNetworking.h>

#import "NSURLRequest+Params.h"

@interface WSNetworkHelper ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation WSNetworkHelper

#pragma mark - public
+ (instancetype)sharedInstance {
    static WSNetworkHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[WSNetworkHelper alloc] init];
    });
    return helper;
}

- (NSInteger)callRequest:(WSRequestObject *)requestObject completion:(WSCallBack)completion {
    NSString *serviceIdentifier = requestObject.serviceIdentifier;
    NSDictionary *requestParams = requestObject.requestParams;
    NSString *methodName = requestObject.methodName;
    RequestMethod method = requestObject.method;
    
    NSURLRequest *request = [[WSRequestGenerator sharedInstance] generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestMethod:method];
    NSNumber *requestId = [self callApiWithRequest:request completion:completion];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private

// TODO: 发送请求
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request completion:(WSCallBack)completion {
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        
        if (error) {
            NSLog(@"\n=================\n%@\n%@\n%@\n=================", request.URL, request.params, error);
            completion?completion(nil, error):nil;
        } else {
            NSLog(@"\n=================\n%@\n%@\n%@\n=================", request.URL, request.params, responseObject);
            completion?completion(responseObject, nil):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

#pragma mark - getter

- (NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        for (NSString *key in [[WSNetworkingConfigurationManager sharedInstance].HTTPRequestHeaders allKeys]) {
            [_sessionManager.requestSerializer setValue:[WSNetworkingConfigurationManager sharedInstance].HTTPRequestHeaders[key] forHTTPHeaderField:key];
        }
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = [WSNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _sessionManager;
    
}

@end
