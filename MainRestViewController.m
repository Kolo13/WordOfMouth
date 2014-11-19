//
//  MainRestViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "MainRestViewController.h"
#import "Restaurant.h"
#import "RestaurantViewController.h"
#import "Color.h"
#import "RestaurantCell.h"

@interface MainRestViewController ()

@end

@implementation MainRestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    Restaurant *rest1 = [[Restaurant alloc]initName:@"Pho Bac" latInit:0 lonInit:0 colorInit:nil];
    Restaurant *rest2 = [[Restaurant alloc]initName:@"El Camion" latInit:0 lonInit:0 colorInit:nil];
    Restaurant *rest3 = [[Restaurant alloc]initName:@"Paseo" latInit:0 lonInit:0 colorInit:nil];
    Restaurant *rest4 = [[Restaurant alloc]initName:@"Dick's" latInit:0 lonInit:0 colorInit:nil];
    Restaurant *rest5 = [[Restaurant alloc]initName:@"Pike Place Chowder" latInit:0 lonInit:0 colorInit:nil];
    
    self.restaurantArray = @[rest1, rest2, rest3, rest4, rest5];
    
    UINib *nib = [UINib nibWithNibName:@"RestaurantCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"RESTAURANT_CELL"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restaurantArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESTAURANT_CELL" forIndexPath:indexPath];
    Restaurant *selectedRestaurant = self.restaurantArray[indexPath.row];
    cell.nameLabel.text = selectedRestaurant.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RESTAURANT_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
    }
}



@end
