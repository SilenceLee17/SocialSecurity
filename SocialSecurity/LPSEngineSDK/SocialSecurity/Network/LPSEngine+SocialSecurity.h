//
//  LPSEngine+SocialSecurity.h
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSEngine.h"

@interface LPSEngine (SocialSecurity)
-(void)getSocialSecurityVerificationCodeWithSuccess:(void(^)(UIImage *image))success
                                            failure:(FailureBlock)failure;
-(void)loginWitherificationCode:(NSString *)code
                        Success:(void(^)(NSString *htmlString))success
                        failure:(FailureBlock)failure;
@end
