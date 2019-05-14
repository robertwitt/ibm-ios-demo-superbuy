//
//  SBRewardProduct.h
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"


@class SBProductCatalog;

@interface SBRewardProduct : SBModelObject

@property (strong, nonatomic) SBProductCatalog *productCatalog;

@property (strong, nonatomic, readonly) NSString *productID;
@property (strong, nonatomic, readonly) NSString *productDescription;
@property (strong, nonatomic, readonly) NSString *category;
@property (strong, nonatomic, readonly) NSString *categoryText;
@property (strong, nonatomic, readonly) NSString *pointType;
@property (strong, nonatomic, readonly) NSString *pointTypeText;
@property (strong, nonatomic, readonly) NSNumber *points;

@end
