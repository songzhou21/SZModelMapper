//
//  JBSTestModel.h
//  JBSAASTests
//
//  Created by Song Zhou on 2019/11/6.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZTestModel : SZModel

/// primitive types
@property NSUInteger int_p;
@property float float_p;
@property double double_p;

/// primitive objects
@property (nonatomic) NSNumber *number_p;
@property (nonatomic) NSNumber *number_d_p;
@property (nonatomic, copy) NSString *string_p;

/// collection objects
@property (nonatomic, copy) NSArray *array_p;
@property (nonatomic, copy) NSDictionary *dictionary_p;

/// custom object
@property (nonatomic) SZTestModel *child;

@end

NS_ASSUME_NONNULL_END
