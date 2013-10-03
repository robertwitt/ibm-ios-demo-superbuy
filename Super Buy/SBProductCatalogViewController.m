//
//  SBProductCatalogViewController.m
//  Super Buy
//
//  Created by Robert Witt on 06.09.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//

#import "SBProductCatalogViewController.h"
#import "SBPersistenceAPI.h"


static NSString *SBCellProduct = @"ProductCell";


@interface SBProductCatalogViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) SBProductCatalog *productCatalog;
@property (strong, nonatomic) SBRewardProduct *purchasedProduct;
@property (strong, nonatomic) UIAlertView *loadingAlert;

- (SBPurchaseRewardProductInput *)inputFromProduct:(SBRewardProduct *)product;
- (void)startGettingRewardProductCatalog;
- (void)stopGettingRewardProductCatalog;
- (void)startRewardPurchase;
- (void)stopRewardPurchase;

@end


#pragma mark -

@implementation SBProductCatalogViewController


#pragma mark Managing the View

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.productCatalog) {
        [self startGettingRewardProductCatalog];
    }
}


#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.productCatalog numberOfCategories];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productCatalog numberOfProductsAtCategoryIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBRewardProduct *product = [self.productCatalog productAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SBCellProduct forIndexPath:indexPath];
    cell.textLabel.text = product.productDescription;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", product.points];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.productCatalog categoryAtIndex:section];
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    self.purchasedProduct = [self.productCatalog productAtIndexPath:indexPath];
    
    NSString *message = [self localizedString:@"Do you want to order the product? This would cost you %@ points."];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.purchasedProduct.productDescription
                                                        message:[NSString stringWithFormat:message, self.purchasedProduct.points]
                                                       delegate:self
                                              cancelButtonTitle:[self localizedString:@"Cancel"]
                                              otherButtonTitles:[self localizedString:@"Order"], nil];
    [alertView show];
}


#pragma mark Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self startRewardPurchase];
    }
    
    self.purchasedProduct = nil;
}


#pragma mark Web API delegate

- (void)startGettingRewardProductCatalog
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Loading ..."] delegate:self];
    [self.webAPI connectToBackend];
}

- (void)stopGettingRewardProductCatalog
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)startRewardPurchase
{
    self.loadingAlert = [self loadingAlertWithTitle:[self localizedString:@"Processing ..."] delegate:self];
    SBPurchaseRewardProductInput *input = [self inputFromProduct:self.purchasedProduct];
    [self.webAPI purchaseRewardProductWithInput:input];
}

- (void)stopRewardPurchase
{
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)backendConnectionEstablished
{
    [self.webAPI getRewardProductCatalog:nil];
}

- (void)backendConnectionFailedWithError:(NSError *)error
{
    [super backendConnectionFailedWithError:error];
    [self.loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
    self.loadingAlert = nil;
}

- (void)webAPI:(SBWebAPI *)webAPI didGetRewardProductCatalogWithOutput:(SBGetRewardProductCatalogOutput *)output
{
    [self stopGettingRewardProductCatalog];
    self.productCatalog = output.productCatalog;
    [self.tableView reloadData];
    
    if (self.productCatalog.size == 0) {
        [self showSimpleAlertWithTitle:[self localizedString:@"Sorry"]
                               message:[output.messages.allInfoMessages.lastObject text]];
    }
}

- (void)webAPI:(SBWebAPI *)webAPI didFailGettingRewardProductCatalogWithInput:(SBGetRewardProductCatalogInput *)input error:(NSError *)error
{
    // TODO Implement method
}

- (void)webAPI:(SBWebAPI *)webAPI didPurchaseRewardProductWithOutput:(SBPurchaseRewardProductOutput *)output
{
    [self stopRewardPurchase];
    
    SBPointTransaction *transaction = output.transactions.lastObject;
    
    if (transaction) {
        NSString *message = [self localizedString:@"The product is on its way to you. We charged your account %@ points for this purchase."];
        [self showSimpleAlertWithTitle:[self localizedString:@"Order complete"]
                               message:[NSString stringWithFormat:message, transaction.actualPoints]];
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

- (SBPurchaseRewardProductInput *)inputFromProduct:(SBRewardProduct *)product
{
    SBPurchaseItem *item = [[SBPurchaseItem alloc] init];
    item.productID = product.productID;
    item.quantity = @1;
    item.quantityUnit = @"ST";
    
    SBPurchaseRewardProductInput *input = [[SBPurchaseRewardProductInput alloc] init];
    input.membershipID = [[SBPersistenceAPI sharedInstance] readMembershipCredentials].membershipID;
    input.items = @[item];
    
    return input;
}

@end
