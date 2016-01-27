//
//  PaymentRequestTestCase.h
//  AnetDomain
//
//  Created by Chuong Mai on 5/27/15.
//  Copyright (c) 2015 Authorize.Net. All rights reserved.
//

#ifndef AnetDomain_PaymentRequestTestCase_h
#define AnetDomain_PaymentRequestTestCase_h

#import <XCTest/XCTest.h>
#import <AnetDomain/AnetDomain-Swift.h>

@interface PaymentRequestTestCase : XCTestCase

@property (nonatomic, strong) NSString* userName;
@property (nonatomic, strong) NSString* authData;
@property (nonatomic, strong) NSString* accountID;
@property (nonatomic, strong) AuthenticationKindEnum* authKind;

-(PaymentChoiceType*) buildPaymentChoiceType;
-(NSArray*) buildContactInfos;
-(CurrencyAmountType*) buildCurrencyAmount: (NSNumber*) amount;
-(OrderInfoType*) buildOrderInfoType;
-(PaymentRequestType*) buildPaymentRequestType;
-(TransactionRequestType*) buildTransactionRequestType: (TransactionKindEnum*) kind;

@end


#endif
