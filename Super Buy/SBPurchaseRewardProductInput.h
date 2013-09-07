//
//  SBPurchaseRewardProductInput.h
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

@interface SBPurchaseRewardProductInput : NSObject

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *membershipID;
@property (strong, nonatomic, readonly) NSDictionary *jsonData;

@end


@interface SBPurchaseItem : NSObject

@property (strong, nonatomic) NSString *productID;
@property (strong, nonatomic) NSNumber *quantity;
@property (strong, nonatomic) NSString *quantityUnit;

@end