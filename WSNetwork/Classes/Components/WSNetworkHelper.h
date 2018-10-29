//
//  WSNetworkHelper.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>
#import "WSRequestObject.h"

typedef void (^WSCallBack)(NSDictionary *response, NSError *error);

@interface WSNetworkHelper : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callRequest:(WSRequestObject *)request completion:(WSCallBack)completion;

/**
 取消请求

 @param requestID id
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
