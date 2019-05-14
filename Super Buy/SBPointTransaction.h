//
//  SBPointTransaction.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBPointAccount;

@interface SBPointTransaction : SBModelObject

@property (strong, nonatomic) SBPointAccount *pointAccount;

@property (strong, nonatomic, readonly) NSString *transactionType;
@property (strong, nonatomic, readonly) NSString *transactionTypeText;
@property (strong, nonatomic, readonly) NSString *pointType;
@property (strong, nonatomic, readonly) NSString *pointTypeText;
@property (strong, nonatomic, readonly) NSNumber *points;
@property (strong, nonatomic, readonly) NSNumber *qualificationPoints;
@property (strong, nonatomic, readonly) NSString *transactionReason;
@property (strong, nonatomic, readonly) NSString *transactionReasonText;
@property (strong, nonatomic, readonly) NSString *qualificationType;
@property (strong, nonatomic, readonly) NSString *qualificationTypeText;
@property (strong, nonatomic, readonly) NSNumber *actualPoints;
@property (strong, nonatomic, readonly) NSDate *postingDate;
@property (strong, nonatomic, readonly) NSDate *expiryDate;
@property (strong, nonatomic, readonly) NSString *activityID;
@property (strong, nonatomic, readonly) NSString *membershipID;
@property (strong, nonatomic, readonly) NSString *memberID;

@end
