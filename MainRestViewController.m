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
#import "MainViewController.h"

@interface MainRestViewController ()
@property (nonatomic, strong) NSArray *colors;
@end

@implementation MainRestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    [[NetworkController sharedManager]createNewUser:[User DictSerialization] completionHandler:^(bool success) {
//        if (success) {
//            NSLog(@"Completed");
//        }
//        else if (!success) {
//            NSLog(@"Failed");
//        }
//        else {
//            NSLog(@"Now I don't have a fucking clue");
//        }
//    }];

   // self.restaurantArray = @[rest1, rest2, rest3, rest4, rest5];
    [[NetworkController sharedManager]getList:@"rest" completionHandler:^(NSArray *list) {
        NSLog(@"Got rest list back...");
        if (list != nil){
            self.restaurantArray = list;
        }
        else {
           // NSLog([NSString stringWithFormat:@"Got an array with %lu items back",(unsigned long)self.restaurantArray.count]);
        }
        [self.tableView reloadData];
    }];
    
    self.colors = @[[Color color1], [Color color2], [Color color3],[Color color4], [Color color5], [Color color4], [Color color3], [Color color2]];
    
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
    Restaurant *selectedRestaurant = [[Restaurant alloc]initName:self.restaurantArray[indexPath.row] latInit:0 lonInit:0 colorInit:nil];
    cell.nameLabel.text = selectedRestaurant.name;
    NSInteger index = indexPath.row % self.colors.count;
    cell.backgroundColor = self.colors[index];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RESTAURANT_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
      newVC.selectedRestaurant = self.restaurantArray[indexPath.row];
        [self.navigationController pushViewController:newVC animated:true];
    }
}



@end
