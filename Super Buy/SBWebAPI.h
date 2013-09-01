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


@protocol SBWebAPIDelegate;

@interface SBWebAPI : NSObject

@property (nonatomic) id<SBWebAPIDelegate> delegate;

- (void)connectToBackend;
- (void)validateMembershipWithInput:(SBValidateMembershipInput *)input;
- (void)getMembershipWithInput:(SBGetMembershipInput *)input;

@end


@protocol SBWebAPIDelegate <NSObject>

@optional

- (void)webAPIdidConnectToBackend:(SBWebAPI *)webAPI;
- (void)webAPI:(SBWebAPI *)webAPI didFailConnectingToBackendWithError:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didValidateMembershipWithOutput:(SBValidateMembershipOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailValidatingMembershipWithInput:(SBValidateMembershipInput *)input error:(NSError *)error;

- (void)webAPI:(SBWebAPI *)webAPI didGetMembershipWithOutput:(SBGetMembershipOutput *)output;
- (void)webAPI:(SBWebAPI *)webAPI didFailGettingMembershipWithInput:(SBGetMembershipInput *)input error:(NSError *)error;

@end