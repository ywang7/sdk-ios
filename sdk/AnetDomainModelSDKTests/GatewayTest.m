//
//  GatewayTest.m
//  Anet SDK
//
//  Created by Yinghao Wang on 1/28/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AnetDomain/AnetDomain-Swift.h>
#import "PaymentRequestTestCase.h"

@interface GatewayTest : PaymentRequestTestCase

@end

@implementation GatewayTest

- (void)setUp {
    [super setUp];
    self.userName = @"yinghaowang1991";
    self.authData = @"Wyh_1991091";
    self.authKind = AuthenticationKindEnum.Password;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGateway {
    
    TransactionRequestType *transactionRequest = [self buildTransactionRequestType:[TransactionKindEnum Authentication]];
    NSData *transactionRequestData = [[transactionRequest toXmlString] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *aURL = [NSURL URLWithString:@"https://apitest.authorize.net/xml/v1/request.api"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:aURL];
    [request setHTTPBody:transactionRequestData];
    
    GatewaySession *session = [[GatewaySession alloc] initWithName:@"test" url:aURL];
    
    [session sendRequest:request completion:^(NSData *data, NSError *error) {
        NSLog(@"Data : %@\nError : %@", data, error);
        
        
    }];
    
}


@end
