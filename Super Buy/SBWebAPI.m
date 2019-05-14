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
static NSString *SBProcedureRegisterMembership = @"registerMembership";
static NSString *SBProcedureGetMembership = @"getMembership";
static NSString *SBProcedureGetMember = @"getMember";
static NSString *SBProcedureGetPointAccount = @"getPointAccount";
static NSString *SBProcedureEnterBonusCode = @"enterBonusCode";
static NSString *SBProcedureGetRewardProductCatalog = @"getRewardProductCatalog";
static NSString *SBProcedurePurchaseRewardProduct = @"purchaseRewardProduct";


@interface SBWebAPI () <WLDelegate>

@property (strong, nonatomic) NSString *procedure;
@property (nonatomic) id input;

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
    self.input = input;
    [self invokeProcedure:SBProcedureValidateMembership
           withParameters:@[input.memberID, input.membershipID]];
}

- (void)registerMembershipWithInput:(SBRegisterMembershipInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureRegisterMembership
           withParameters:@[input.jsonData]];
}

- (void)getMembershipWithInput:(SBGetMembershipInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureGetMembership
           withParameters:@[input.membershipID]];
}

- (void)getMemberWithInput:(SBGetMemberInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureGetMember
           withParameters:@[input.memberID]];
}

- (void)getPointAccountWithInput:(SBGetPointAccountInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureGetPointAccount
           withParameters:@[input.pointAccountID]];
}

- (void)enterBonusCodeWithInput:(SBEnterBonusCodeInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureEnterBonusCode
           withParameters:@[input.bonusCode, input.membershipID]];
}

- (void)getRewardProductCatalog:(SBGetRewardProductCatalogInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedureGetRewardProductCatalog withParameters:nil];
}

- (void)purchaseRewardProductWithInput:(SBPurchaseRewardProductInput *)input
{
    self.input = input;
    [self invokeProcedure:SBProcedurePurchaseRewardProduct
           withParameters:@[input.jsonData]];
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
    NSLog(@"%@", jsonData);
    
    NSString *procedure = self.procedure;
    self.procedure = nil;
    
    if ([procedure isEqualToString:SBProcedureValidateMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didValidateMembershipWithOutput:)]) {
            SBValidateMembershipOutput *output = [[SBValidateMembershipOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didValidateMembershipWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureRegisterMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didRegisterMembershipWithOutput:)]) {
            SBRegisterMembershipOutput *output = [[SBRegisterMembershipOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didRegisterMembershipWithOutput:output];
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
    
    else if ([procedure isEqualToString:SBProcedureEnterBonusCode])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didEnterBonusCodeWithOutput:)]) {
            SBEnterBonusCodeOutput *output = [[SBEnterBonusCodeOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didEnterBonusCodeWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetRewardProductCatalog])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didGetRewardProductCatalogWithOutput:)]) {
            SBGetRewardProductCatalogOutput *output = [[SBGetRewardProductCatalogOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didGetRewardProductCatalogWithOutput:output];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedurePurchaseRewardProduct])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didPurchaseRewardProductWithOutput:)]) {
            SBPurchaseRewardProductOutput *output = [[SBPurchaseRewardProductOutput alloc] initWithJsonData:jsonData];
            [self.delegate webAPI:self didPurchaseRewardProductWithOutput:output];
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
    NSLog(@"%@", response.errorMsg);
    
    NSString *procedure = self.procedure;
    self.procedure = nil;
    
    id input = self.input;
    self.input = nil;
    
    if ([procedure isEqualToString:SBProcedureValidateMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailValidatingMembershipWithInput:error:)]) {
            [self.delegate webAPI:self didFailValidatingMembershipWithInput:(SBValidateMembershipInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureRegisterMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailRegisteringMembershipWithInput:error:)]) {
            [self.delegate webAPI:self didFailRegisteringMembershipWithInput:(SBRegisterMembershipInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetMembership])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailGettingMembershipWithInput:error:)]) {
            [self.delegate webAPI:self didFailGettingMembershipWithInput:(SBGetMembershipInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetMember])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailGettingMemberWithInput:error:)]) {
            [self.delegate webAPI:self didFailGettingMemberWithInput:(SBGetMemberInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetPointAccount])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailGettingPointAccountWithInput:error:)]) {
            [self.delegate webAPI:self didFailGettingPointAccountWithInput:(SBGetPointAccountInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureEnterBonusCode])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailEnteringBonusCodeWithInput:error:)]) {
            [self.delegate webAPI:self didFailEnteringBonusCodeWithInput:(SBEnterBonusCodeInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedureGetRewardProductCatalog])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailGettingRewardProductCatalogWithInput:error:)]) {
            [self.delegate webAPI:self didFailGettingRewardProductCatalogWithInput:(SBGetRewardProductCatalogInput *)input error:nil];
        }
    }
    
    else if ([procedure isEqualToString:SBProcedurePurchaseRewardProduct])
    {
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailPurchasingRewardProductWithInput:error:)]) {
            [self.delegate webAPI:self didFailPurchasingRewardProductWithInput:(SBPurchaseRewardProductInput *)input error:nil];
        }
    }
    
    else
    {
        // Finally this must be the connect attempt.
        if ([self.delegate respondsToSelector:@selector(webAPI:didFailConnectingToBackendWithError:)]) {
            [self.delegate webAPI:self didFailConnectingToBackendWithError:nil];
        }
    }
}

@end
