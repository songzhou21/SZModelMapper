//
//  JBSTestModel.m
//  JBSAASTests
//
//  Created by Song Zhou on 2019/11/6.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import "SZTestModel.h"

@implementation SZTestModel

- (void)setValue:(id)value forProperty:(NSString *)property {
    if ([property isEqualToString:@"child"]) {
         self.child = [SZTestModel modelFromJSON:value];
    } else {
        [super setValue:value forProperty:property];
    }
}

@end
