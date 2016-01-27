//
//  AnetDomainTests.m
//  AnetDomainTests
//
//  Created by Chuong Mai on 1/7/15.
//  Copyright (c) 2015 Authorize.Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <AnetDomain/AnetDomain-Swift.h>

@interface AnetDomainTests : XCTestCase

@end

@implementation AnetDomainTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testAttributes {
    BaseType* model = [BaseType new];
    
    XCTAssertNil(model.attributes);
    XCTAssertNil([model objectForKeyedSubscript:@"Key"]);
    
    [model setObject:@"John" forKeyedSubscript:@"FirstName"];
    XCTAssertNotNil(model.attributes);
    XCTAssertEqual(1, model.attributes.count);
    XCTAssertEqual (@"John", [model objectForKeyedSubscript:@"FirstName"]);
    
    NSArray* attributes = model.attributes;
    
    [model setObject:@"Doe" forKeyedSubscript:@"LastName"];
    XCTAssertNotEqual(attributes, model.attributes);
    XCTAssertEqual (2, model.attributes.count);
    XCTAssertEqual (@"John", [model objectForKeyedSubscript:@"FirstName"]);
    XCTAssertEqual (@"Doe", [model objectForKeyedSubscript:@"LastName"]);
    
    XCTAssertEqual (@"FirstName", ((AttributeType*)model.attributes[0]).key);
    XCTAssertEqual (@"John", ((AttributeType*)model.attributes[0]).value);
    XCTAssertEqual (@"LastName", ((AttributeType*)model.attributes[1]).key);
    XCTAssertEqual (@"Doe", ((AttributeType*)model.attributes[1]).value);
    
    attributes = model.attributes;
    [model setObject:@"Judah" forKeyedSubscript:@"FirstName"];
    XCTAssertNotEqual(attributes, model.attributes);
    XCTAssertEqual (2, model.attributes.count);
    XCTAssertEqual (@"Judah", [model objectForKeyedSubscript:@"FirstName"]);
    XCTAssertEqual (@"Doe", [model objectForKeyedSubscript:@"LastName"]);
    
    [model setObject:@"Genesis" forKeyedSubscript:@"LastName"];
    XCTAssertNotEqual(attributes, model.attributes);
    XCTAssertEqual (2, model.attributes.count);
    XCTAssertEqual (@"Judah", [model objectForKeyedSubscript:@"FirstName"]);
    XCTAssertEqual (@"Genesis", [model objectForKeyedSubscript:@"LastName"]);
    
    [model setObject:nil forKeyedSubscript:@"FirstName"];
    XCTAssertNotEqual (model.attributes, attributes);
    XCTAssertNotNil (model.attributes);
    XCTAssertEqual (1, model.attributes.count);
    XCTAssertEqual (2, attributes.count);
    XCTAssertNil ([model objectForKeyedSubscript:@"FirstName"]);
    XCTAssertEqual (@"Genesis", [model objectForKeyedSubscript:@"LastName"]);
    
    attributes = model.attributes;
    [model setObject:nil forKeyedSubscript:@"LastName"];
    XCTAssertNotNil (model.attributes);
    XCTAssertNotEqual (model.attributes, attributes);
    XCTAssertEqual (0, model.attributes.count);
    XCTAssertNil ([model objectForKeyedSubscript:@"LastName"]);
}
@end
