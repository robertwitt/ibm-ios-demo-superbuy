//
//  SBProductCatalog.h
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBModelObject.h"
#import "SBRewardProduct.h"


@interface SBProductCatalog : SBModelObject

@property (strong, nonatomic, readonly) NSArray *products;
@property (nonatomic, readonly) NSInteger size;

- (NSInteger)numberOfCategories;
- (NSString *)categoryAtIndex:(NSInteger)index;
- (NSInteger)numberOfProductsAtCategoryIndex:(NSInteger)index;
- (NSArray *)productsAtCategoryIndex:(NSInteger)index;
- (SBRewardProduct *)productAtIndexPath:(NSIndexPath *)indexPath;

@end
