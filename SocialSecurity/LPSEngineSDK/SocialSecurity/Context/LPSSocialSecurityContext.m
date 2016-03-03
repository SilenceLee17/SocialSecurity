//
//  LPSSocialSecurityContext.m
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/28.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSSocialSecurityContext.h"

@implementation LPSSocialSecurityContext

+ (LPSSocialSecurityContext *)sharedInstance
{
    static LPSSocialSecurityContext *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)setCookieString:(NSDictionary *)dict{
    for (NSString *string in dict) {
        if ([string isEqualToString:@"Set-Cookie"]) {
            NSString *headerCookieString = dict[string];
            NSArray *headerCookieArray = [headerCookieString componentsSeparatedByString:@","];
            for (NSString *cookieString in headerCookieArray) {
                NSArray *cookieArray = [cookieString componentsSeparatedByString:@";"];
                _cookie = [NSString stringWithFormat:@"%@%@;",_cookie ? : @"",[cookieArray firstObject]];
            }
        }
    }
}
@end
