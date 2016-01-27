//
//  PaymentRequestTestCase.m
//  AnetDomain
//
//  Created by Chuong Mai on 5/27/15.
//  Copyright (c) 2015 Authorize.Net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentRequestTestCase.h"

@implementation PaymentRequestTestCase

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

-(TransactionRequestType*) buildTransactionRequestType: (TransactionKindEnum*) kind
{
    TransactionRequestType* transactionRequest = [TransactionRequestType new];
    
    transactionRequest.kind = kind;
    transactionRequest.authentication.userName = self.userName;
    transactionRequest.authentication.accountID = self.accountID;
    transactionRequest.authentication.authKind = self.authKind;
    transactionRequest.authentication.authData = self.authData;
    
    return transactionRequest;
}

-(PaymentRequestType*) buildPaymentRequestType
{
    PaymentRequestType* paymentRequest = [PaymentRequestType new];
    
    paymentRequest.method = PaymentRequestMethodEnum.Sale;
    paymentRequest.payment = [self buildPaymentChoiceType];
    paymentRequest.order = [self buildOrderInfoType];
    paymentRequest.amount = [self buildCurrencyAmountWithOrderSummaryItems: paymentRequest.order.orderSummaryItems];
    paymentRequest.contacts = [self buildContactInfos];

    return paymentRequest;
}

-(NSArray*) buildContactInfos
{
    return @[ [self buildBillingContactInfo], [self buildShippingContactInfo] ];
}

-(ContactInfoType*) buildBillingContactInfo
{
    ContactInfoType* contactInfo = [ContactInfoType new];
    contactInfo.kind = ContactKindEnum.Billing;
    contactInfo.firstName = @"John";
    contactInfo.lastName = @"Doe";
    contactInfo.companyName = @"Authorized Net";
    contactInfo.title = @"Manager";
    contactInfo.addresses = @[ [self buildBillingAddress] ];
    contactInfo.emailAddresses = @[ [self buildEmailAddressType: ContactKindEnum.Work withEmail: @"johndoe@visa.com"] ];
    contactInfo.phoneNumbers = @[ [self buildPhoneNumberType:ContactKindEnum.Work withNumber:@"1-800-555-1230"],
                                  [self buildPhoneNumberType:ContactKindEnum.Fax withNumber:@"1-800-555-1231"] ];
    
    return contactInfo;
}

-(ContactInfoType*) buildShippingContactInfo
{
    ContactInfoType* contactInfo = [ContactInfoType new];
    contactInfo.kind = ContactKindEnum.Shipping;
    contactInfo.firstName = @"John";
    contactInfo.lastName = @"Smith";
    contactInfo.companyName = @"Authorized Net Receiving";
    contactInfo.title = @"Supervisor";
    contactInfo.addresses = @[ [self buildBillingAddress] ];
    contactInfo.emailAddresses = @[ [self buildEmailAddressType: ContactKindEnum.Work withEmail: @"johnsmith@visa.com"] ];
    contactInfo.phoneNumbers = @[ [self buildPhoneNumberType:ContactKindEnum.Work withNumber:@"1-800-555-1232"],
                                  [self buildPhoneNumberType:ContactKindEnum.Fax withNumber:@"1-800-555-1233"] ];
    
    return contactInfo;
}

-(ContactPhoneNumberType*) buildPhoneNumberType: (ContactKindEnum*) kind withNumber: (NSString*) number
{
    ContactPhoneNumberType* phone = [ContactPhoneNumberType new];
    phone.kind = kind;
    phone.number = number;
    
    return phone;
}

-(ContactEmailAddressType*) buildEmailAddressType: (ContactKindEnum*) kind withEmail: (NSString*) email
{
    ContactEmailAddressType* emailAddr = [ContactEmailAddressType new];
    emailAddr.kind = kind;
    emailAddr.email = email;
    
    return emailAddr;
}

-(ContactAddressType*) buildBillingAddress
{
    ContactAddressType* addr = [ContactAddressType new];
    
    addr.attributes = @[[self buildAttribute:@"key" withValue: @"value"]];
    addr.addressLabel = @"My Billing Address";
    addr.address1 = @"10800 NE 8th St";
    addr.address2 = nil;
    addr.city = @"Bellevue";
    addr.state = @"WA";
    addr.postalCode = @"98052";
    addr.country = @"USA";
    addr.province = @"Pacific Northwest";
    
    return addr;
}


