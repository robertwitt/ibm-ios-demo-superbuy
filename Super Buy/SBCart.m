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

- (void)notifyObservers;

@end


@implementation SBCart

- (NSArray *)products
{
    return self.cartProducts;
}

- (float)sumOfPoints
{
    __block float sum;
    [self.products enumerateObjectsUsingBlock:^(SBRewardProduct *product, NSUInteger idx, BOOL *stop) {
        sum = sum + product.points.floatValue;
    }];
    
    return sum;
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
    [self notifyObservers];
}

- (void)removeProduct:(SBRewardProduct *)product
{
    [self.cartProducts removeObject:product];
    [self notifyObservers];
}

- (void)clear
{
    [self.cartProducts removeAllObjects];
    [self notifyObservers];
}

- (void)notifyObservers
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SBCartDidChangeNotification
                                                        object:self];
}

@end
