//
//  AnetSKUResponse.m
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import "AnetSKUResponse.h"

@interface AnetSKUResponse()

@end

@implementation AnetSKUResponse

- (instancetype) initWithData : (NSData *) data{
    if (self = [super init]) {
        [self parseData:data];
    }
    return self;
    
}

- (void) parseData: (NSData *) data {
    //TODO: Parse Data
}

@end
