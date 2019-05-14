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
                                                        message:@""
                                                       delegate:delegate
                                              cancelButtonTitle:[self localizedString:@"Cancel"]
                                              otherButtonTitles:nil];
    
    // iOS 7: addSubview: on an UIAlertView seems to be deprecated. Removed the spinner from loading alert.
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.frame = CGRectMake(125, 50, 36, 36);
//    [spinner startAnimating];
//    
//    [alertView addSubview:spinner];

    [alertView show];
    
    return alertView;
}

@end
