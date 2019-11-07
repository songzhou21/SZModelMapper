//
//  SZSRuntimeExtensions.h
//  SZSModel
//
//  Created by Song Zhou on 2019/11/7.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <objc/runtime.h>

typedef struct {
    
    /**
     object class
     - nil if the property wase defined as \c id
     - is not of an object type
     - ths class could not be found at runtime
     */
    Class cls;
    
    /**
     The type encoding for the value of this property.
     This is the type as it would be returned by the \c @encode() directive
     */
    char type[];
} sz_propertyAttributes;


/// Returns a pointer to a struct containing information about \a property
/// must \c free() the return pointer
/// @param property property
/// @return \c NULL if error
sz_propertyAttributes *sz_copyPropertyAttributes(objc_property_t property);
