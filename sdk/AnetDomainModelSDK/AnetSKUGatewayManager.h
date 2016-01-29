//
//  AnetSKUGateway.h
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Anetdomain/AnetDomain-Swift.h>
#import "AnetSKUError.h"
#import "AnetSKURequest.h"
#import "AnetSKUResponse.h"

typedef void (^AnetSKUCompletionBlock) (AnetSKUResponse *response, AnetSKUError *error);

@interface AnetSKUGatewayManager : NSObject

+ (instancetype) sharedInstance;

/**
 *  Gateway for sending request
 *
 *  @param aRequest   request to send
 *  @param completion completion block
 *
 *  @return session task that handles the request
 */
- (NSURLSessionTask*) sendRequest : (AnetSKURequest*) aRequest withCompletion: (AnetSKUCompletionBlock ) completion;


@end
