//
//  SBWebAPI.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBMembership.h"
#import "SBMessageArray.h"


@interface SBGetMembershipInput : NSObject
@property (nonatomic, strong) NSString *membershipID;
@end

@interface SBGetMembershipOutput : NSObject
@property (nonatomic, strong) SBMembership *membership;
@end


@protocol SBWebAPIDelegate;

@interface SBWebAPI : NSObject

@property (nonatomic) id<SBWebAPIDelegate> delegate;

- (void)startGettingMembershipWithInput:(SBGetMembershipInput *)input;

+ (SBWebAPI *)sharedInstance;

@end


@protocol SBWebAPIDelegate <NSObject>

@optional

- (void)didGetMembershipWithOutput:(SBGetMembershipOutput *)output messages:(SBMessageArray *)messages;
- (void)didFailGettingMembershipWithInput:(SBGetMembershipInput *)input error:(NSError *)error;

@end