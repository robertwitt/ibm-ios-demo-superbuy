//
//  SBMembership.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBMshTier.h"
#import "SBMshPointAccount.h"


@interface SBMembership : SBModelObject

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *type;
@property (strong, nonatomic, readonly) NSString *typeText;
@property (strong, nonatomic, readonly) NSString *memberID;
@property (strong, nonatomic, readonly) NSDate *startDate;
@property (strong, nonatomic, readonly) NSDate *endDate;
@property (strong, nonatomic, readonly) NSString *status;
@property (strong, nonatomic, readonly) NSString *statusText;
@property (strong, nonatomic, readonly) NSString *loyaltyProgramID;
@property (strong, nonatomic, readonly) NSArray *tiers;
@property (strong, nonatomic, readonly) NSArray *pointAccounts;

@end
