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
static NSString *SBProcedureGetMember = @"getMember";
static NSString *SBProcedureGetPointAccount = @"getPointAccount";


@interface SBWebAPI () <WLDelegate>

@property (strong, nonatomic) NSString *procedure;

- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters;

@end


#pragma mark -

@implementation SBWebAPI

BOOL connected = NO;

#pragma mark Invoking the Worklight Server

- (void)connectToBackend
{
    if (!connected) {
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

- (void)getMemberWithInput:(SBGetMemberInput *)input
{
    [self invokeProcedure:SBProcedureGetMember
           withParameters:@[input.memberID]];
}

- (void)getPointAccountWithInput:(SBGetPointAccountInput *)input
{
    [self invokeProcedure:SBProcedureGetPointAccount
           withParameters:@[input.pointAccountID]];
}

- (void)invokeProcedure:(NSString *)procedure withParameters:(NSArray *)parameters
{
    self.procedure = procedure;
    WLProcedureInvocationData *invocationData = [[WLProcedureInvocationData alloc] initWithAdapterName:SBAdapter procedureName:procedure];
    invocationData.parameters = parameters;
    
    [[WLClient sharedInstance] invokeProcedure:invocationData withDelegate:self];
}


#pragma mark Worklight Client Delegate

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
    
    else if ([procedure isEqualToString:SBProcedureGetMember])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didGetMemberWithOutput:)]) {
            SBGetMemberOutput *output = [[SBGetMemberOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didGetMemberWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetPointAccount])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didGetPointAccountWithOutput:)]) {
            SBGetPointAccountOutput *output = [[SBGetPointAccountOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didGetPointAccountWithOutput:output];
        }
    }
    
    else
    {
        // Finally this must be the connect attempt.
        connected = YES;
        
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
