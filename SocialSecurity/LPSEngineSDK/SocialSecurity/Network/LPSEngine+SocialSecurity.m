//
//  LPSEngine+SocialSecurity.m
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSEngine+SocialSecurity.h"
#import "LPSSocialSecurityContext.h"

#define kSSVerificationCode @"https://wssb6.szsi.gov.cn/NetApplyWeb/CImages"
#define kSSLogin @"https://wssb6.szsi.gov.cn/NetApplyWeb/personacctoutResult.jsp"

@implementation LPSEngine (SocialSecurity)
-(void)getSocialSecurityVerificationCodeWithSuccess:(void(^)(UIImage *image))success
                                            failure:(FailureBlock)failure{
    [self SocialSecurityGetWithPath:kSSVerificationCode parameters:nil progress:^(NSProgress *uploadProgress) {
    } success:^(NSInteger statusCode, NSDictionary *headerDict, NSData *data) {
        [SOCIALSECURITY_CONTEXT setCookieString:headerDict];
        UIImage *image = [[UIImage alloc] initWithData:data];
        success(image);
    } failure:^(NSInteger statusCode, NSError *error) {
        failure(statusCode, error);
    }];
}

-(void)loginWitherificationCode:(NSString *)code
                        Success:(void(^)(NSString *htmlString))success
                        failure:(FailureBlock)failure{
    NSDictionary *parameters = @{ @"PSINPUT":code ? :@"",
                                  @"bacode":@"633436431",
                                      @"id":@"421123198912247213"
                                  };
    [self SocialSecurityPostWithPath:kSSLogin parameters:parameters progress:^(NSProgress *uploadProgress) {
    } success:^(NSInteger statusCode, NSDictionary *headerDict, NSData *data) {
        NSString *htmlString = [[NSString alloc] initWithData:data encoding:GBK];
        success(htmlString);
    } failure:^(NSInteger statusCode, NSError *error) {
        failure(statusCode, error);
    }];
}
-(void)SocialSecurityPostWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
           progress:(ProgressBlock)progress
            success:(SuccessWithHeaderBlock)success
            failure:(FailureBlock)failure{
    
    [self setHeaderWithField:@"Cookie" andValue:SOCIALSECURITY_CONTEXT.cookie];
    
    [self POSTWithPath:path parameters:parameters progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(NSInteger statusCode, NSDictionary *headerDict, NSData *data) {
        success(statusCode,headerDict,data);
    } failure:^(NSInteger statusCode, NSError *error) {
        failure(statusCode, error);
    }];
}

-(void)SocialSecurityGetWithPath:(NSString *)path
                       parameters:(NSDictionary *)parameters
                         progress:(ProgressBlock)progress
                          success:(SuccessWithHeaderBlock)success
                          failure:(FailureBlock)failure{
    
    [self setHeaderWithField:@"Cookie" andValue:SOCIALSECURITY_CONTEXT.cookie];
    
    [self GETWithPath:path parameters:parameters progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(NSInteger statusCode, NSDictionary *headerDict, NSData *data) {
        success(statusCode,headerDict,data);
    } failure:^(NSInteger statusCode, NSError *error) {
        failure(statusCode, error);
    }];
}
@end
