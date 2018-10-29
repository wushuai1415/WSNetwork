//
//  WSServiceFactory.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>
#import "WSService.h"

@protocol WSServiceFactoryDataSource <NSObject>

/*
 * key为service的Identifier
 * value为service的Class的字符串
 */
- (NSDictionary<NSString *,NSString *> *)servicesKindsOfServiceFactory;

@end

@interface WSServiceFactory : NSObject

@property (nonatomic, weak) id<WSServiceFactoryDataSource> dataSource;

+ (instancetype)sharedInstance;
- (WSService<WSServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
