//
//  SBProductCatalog.m
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBProductCatalog.h"


@interface SBProductCatalog ()

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSDictionary *productDict;

- (void)initializeCatalog;

@end


#pragma mark -

@implementation SBProductCatalog

- (id)initWithJsonData:(NSDictionary *)jsonData header:(SBModelObject *)header
{
    self = [super initWithJsonData:jsonData header:header];
    
    // Parse reward products
    NSMutableArray *products = [NSMutableArray array];
    id prodData = [jsonData objectForKey:@"item"];
    
    if ([prodData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *prodDate in prodData) {
            SBRewardProduct *product = [[SBRewardProduct alloc] initWithJsonData:prodDate header:self];
            [products addObject:product];
        }
    } else {
        SBRewardProduct *product = [[SBRewardProduct alloc] initWithJsonData:prodData header:self];
        [products addObject:product];
    }
    _products = products;
    
    [self initializeCatalog];
    
    return self;
}

- (void)initializeCatalog
{
    NSMutableArray *categories = [NSMutableArray array];
    NSMutableDictionary *products = [NSMutableDictionary dictionary];
    
    for (SBRewardProduct *product in self.products) {

        NSString *category = product.categoryText;
        NSMutableArray *productsPerCategory = [products objectForKey:category];
        
        if (productsPerCategory) {
            [productsPerCategory addObject:product];
        }
        else {
            productsPerCategory = [NSMutableArray arrayWithObject:product];
            [products setObject:productsPerCategory forKey:category];
            [categories addObject:category];
        }
    }
    
    _categories = categories;
    _productDict = products;
}

- (NSInteger)numberOfCategories
{
    return self.categories.count;
}

- (NSString *)categoryAtIndex:(NSInteger)index
{
    return [self.categories objectAtIndex:index];
}

- (NSInteger)numberOfProductsAtCategoryIndex:(NSInteger)index
{
    return [self productsAtCategoryIndex:index].count;
}

- (NSArray *)productsAtCategoryIndex:(NSInteger)index
{
    NSString *category = [self categoryAtIndex:index];
    NSArray *products = [self.productDict objectForKey:category];
    
    return products;
}

- (SBRewardProduct *)productAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *products = [self productsAtCategoryIndex:indexPath.section];
    return [products objectAtIndex:indexPath.row];
}

@end
