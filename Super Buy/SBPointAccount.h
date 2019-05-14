//
//  SBPointAccount.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBPointTransaction.h"


@interface SBPointAccount : SBModelObject

@property (strong, nonatomic, readonly) NSString *ID;
@property (strong, nonatomic, readonly) NSString *pointType;
@property (strong, nonatomic, readonly) NSString *pointTypeText;
@property (strong, nonatomic, readonly) NSNumber *pointsEarned;
@property (strong, nonatomic, readonly) NSNumber *pointsConsumed;
@property (strong, nonatomic, readonly) NSNumber *pointsExpired;
@property (strong, nonatomic, readonly) NSNumber *pointBalance;
@property (strong, nonatomic, readonly) NSDate *lastTransactionDate;
@property (strong, nonatomic, readonly) NSString *membershipID;
@property (strong, nonatomic, readonly) NSString *memberID;
@property (strong, nonatomic, readonly) NSArray *transactions;

@end
