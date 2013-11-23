//
//  SBCart.m
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBCart.h"


@interface SBCart ()

@property (strong, nonatomic) NSMutableArray *cartProducts;

@end


@implementation SBCart

- (NSArray *)products
{
    return self.cartProducts;
}

- (float)sumOfPoints
{
    return [[self.products valueForKeyPath:@"sum.points"] floatValue];
}

- (NSMutableArray *)cartProducts
{
    if (!_cartProducts) {
        _cartProducts = [[NSMutableArray alloc] init];
    }
    return _cartProducts;
}

- (void)addProduct:(SBRewardProduct *)product
{
    [self.cartProducts addObject:product];
}

- (void)removeProduct:(SBRewardProduct *)product
{
    [self.cartProducts removeObject:product];
}

- (void)clear
{
    [self.cartProducts removeAllObjects];
}

@end
