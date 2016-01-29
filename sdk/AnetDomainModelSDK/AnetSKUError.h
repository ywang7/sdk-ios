//
//  AnetSKUError.h
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AnetSKUErrorCode){
    //TODO: Add more error cases if needed
    AnetSKUErrorCodeNetwork,
    AnetSKUErrorCodeInternal,
    AnetSKUErrorCodeUnknown
};

@interface AnetSKUError : NSObject

- (instancetype)initwithErrorCode : (AnetSKUErrorCode *)code andDetail : (NSString *) detail;


@end
