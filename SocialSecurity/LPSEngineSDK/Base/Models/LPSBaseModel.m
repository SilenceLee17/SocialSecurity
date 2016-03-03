//
//  LPSBaseModel.m
//  SocialSecurity
//
//  Created by 李兴东 on 16/2/27.
//  Copyright © 2016年 lixingdong. All rights reserved.
//

#import "LPSBaseModel.h"
#import <objc/runtime.h>

#define className(obj) NSStringFromClass([obj class])

@implementation LPSBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self objectFromDict:dict];
    }
    return self;
}

- (void)objectFromDict:(NSDictionary *)dict inClass:(Class)cls
{
    unsigned int propCount, i;
    objc_property_t* properties = class_copyPropertyList(cls, &propCount);
    
    for (i = 0; i < propCount; ++i) {
        objc_property_t prop = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        NSLog(@"propName: %@", propName);
        id value = dict[propName];
        if (!value) {
            continue;
        }
        NSLog(@"className: %@", className(value));
        if ([value isKindOfClass:[NSString class]] ||
            [value isKindOfClass:[NSNumber class]] ||
            [value isKindOfClass:[NSArray class]]  ||
            [value isKindOfClass:[@YES class]]) {
            [self setValue:value forKey:propName];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *attrs = [NSString stringWithUTF8String:property_getAttributes(prop)];
            NSUInteger loc = 3;
            NSUInteger len = [attrs rangeOfString:@","].location - loc - 1;
            NSString *propType = [attrs substringWithRange:NSMakeRange(loc, len)];
            Class propClass = NSClassFromString(propType);
            NSLog(@"className: %@", NSStringFromClass(propClass));
            if ([propClass isSubclassOfClass:[LPSBaseModel class]]) {
                id subObj = [[propClass alloc] initWithDict:value];
                [self setValue:subObj forKey:propName];
            }
        }
    }
    free(properties);
}

- (void)objectFromDict:(NSDictionary*)dict
{
    Class cls = [self class];
    while (! [NSStringFromClass(cls) isEqualToString:@"FZBaseModel"]) {
        NSLog(@"get Properties for class: %@", NSStringFromClass(cls));
        [self objectFromDict:dict inClass:cls];
        cls = [cls superclass];
    }
}

@end
