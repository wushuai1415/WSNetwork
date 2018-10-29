//
//  WSBaseNetworkManager.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>
#import "WSRequestObject.h"

@class WSBaseNetworkManager;

typedef NS_ENUM(NSInteger, WSNetApiDataStatus) {
    WSNetApiDataStatusSuccess = 1,
    WSNetApiDataStatusDataError,
    WSNetApiDataStatusNetworkError
};

@protocol WSNetManagerCallBackDelegate <NSObject>

- (void)calledRequestSuccess:(WSBaseNetworkManager *)manager;
- (void)calledRequestFailed:(WSBaseNetworkManager *)manager;

@end

@protocol WSNetManagerInterceptor <NSObject>

- (void)beforeCallRequest:(WSBaseNetworkManager *)manager;
- (void)afterCallRequest:(WSBaseNetworkManager *)manager;

@end

@interface WSBaseNetworkManager : NSObject

@property (nonatomic, weak) id<WSNetManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<WSNetManagerInterceptor> interceptor;

@property (nonatomic, strong) WSRequestObject *requestObject;

@property (nonatomic, readonly) WSNetApiDataStatus responseSuatus;
@property (nonatomic, copy, readonly) NSString *responseMessage;
@property (nonatomic, copy, readonly) NSDictionary *responseData;

- (NSInteger)loadData;
- (void)cancelRequest;

@end
