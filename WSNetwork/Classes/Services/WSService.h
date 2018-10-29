//
//  WSService.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>

@protocol WSServiceProtocol <NSObject>

@property (nonatomic, readonly) BOOL isOnline;

@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;

// 为某些Service需要拼凑额外字段到URL处
- (NSDictionary *)extraParmas;

// 设置请求头
- (NSDictionary *)extraHttpHeadParmasWithMethodName:(NSString *)method;

// 提供拦截器集中处理Service错误问题，比如token失效要抛通知等
- (BOOL)shouldCallBackByFailedOnCallingAPI:(NSDictionary *)response;

@end

@interface WSService : NSObject

@property (nonatomic, strong, readonly) NSString *apiBaseUrl;

@property (nonatomic, weak, readonly) id<WSServiceProtocol> child;

// 拼接规则
- (NSString *)urlGeneratingRuleByMethodName:(NSString *)methodName;

@end
