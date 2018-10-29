//
//  WSServiceFactory.m
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import "WSServiceFactory.h"

@interface WSServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation WSServiceFactory

+ (instancetype)sharedInstance {
    static WSServiceFactory *serviceFactory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceFactory = [WSServiceFactory new];
    });
    return serviceFactory;
}

#pragma mark - public methods
- (WSService<WSServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    @synchronized (self.dataSource) {
        if (self.serviceStorage[identifier] == nil) {
            self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
        }
        return self.serviceStorage[identifier];
    }
}

#pragma mark - private methods
- (WSService<WSServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier
{
    NSAssert([self.dataSource respondsToSelector:@selector(servicesKindsOfServiceFactory)], @"请实现CTServiceFactoryDataSource的servicesKindsOfServiceFactory方法");
    
    if ([[self.dataSource servicesKindsOfServiceFactory]valueForKey:identifier]) {
        NSString *classStr = [[self.dataSource servicesKindsOfServiceFactory]valueForKey:identifier];
        id service = [[NSClassFromString(classStr) alloc]init];
        NSAssert(service, [NSString stringWithFormat:@"无法创建service，请检查servicesKindsOfServiceFactory提供的数据是否正确"],service);
        NSAssert([service conformsToProtocol:@protocol(WSServiceProtocol)], @"你提供的Service没有遵循CTServiceProtocol");
        return service;
    }else {
        NSAssert(NO, @"servicesKindsOfServiceFactory中无法找不到相匹配identifier");
    }
    
    return nil;
}

#pragma mark - getter

- (NSMutableDictionary *)serviceStorage {
    if (!_serviceStorage) {
        _serviceStorage = @{}.mutableCopy;
    }
    return _serviceStorage;
}

@end
