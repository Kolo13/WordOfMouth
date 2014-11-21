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
    self.searchBar.barTintColor = [Color color3];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.navigationController.navigationBar.barTintColor = [Color color6];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[NetworkController sharedManager]getList:@"rest" completionHandler:^(NSArray *list) {
        NSLog(@"Got rest list back...");
        if (list != nil){
                NSMutableArray *newPlaces = [[NSMutableArray alloc] initWithCapacity:40];
                for (NSString* restName in list) {
                    Restaurant *currentResteraunt = [[Restaurant alloc]initName:restName latInit:0.0 lonInit:0.0 colorInit:[Color color1]];
                    [newPlaces addObject:currentResteraunt];
                }
            
            //[[Restaurant alloc]initName:self.restaurantArray[indexPath.row]
                
                self.restaurantArray = newPlaces;
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
    NSString *searchText = self.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@", searchText];
    self.filteredArray= [self.restaurantArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restaurantArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESTAURANT_CELL" forIndexPath:indexPath];
    Restaurant *selectedRestaurant = self.restaurantArray[indexPath.row];
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
