//
//  WSRequestGenerator.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSRequestGenerator.h"
#import "WSService.h"
#import "WSServiceFactory.h"
#import "WSNetworkingConfigurationManager.h"
#import <AFNetworking/AFNetworking.h>

#import "NSDictionary+NetworkingMethods.h"
#import "NSURLRequest+Params.h"

@interface WSRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation WSRequestGenerator

#pragma mark - public

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WSRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    [self initialRequestGenerator];
    return self;
}

- (void)initialRequestGenerator {
    
    _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = [WSNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [[WSNetworkingConfigurationManager sharedInstance].HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.httpRequestSerializer setValue:obj forHTTPHeaderField:key];
    }];
}

- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                         requestParams:(NSDictionary *)requestParams
                                            methodName:(NSString *)methodName
                                         requestMethod:(RequestMethod)requestMethod {
    
    NSString *method;
    switch (requestMethod) {
        case RequestMethodGet:
            method = @"GET";
            break;
        case RequestMethodPost:
            method = @"POST";
            break;
        case RequestMethodPut:
            method = @"PUT";
            break;
        case RequestMethodDelete:
            method = @"DELETE";
            break;
        default:
            method = @"POST";
            break;
    }
    
    WSService *service = [[WSServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [service urlGeneratingRuleByMethodName:methodName];
    
    NSDictionary *totalRequestParams = [self totalRequestParamsByService:service requestParams:requestParams];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:nil error:NULL];
    if (![method isEqualToString:@"GET"] && [WSNetworkingConfigurationManager sharedInstance].shouldSetParamsInHTTPBodyButGET) {
        request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:nil error:NULL];
        request.HTTPBody = [[totalRequestParams urlParamsStringSignature:YES] dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:totalRequestParams error:NULL];
    }
    
    if ([service.child respondsToSelector:@selector(extraHttpHeadParmasWithMethodName:)]) {
        NSDictionary *dict = [service.child extraHttpHeadParmasWithMethodName:methodName];
        if (dict) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
            request.params = requestParams;
        }
    }
    
    return request;
}

#pragma mark - private

//根据Service拼接额外参数
- (NSDictionary *)totalRequestParamsByService:(WSService *)service requestParams:(NSDictionary *)requestParams {
    NSMutableDictionary *totalRequestParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    
    if ([service.child respondsToSelector:@selector(extraParmas)]) {
        if ([service.child extraParmas]) {
            [[service.child extraParmas] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [totalRequestParams setObject:obj forKey:key];
            }];
        }
    }
    
    return [totalRequestParams copy];
}


@end
