//
//  SZModelMapperTests.m
//  SZModelMapperTests
//
//  Created by Song Zhou on 2019/11/7.
//  Copyright © 2019 Song Zhou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SZTestModel.h"

@interface SZModelMapperTests : XCTestCase

@end

@implementation SZModelMapperTests


- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testEmptyPrimitiveTypesConvertToModel {
    NSDictionary *json = @{};
    
    SZTestModel *model = [SZTestModel modelFromJSON:json];

    XCTAssert(model.int_p == 0);
    XCTAssert(model.double_p == 0);
    XCTAssertNil(model.number_p);
    XCTAssertNil(model.string_p);
}

- (void)testPrimitiveTypesConvertToModel {
    NSDictionary *json =
    @{
        @"int_p": @42,
        @"float_p": @0.1,
        @"double_p": @0.1,
        @"number_p": @42,
        @"number_d_p": @0.1,
        @"string_p": @"hello",
    };
    
    SZTestModel *model = [SZTestModel modelFromJSON:json];

    XCTAssert(model.int_p == 42);
    XCTAssert(model.double_p == 0.1);
    XCTAssert([model.number_p isEqualToNumber:@42]);
    XCTAssert([model.number_d_p isEqualToNumber:@0.1]);
    XCTAssert([model.string_p isEqualToString:@"hello"]);
}

- (void)testEmptyCollectionTypesConvertToModel {
    NSDictionary *json = @{
        @"array_p": @[],
        @"dictionary_p": @{},
    };
    
    SZTestModel *model = [SZTestModel modelFromJSON:json];

    XCTAssert([model.array_p isEqualToArray:@[]]);
    XCTAssert([model.dictionary_p isEqualToDictionary:@{}]);
}

- (void)testCollectionTypesConvertToModel {
    NSDictionary *json = @{
        @"array_p": @[@42],
        @"dictionary_p": @{
                @"key": @"value"
        },
    };
    
    SZTestModel *model = [SZTestModel modelFromJSON:json];

    XCTAssert(model.array_p.count);
    XCTAssert(model.dictionary_p.count);
}

- (void)testCustomTypeConvertToModel {
    NSDictionary *json = @{
        @"child": @{
                @"int_p": @42,
        }
    };
    
    SZTestModel *model = [SZTestModel modelFromJSON:json];
    
    XCTAssert(model.child.int_p == 42);

}

- (void)testGetAttributes {
    unsigned int count;
    objc_property_t *props = class_copyPropertyList(SZTestModel.class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        jbs_copyPropertyAttributes(property);
    }
}


@end
