//
//  SBCartViewController.m
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//  Version 1.1
//

#import "SBCartViewController.h"
#import "SBPersistenceAPI.h"


@interface SBCartViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pointsItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *orderButton;
@property (strong, nonatomic) UIAlertView *loadingAlert;

- (void)updatePointsItem;
- (void)onCartDidChangeNotification:(NSNotification *)notification;
- (SBPurchaseRewardProductInput *)inputFromProducts:(NSArray *)products;
- (void)startRewardPurchase;
- (void)stopRewardPurchase;

@end


#pragma mark -

@implementation SBCartViewController


#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
    self.tableView.editing = YES;
    [self updatePointsItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCartDidChangeNotification:)
                                                 name:SBCartDidChangeNotification
                                               object:self.cart];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cart.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBRewardProduct *product = [self.cart.products objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartItemCell"];
    cell.textLabel.text = product.productDescription;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%.2f", product.points.floatValue];
    
    return cell;
}


#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SBRewardProduct *product = [self.cart.products objectAtIndex:indexPath.row];
        [self.cart removeProduct:product];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark Actions

- (IBAction)onCancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cartViewControllerDidCancel:)]) {
        [self.delegate cartViewControllerDidCancel:self];
    }
}

- (IBAction)onClear:(id)sender
{
    [self.cart clear];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if ([self.delegate respondsToSelector:@selector(cartViewController:didClearCart:)]) {
        [self.delegate cartViewController:self didClearCart:self.cart];
    }
}

- (IBAction)onOrder:(id)sender
{
    [self startRewardPurchase];
}

- (void)updatePointsItem
{
    self.pointsItem.title = [[NSString alloc] initWithFormat:@"%.2f points", self.cart.sumOfPoints];
}

- (void)onCartDidChangeNotification:(NSNotification *)notification
{
    [self updatePointsItem];
    self.orderButton.enabled = (self.cart.products.count > 0);
}


#pragma mark Web API Delegate

- (SBPurchaseRewardProductInput *)inputFromProducts:(NSArray *)products
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    [products enumerateObjectsUsingBlock:^(SBRewardProduct *product, NSUInteger idx, BOOL *stop) {
        SBPurchaseItem *item = [[SBPurchaseItem alloc] init];
        item.productID = product.productID;
        item.quantity = @1;
        item.quantityUnit = @"ST";
        [items addObject:item];
    }];
    
    SBPurchaseRewardProductInput *input = [[SBPurchaseRewardProductInput alloc] init];
    input.membershipID = [[SBPersistenceAPI sharedInstance] readMembershipCredentials].membershipID;
    input.items = items;
    
    return input;
}

- (void)startRewardPurchase
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Processing ..."] delegate:self];
    SBPurchaseRewardProductInput *input = [self inputFromProducts:self.cart.products];
    [self.webAPI purchaseRewardProductWithInput:input];
}

- (void)stopRewardPurchase
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)webAPI:(SBWebAPI *)webAPI didPurchaseRewardProductWithOutput:(SBPurchaseRewardProductOutput *)output
{
    [self stopRewardPurchase];
    
    __block float totalPoints;
    [output.transactions enumerateObjectsUsingBlock:^(SBPointTransaction *transaction, NSUInteger idx, BOOL *stop) {
        totalPoints += transaction.actualPoints.floatValue;
    }];
    
    if (output.transactions.count > 0) {
        NSString *message = [self localizedString:@"The delivery is on its way to you. We charged your account %.2f points for this purchase."];
        [self showSimpleAlertWithTitle:[self localizedString:@"Order complete"]
                               message:[NSString stringWithFormat:message, totalPoints]];
        
        if ([self.delegate respondsToSelector:@selector(cartViewController:didOrderCart:)]) {
            [self.delegate cartViewController:self didOrderCart:self.cart];
        }
    }
    else {
        [self showSimpleAlertWithTitle:[self localizedString:@"Error"]
                               message:output.messages.firstImportantMessage.text];
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailPurchasingRewardProductWithInput:(SBPurchaseRewardProductInput *)input error:(NSError *)error
{
    // TODO Implement method
}

@end
