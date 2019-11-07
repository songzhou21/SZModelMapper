//
//  SZSRuntimeExtensions.m
//  SZSModel
//
//  Created by Song Zhou on 2019/11/7.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "SZRuntimeExtensions.h"

sz_propertyAttributes *sz_copyPropertyAttributes(objc_property_t property) {
    const char *const attrString = property_getAttributes(property);
    
    if (!attrString) {
        fprintf(stderr, "ERROR: Could not get attribute string from property %s\n", property_getName(property));
        return NULL;
    }
    
    if (attrString[0] != 'T') {
        fprintf(stderr, "ERROR: Expected attribute string \"%s\" for property %s to start with 'T'\n", attrString, property_getName(property));
        return NULL;
    }
    
    const char *typeString = attrString + 1;
    
    const char *next = NSGetSizeAndAlignment(typeString, NULL, NULL);
    if (!next) {
        fprintf(stderr, "ERROR: Could not read past type in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    size_t typeLength = next - typeString;
    if (!typeLength) {
        fprintf(stderr, "ERROR: Invalid type in attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    sz_propertyAttributes *attributes = calloc(1, sizeof(sz_propertyAttributes) + typeLength + 1);
    if (!attributes) {
        fprintf(stderr, "ERROR: Could not allocate jbs_propertyAttributes structure for attribute string \"%s\" for property %s\n", attrString, property_getName(property));
        return NULL;
    }
    
    // copy the type string
    strncpy(attributes->type, typeString, typeLength);
    attributes->type[typeLength] = '\0';
    
    
    return NULL;
}
