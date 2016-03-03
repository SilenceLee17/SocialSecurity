//
//  LPSSocialSecurityContext.h
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/28.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SOCIALSECURITY_CONTEXT ([LPSSocialSecurityContext sharedInstance])


@interface LPSSocialSecurityContext : NSObject

@property (nonatomic, strong) NSString *cookie;

+ (LPSSocialSecurityContext *)sharedInstance;

-(void)setCookieString:(NSDictionary *)dict;
@end
