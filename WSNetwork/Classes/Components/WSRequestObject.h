//
//  WSRequestObject.h
//  AFNetworking
//
//  Created by ws on 2018/10/25.
//

#import <Foundation/Foundation.h>
#import "WSRequestGenerator.h"

@interface WSRequestObject : NSObject

@property (copy, nonatomic) NSString *serviceIdentifier;
@property (strong, nonatomic) NSDictionary *requestParams;
@property (copy, nonatomic) NSString *methodName;
@property (nonatomic) RequestMethod method;

@end
