//
//  PaymentRequestTests.m
//  AnetDomain
//
//  Created by Chuong Mai on 2/5/15.
//  Copyright (c) 2015 Authorize.Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PaymentRequestTestCase.h"

@interface PaymentRequestTests : PaymentRequestTestCase

@end

@implementation PaymentRequestTests

- (void)setUp {
    [super setUp];
    
    self.userName = @"MobileCP1";
    self.authData = @"Authnet2015-07";
    self.authKind = AuthenticationKindEnum.Password;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPaymentRequestType {
    PaymentRequestType* paymentRequest = [self buildPaymentRequestType];
    
    [paymentRequest setObject: @"False" forKeyedSubscript: @"allowPartialAuth"];
    [paymentRequest setObject: @"False" forKeyedSubscript: @"testRequest"];
    
    NSString* xmlString = [paymentRequest toXmlString];
    NSLog(@"Payment Request XML: %@", xmlString);
    
    PaymentRequestType* paymentRequest2 = [PaymentRequestType new];
    [paymentRequest2 deserialize:xmlString];
    
    NSString* xmlString2 = [paymentRequest2 toXmlString];
    NSLog(@"Payment Request 2 XML: %@", xmlString2);
    
    XCTAssertEqualObjects(xmlString, xmlString2);
}

- (void)testPaymentChoiceType {
    PaymentChoiceType* paymentChoice = [PaymentChoiceType new];
    PaymentCardType* paymentCard = [PaymentCardType new];
    
    paymentCard.accountNumber = @"4111111111111111";
    paymentCard.expirationDate = @"1221";
    paymentChoice.item = paymentCard;
    
    NSString* xmlString = [paymentChoice toXmlString];
    NSLog(@"Payment Choice XML: %@", xmlString);
    
    PaymentChoiceType* paymentChoice2 = [PaymentChoiceType new];
    [paymentChoice2 deserialize:xmlString];
    
    NSString* xmlString2 = [paymentChoice2 toXmlString];
    NSLog(@"Payment Choice 2 XML: %@", xmlString2);
    
    XCTAssertEqualObjects(xmlString, xmlString2);
    
}
@end
