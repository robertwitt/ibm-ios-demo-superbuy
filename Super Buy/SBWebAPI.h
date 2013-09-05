//
//  SBWebAPI.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBValidateMembershipInput.h"
#import "SBValidateMembershipOutput.h"
#import "SBGetMembershipInput.h"
#import "SBGetMembershipOutput.h"
#import "SBGetMemberInput.h"
#import "SBGetMemberOutput.h"
#import "SBGetPointAccountInput.h"
#import "SBGetPointAccountOutput.h"


@protocol SBWebAPIDelegate;

@interface SBWebAPI : NSObject

@property (nonatomic) id<SBWebAPIDelegate> delegate;

- (void)connectToBackend;
- (void)validateMembershipWithInput:(SBValidateMembershipInput *)input;
- (void)getMembershipWithInput:(SBGetMembershipInput *)input;
- (void)getMemberWithInput:(SBGetMemberInput *)input;
- (void)getPointAccountWithInput:(SBGetPointAccountInput *)input;

@end


@protocol SBWebAPIDelegate <NSObject>

@optional
- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI;
- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didValidateMembershipWithOutput:(SBValidateMembershipOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailValidatingMembershipWithInput:(SBValidateMembershipInput *)input error:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didGetMembershipWithOutput:(SBGetMembershipOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailGettingMembershipWithInput:(SBGetMembershipInput *)input error:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didGetMemberWithOutput:(SBGetMemberOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailGettingMemberWithInput:(SBGetMemberInput *)input error:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didGetPointAccountWithOutput:(SBGetPointAccountOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailGettingPointAccountWithInput:(SBGetPointAccountInput *)input error:(NSError *)error;

@end