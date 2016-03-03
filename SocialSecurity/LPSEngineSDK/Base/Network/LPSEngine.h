//
//  LPSEngine.h
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define GBK  CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
// 回调函数类型
typedef void (^ProgressBlock)(NSProgress *uploadProgress);
typedef void (^SuccessWithHeaderBlock)(NSInteger statusCode, NSDictionary *headerDict, NSData *data);
typedef void (^FailureBlock)(NSInteger statusCode, NSError *error);


@interface LPSEngine : NSObject
+ (LPSEngine *)sharedEngine;
/**
 *  post Request
 *
 *  @param path       path
 *  @param parameters parameters
 *  @param progress   ProgressBlock
 *  @param success    SuccessBlock
 *  @param failure    FailureBlock
 */
-(void)POSTWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
           progress:(ProgressBlock)progress
            success:(SuccessWithHeaderBlock)success
            failure:(FailureBlock)failure;

-(void)GETWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
           progress:(ProgressBlock)progress
            success:(SuccessWithHeaderBlock)success
           failure:(FailureBlock)failure;

- (void)setHeaderWithField:(NSString *)field andValue:(NSString *)value;
@end
