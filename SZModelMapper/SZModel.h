//
//  SZModel.h
//  SZModelMapper
//
//  Created by Song Zhou on 2019/11/7.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SZModelProtocol <NSObject>

@required
+ (NSSet *)propertyKeys;

@optional
+ (id)valueForProperty:(NSString *)property;

@end

@interface SZModel : NSObject

/// transform JSON to NSObject, not support recursive transform
/// @param json json dictionary
+ (instancetype)modelFromJSON:(NSDictionary *)json;


/// set value for property
/// custom class can override this method to provide custom transform logic
/// @param value value
/// @param property property name
- (void)setValue:(id)value forProperty:(NSString *)property;

@end

NS_ASSUME_NONNULL_END
