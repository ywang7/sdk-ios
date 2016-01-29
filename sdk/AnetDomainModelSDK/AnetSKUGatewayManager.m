//
//  AnetSKUGateway.m
//  Anet SDK
//
//  Created by Yinghao Wang on 1/27/16.
//  Copyright © 2016 MMA. All rights reserved.
//

#import "AnetSKUGatewayManager.h"

@interface AnetSKUGatewayManager()

@property (nonatomic, strong) GatewaySession *gatewaySession;

@end

@implementation AnetSKUGatewayManager
static AnetSKUGatewayManager *instance = nil;

+ (instancetype)sharedInstance {
    @synchronized(self) {
        if (instance) {
            instance = [[AnetSKUGatewayManager alloc] init];
        }
    }
    return instance;
}

- (instancetype)initWithSessionName : (NSString *)name andURL : (NSURL *) aURL {
    if (self = [super init]) {
        self.gatewaySession = [[GatewaySession alloc] initWithName:name url:aURL];
        
    }
    return self;
}

- (GatewaySession *)gatewaySession{
    return [self gatewaySession];
}

- (NSURLSessionTask *)sendRequest:(AnetSKURequest *)aRequest withCompletion:(AnetSKUCompletionBlock)completion {
    NSURLRequest *aURLRequest = [self parseRequest:aRequest];
    return [self.gatewaySession sendRequest:aURLRequest completion:^(NSData * data, NSError * error){
        AnetSKUResponse *skuresponse = [[AnetSKUResponse alloc] initWithData:data];
        AnetSKUError *skuerror = [[AnetSKUError alloc] initwithErrorCode:AnetSKUErrorCodeNetwork andDetail:error.description];
        completion(skuresponse, skuerror);
    }];
    
}

- (NSURLRequest *) parseRequest : (AnetSKURequest *) aRequest{
    //TODO: parse the AnetSKURequest to NSURLRequest
    //gateway session has prepare request from xml string
    return [NSURLRequest new];
}


@end
