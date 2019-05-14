//
//  SBCart.h
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBRewardProduct.h"


static NSString *SBCartDidChangeNotification = @"SBCartDidChangeNotification";


@interface SBCart : NSObject

@property (strong, nonatomic, readonly) NSArray *products;
@property (nonatomic, readonly) float sumOfPoints;

- (void)addProduct:(SBRewardProduct *)product;
- (void)removeProduct:(SBRewardProduct *)product;
- (void)clear;

@end