-(AttributeType*) buildAttribute: (NSString*) key withValue: (NSString*) value
{
    AttributeType* attr = [AttributeType new];
    attr.key = key;
    attr.value = value;
    
    return attr;
}

-(CurrencyAmountType*) buildCurrencyAmountWithOrderSummaryItems: (NSArray*) orderSummaryItems
{
    CurrencyAmountType* currencyAmount = [CurrencyAmountType new];

    if (orderSummaryItems)
    {
        for (OrderSummaryItemType* orderSummary in orderSummaryItems)
        {
            if (OrderSummaryItemKindEnum.Total == orderSummary.kind)
            {
                currencyAmount.amount = [NSNumber numberWithLong:(long)(orderSummary.amount.doubleValue * 100)];
                currencyAmount.decimalPlaces = [NSNumber numberWithInt:2];
            }
        }
    }
    return currencyAmount;
}

-(CurrencyAmountType*) buildCurrencyAmount: (NSNumber*) amount
{
    CurrencyAmountType* currencyAmount = [CurrencyAmountType new];
    currencyAmount.amount = amount;
    currencyAmount.decimalPlaces = [NSNumber numberWithInt:2];
    
    return currencyAmount;
}

-(PaymentChoiceType*) buildPaymentChoiceType
{
    PaymentChoiceType* choice = [PaymentChoiceType new];
    choice.item = [self buildPaymentType];
    
    return choice;
}

-(OrderInfoType*) buildOrderInfoType
{
    OrderInfoType* order = [OrderInfoType new];
    order.orderNumber = [self formatDateOrderNumber];
    order.referenceNumber = @"123456789";
    order.desc = @"Test Order";
    order.orderItems = @[[self buildOrderItemType: @"0001" withName: @"Item 1" withPrice: [NSDecimalNumber decimalNumberWithString:@"0.01"]]];
    order.orderSummaryItems =
    @[
      [self buildOrderSummaryItemType: OrderSummaryItemKindEnum.Shipping withName: @"USPS" withDescription:@"Priority Mail" withAmount: [NSDecimalNumber decimalNumberWithString:@"0.01"]],
      
      [self buildOrderSummaryItemType: OrderSummaryItemKindEnum.Tax withName: @"Tax" withDescription:@"WA (9.0%)"withAmount: [NSDecimalNumber decimalNumberWithString:@"0.01"]],
      
      [self buildOrderSummaryItemType: OrderSummaryItemKindEnum.Total withName: @"Total" withDescription:@""withAmount: [NSDecimalNumber decimalNumberWithString:@"0.03"]],
    ];
    return order;
}

-(OrderItemType*) buildOrderItemType: (NSString*) code withName: (NSString*) name withPrice: (NSDecimalNumber*) price
{
    OrderItemType* orderItem = [OrderItemType new];
    orderItem.code = code;
    orderItem.name = name;
    orderItem.desc = name;
    orderItem.quantity = [NSDecimalNumber decimalNumberWithString:@"1"];
    orderItem.unitPrice = price;
    orderItem.taxable = [NSNumber numberWithBool:NO];
    
    return orderItem;
}

-(OrderSummaryItemType*) buildOrderSummaryItemType: (OrderSummaryItemKindEnum*) kind withName: (NSString*) name withDescription: (NSString*) description withAmount: (NSDecimalNumber*) amount
{
    OrderSummaryItemType* orderSummary = [OrderSummaryItemType new];
    orderSummary.kind = kind;
    orderSummary.amount = amount;
    orderSummary.name = name;
    orderSummary.desc = description;
    
    return orderSummary;
}

- (PaymentType*) buildPaymentType
{
    PaymentCardType* payment = [PaymentCardType new];
    
    payment.kind = PaymentKindEnum.CP;
    payment.method = PaymentMethodEnum.Credit;
    payment.accountNumber = @"4111111111111111";
    payment.expirationDate = @"2024-12";
    payment.securityCode = @"123";
    
    return payment;
}

-(NSString*) formatDateOrderNumber
{
    NSDate* date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.timeZone = timeZone;
    [dateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
    return [dateFormatter stringFromDate:date];
}

-(NSString*) formatDateUTC: (NSDate*) date
{
    NSString* format = nil;
    
    if (date)
    {
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatter.timeZone = timeZone;
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        format = [dateFormatter stringFromDate:date];
    }
    return format;
}

@end
