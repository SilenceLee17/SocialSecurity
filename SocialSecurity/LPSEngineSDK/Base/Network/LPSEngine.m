//
//  LPSEngine.m
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSEngine.h"

static NSInteger const TIMEOUT_INTERVAL = 20;

@interface LPSEngine()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;


@end

@implementation LPSEngine

#pragma mark public method
+ (LPSEngine *)sharedEngine
{
    static LPSEngine *_sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedEngine = [[self alloc] init];
    });
    return _sharedEngine;
}

-(void)POSTWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
           progress:(ProgressBlock)progress
            success:(SuccessWithHeaderBlock)success
            failure:(FailureBlock)failure{
    NSString *escapedPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [self.httpManager POST:escapedPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        success([response statusCode],response.allHeaderFields,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([(NSHTTPURLResponse*)[task response] statusCode], error);
    }];
}

-(void)GETWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
           progress:(ProgressBlock)progress
            success:(SuccessWithHeaderBlock)success
            failure:(FailureBlock)failure{
    NSString *escapedPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [self.httpManager GET:escapedPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        success([response statusCode],response.allHeaderFields,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure([(NSHTTPURLResponse*)[task response] statusCode], error);
    }];
}

#pragma mark private method
-(instancetype)init{
    self = [super init];
    if (self) {
        self.httpManager = [AFHTTPSessionManager manager];
        self.httpManager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.httpManager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json",@"image/jpeg",@"text/html", nil];
    }
    return self;
}

- (void)setHeaderWithField:(NSString *)field andValue:(NSString *)value
{
    if (field && value) {
        [self.httpManager.requestSerializer setValue:value forHTTPHeaderField:field];
    }
}

- (NSError *)errorWithCode:(NSInteger)code andDesc:(NSString *)desc
{
    NSString *domain = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *info = @{ NSLocalizedDescriptionKey: desc ? : @"" };
    return [NSError errorWithDomain:domain code:code userInfo:info];
}

@end
