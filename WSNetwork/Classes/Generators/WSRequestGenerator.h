//
//  WSRequestGenerator.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGet = 1,
    RequestMethodPost,
    RequestMethodPut,
    RequestMethodDelete,
};

@interface WSRequestGenerator : NSObject

@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, copy) NSString *path;
@property (nonatomic) RequestMethod method;

@property (nonatomic) BOOL needSession;

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName requestMethod:(RequestMethod)method;

@end
