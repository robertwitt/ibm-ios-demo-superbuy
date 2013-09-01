//
//  UIViewController+Addon.m
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "UIViewController+Addon.h"


@implementation UIViewController (Addon)

- (NSString *)localizedString:(NSString *)key
{
    return NSLocalizedString(key, nil);
}

@end
