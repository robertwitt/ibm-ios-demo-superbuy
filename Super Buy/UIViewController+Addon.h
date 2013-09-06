//
//  UIViewController+Addon.h
//  Super Buy
//
//  Created by Robert Witt on 01.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

@interface UIViewController (Addon)

- (NSString *)localizedString:(NSString *)key;
- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
