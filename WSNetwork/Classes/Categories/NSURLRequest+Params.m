//
//  NSURLRequest+Params.m
//  AFNetworking
//
//  Created by ws on 2018/10/26.
//

#import "NSURLRequest+Params.h"
#import <objc/runtime.h>

const NSString *ParamsKey = @"ParamsKey";

@implementation NSURLRequest (Params)

- (void)setParams:(NSDictionary *)params {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(ParamsKey), params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(ParamsKey));
}

@end
