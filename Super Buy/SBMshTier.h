//
//  SBMshTier.h
//  Super Buy
//
//  Created by Robert Witt on 31.08.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBMembership;

@interface SBMshTier : SBModelObject

@property (strong, nonatomic) SBMembership *membership;

@property (strong, nonatomic, readonly) NSString *tierGroup;
@property (strong, nonatomic, readonly) NSString *tierGroupText;
@property (strong, nonatomic, readonly) NSString *tierLevel;
@property (strong, nonatomic, readonly) NSString *tierLevelText;
@property (strong, nonatomic, readonly) NSDate *startDate;
@property (strong, nonatomic, readonly) NSDate *endDate;
@property (strong, nonatomic, readonly) NSDate *expiryDate;
@property (strong, nonatomic, readonly) NSString *status;
@property (strong, nonatomic, readonly) NSString *statusText;

@end
