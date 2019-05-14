//
//  SBMaSpecific.h
//  Super Buy
//
//  Created by Robert Witt on 05.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBMemberActivity;

@interface SBMaSpecific : SBModelObject

@property (strong, nonatomic) SBMemberActivity *activity;

@property (strong, nonatomic, readonly) NSString *pointType;
@property (strong, nonatomic, readonly) NSString *pointTypeText;
@property (strong, nonatomic, readonly) NSNumber *points;
@property (strong, nonatomic, readonly) NSString *qualificationType;
@property (strong, nonatomic, readonly) NSString *qualificationTypeText;
@property (strong, nonatomic, readonly) NSString *productID;
@property (strong, nonatomic, readonly) NSString *productDescription;
@property (strong, nonatomic, readonly) NSNumber *quantity;
@property (strong, nonatomic, readonly) NSString *quantityUnit;
@property (strong, nonatomic, readonly) NSNumber *amount;
@property (strong, nonatomic, readonly) NSString *currency;

@end
