//
//  SZModel.m
//  SZModelMapper
//
//  Created by Song Zhou on 2019/11/7.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZModel.h"
#include "SZRuntimeExtensions.h"

static void *JBSModelCachedPropertyKeysKey = &JBSModelCachedPropertyKeysKey;

static NSSet<NSString *> *JBSInternalProperties(void) {
    static NSSet<NSString *> *ret;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ret = [NSSet setWithArray:@[
                                    @"description",
                                    @"debugDescription",
                                    @"hash",
                                    @"superclass",
                                    ]];
    });
    
    return ret;
}

void JBSEnumerateClassProperty(Class klass, void(^block)(NSString *property_name, NSString *type_attribute)){
    if (!block) {
        return;
    }
    
    unsigned int count;
    objc_property_t *props = class_copyPropertyList(klass, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        const char *type = property_getAttributes(property);
        
        NSString *typeString = [NSString stringWithUTF8String:type];
        NSArray<NSString *> *attributes = [typeString componentsSeparatedByString:@","];
        NSString *typeAttribute = attributes[0];
        
        block(propertyName, typeAttribute);
    }
}

void JBSCleanEnumerateClassProperty(Class klass, void(^block)(NSString *property_name, NSString *type_attribute)){
    JBSEnumerateClassProperty(klass, ^(NSString * _Nonnull property_name, NSString * _Nonnull type_attribute) {
        if ([JBSInternalProperties() containsObject:property_name]) {
            return;
        }
        
        block(property_name, type_attribute);
    });
}

void JBSEnumerateAllClassProperty(Class klass, void(^block)(NSString *property_name, NSString *type_attribute)){
    Class currentClass = klass;
    while (currentClass != [NSObject class]) {
        JBSCleanEnumerateClassProperty(currentClass, block);
        
        currentClass = [currentClass superclass];
    }
}

static NSString * _Nullable JBSClassNameFromType(NSString *type_attribute) {
    NSScanner *scanner = [NSScanner scannerWithString:type_attribute];
    
    NSString *quote = @"\"";
    NSString *result;
    if ([scanner scanUpToString:quote intoString:nil] && scanner.scanLocation < type_attribute.length) {
        scanner.scanLocation += 1;
        if ([scanner scanUpToString:quote intoString:&result]) {
            return result;
        }
    }
    
    return nil;
}

@interface SZModel ()

@end

@implementation SZModel

+ (NSSet *)propertyKeys {
    NSSet *cachedKeys = objc_getAssociatedObject(self, JBSModelCachedPropertyKeysKey);
    if (cachedKeys) return cachedKeys;
    
    NSMutableSet *set = [NSMutableSet self];
    
    JBSEnumerateAllClassProperty(self, ^(NSString * _Nonnull property_name, NSString * _Nonnull type_attribute) {

    });

    objc_setAssociatedObject(self, JBSModelCachedPropertyKeysKey, set, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return set;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];

    if (self) {
        NSArray<NSString *> *properties = nil;
        
        for (NSString *property in properties) {
            id value = json[property];
            
            if (!value) {
                continue;
            }
            
            [self setValue:value forProperty:property];
        };
    }
    
    return self;
}

+ (instancetype)modelFromJSON:(NSDictionary *)json {
    return [[self alloc] initWithJSON:json];
}

- (void)setValue:(id)value forProperty:(NSString *)property {
    [self setValue:value forKey:property];
}

@end
