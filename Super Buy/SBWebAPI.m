//
//  SBWebAPI.m
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBWebAPI.h"
#import "WorklightAPI/include/WLClient.h"
#import "WorklightAPI/include/WLDelegate.h"
#import "WorklightAPI/include/WLProcedureInvocationData.h"


SBWebAPI *singleton;
NSString *SBAdapter = @"SOAPCRMMobileLoyalty";
NSString *SBProcedureGetMembership = @"getMembership";


@implementation SBGetMembershipInput
@end


@implementation SBGetMembershipOutput
@end


@interface SBWebAPI () <WLDelegate>

@property (nonatomic) BOOL connected;
@property (strong, nonatomic) NSString *procedure;

- (void)connect;
- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters;

@end


@implementation SBWebAPI

- (void)startGettingMembershipWithInput:(SBGetMembershipInput *)input
{
    [self invokeProcedure:SBProcedureGetMembership
           withParameters:@[input.membershipID]];
}

- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters
{
    [self connect];
    
    self.procedure = procedure;
    WLProcedureInvocationData *invocationData = [[WLProcedureInvocationData alloc] initWithAdapterName:SBAdapter procedureName:procedure];
    invocationData.parameters = parameters;
    
    [[WLClient sharedInstance] invokeProcedure:invocationData withDelegate:self];
}

- (void)connect
{
    if (!self.connected) {
        [[WLClient sharedInstance] wlConnectWithDelegate:self];
    }
}

- (void)onSuccess:(WLResponse *)response
{
    
}

- (void)onFailure:(WLFailResponse *)response
{
    // TODO Implement method
}

+ (SBWebAPI *)sharedInstance
{
    if (!singleton) {
        singleton = [[SBWebAPI alloc] init];
    }
    return singleton;
}

@end
