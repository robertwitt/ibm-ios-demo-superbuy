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


static NSString *SBAdapter = @"SOAPCRMMobileLoyalty";
static NSString *SBProcedureValidateMembership = @"validateMembership";
static NSString *SBProcedureGetMembership = @"getMembership";


@interface SBWebAPI () <WLDelegate>

@property (nonatomic) BOOL connected;
@property (strong, nonatomic) NSString *procedure;

- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters;

@end


@implementation SBWebAPI

#pragma mark Invoking the Worklight Server

- (void)connectToBackend
{
    if (!self.connected) {
        [[WLClient sharedInstance] wlConnectWithDelegate:self];
    } else {
        // If already connected, inform delegate immediately
        if ([self.delegate respondsToSelector:@selector(webAPIdidConnectToBackend:)]) {
            [self.delegate webAPIdidConnectToBackend:self];
        }
    }
}

- (void)validateMembershipWithInput:(SBValidateMembershipInput *)input
{
    [self invokeProcedure:SBProcedureValidateMembership
           withParameters:@[input.memberID, input.membershipID]];
}

- (void)getMembershipWithInput:(SBGetMembershipInput *)input
{
    [self invokeProcedure:SBProcedureGetMembership
           withParameters:@[input.membershipID]];
}

- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters
{
    self.procedure = procedure;
    WLProcedureInvocationData *invocationData = [[WLProcedureInvocationData alloc] initWithAdapterName:SBAdapter procedureName:procedure];
    invocationData.parameters = parameters;
    
    [[WLClient sharedInstance] invokeProcedure:invocationData withDelegate:self];
}


#pragma Worklight Client Delegate

- (void)onSuccess:(WLResponse *)response
{
    NSDictionary *jsonData = [response getResponseJson];
    NSString *procedure = self.procedure;
    self.procedure = nil;
    
    if ([procedure isEqualToString:SBProcedureValidateMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didValidateMembershipWithOutput:)]) {
            SBValidateMembershipOutput *output = [[SBValidateMembershipOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didValidateMembershipWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didGetMembershipWithOutput:)]) {
            SBGetMembershipOutput *output = [[SBGetMembershipOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didGetMembershipWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:@""])
    {
        // TODO Implement further web services
    }
    
    else
    {
        // Finally this must be the connect attempt.
        self.connected = YES;
        
        if ([self.delegate respondsToSelector:@selector(webAPIdidConnectToBackend:)]) {
            [self.delegate webAPIdidConnectToBackend:self];
        }
    }
}

- (void)onFailure:(WLFailResponse *)response
{
    // TODO Implement method
}

@end
