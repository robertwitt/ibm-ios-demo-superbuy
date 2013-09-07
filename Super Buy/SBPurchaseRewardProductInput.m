//
//  SBPurchaseRewardProductInput.m
//  Super Buy
//
//  Created by Robert Witt on 07.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBPurchaseRewardProductInput.h"


@implementation SBPurchaseRewardProductInput

- (NSDictionary *)jsonData
{
    NSMutableArray *itemsJson = [NSMutableArray array];
    
    for (SBPurchaseItem *item in self.items) {
        NSDictionary *itemJson = [NSDictionary dictionaryWithObjectsAndKeys:item.productID, @"productID",
                                                                            item.quantity, @"quantity",
                                                                            item.quantityUnit, @"quantityUnit",
                                                                            nil];
        [itemsJson addObject:itemJson];
    }
    
    NSDictionary *jsonData = [NSDictionary dictionaryWithObjectsAndKeys:self.membershipID, @"membershipID",
                                                                        itemsJson, @"items",
                                                                        nil];
    return jsonData;
}

@end


@implementation SBPurchaseItem

- (id)init
{
    self = [super init];
    
    self.productID = @"";
    self.quantity = [NSNumber numberWithInt:0];
    self.quantityUnit = @"";
    
    return self;
}

@end