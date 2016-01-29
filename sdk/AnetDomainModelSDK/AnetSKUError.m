//
//  AnetSKUError.m
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import "AnetSKUError.h"

@interface AnetSKUError()

@property NSString * errorDetail;
@property AnetSKUErrorCode *errorCode;

@end

@implementation AnetSKUError

- (instancetype)initwithErrorCode : (AnetSKUErrorCode *)code andDetail : (NSString *) detail{
    [self setErrorCode:code];
    [self setErrorDetail:detail];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Error Code: %lu, Error Detail: %@", (unsigned long)self.errorCode, self.errorDetail ];
}

@end
