//
//  AnetSKURequest.h
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AnetDomain/AnetDomain-Swift.h>

@interface AnetSKURequest : NSObject


//TODO: include fields needed

@property PaymentCardType *paymentCard;
@property NSArray *taxArray;


- (NSString *)toXmlString;

@end
