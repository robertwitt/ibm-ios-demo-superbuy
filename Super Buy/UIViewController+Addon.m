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

- (void)showSimpleAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:[self localizedString:@"OK"]
                                              otherButtonTitles:nil];
    [alertView show];
}

- (UIAlertView *)loadingAlertWithTitle:(NSString *)title delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:@"\n\n"
                                                       delegate:delegate
                                              cancelButtonTitle:[self localizedString:@"Cancel"]
                                              otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(125, 50, 36, 36);
    [spinner startAnimating];
    
    [alertView addSubview:spinner];
    [alertView show];
    
    return alertView;
}

@end
