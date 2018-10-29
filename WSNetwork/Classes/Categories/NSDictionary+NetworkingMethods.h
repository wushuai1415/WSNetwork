//
//  NSDictionary+NetworkingMethods.h
//  AFNetworking
//
//  Created by ws on 2018/10/24.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NetworkingMethods)

- (NSString *)urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)jsonString;
- (NSArray *)transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
