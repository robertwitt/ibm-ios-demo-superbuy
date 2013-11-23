//
//  SBCartViewController.m
//  Super Buy
//
//  Created by Robert Witt on 23.11.13.
//  Copyright (c) 2013 Robert Witt. All rights reserved.
//  Version 1.1
//

#import "SBCartViewController.h"


@interface SBCartViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *pointsItem;

@end


#pragma mark -

@implementation SBCartViewController


#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.toolbarHidden = NO;
    //[self.tableView beginUpdates];
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
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@", product.points];
    
    return cell;
}


#pragma mark Actions

- (IBAction)onCancel:(id)sender
{
    
}

- (IBAction)onClear:(id)sender
{
    
}

- (IBAction)onOrder:(id)sender
{
    
}

@end
