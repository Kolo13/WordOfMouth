
//
//  FoodViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "FoodViewController.h"
#import "RestaurantViewController.h"
#import "Color.h"
#import "ReviewViewController.h"
#import "RestaurantCell.h"

@interface FoodViewController ()
@property (nonatomic, strong) NSArray *colors;

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.searchBar.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UINib *nib = [UINib nibWithNibName:@"RestaurantCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FOOD_CELL"];

    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
//    self.mapView.showsUserLocation = YES;
//
    
    Restaurant *test1 = [[Restaurant alloc] initName:@"Pho Bac" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color color1]];
    Restaurant *test2 = [[Restaurant alloc] initName:@"Tamarind Tree" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color color2]];
    Restaurant *test3 = [[Restaurant alloc] initName:@"Long Provincial" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color color3]];
    Restaurant *test4 = [[Restaurant alloc] initName:@"Green Leaf" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color color4]];
    Restaurant *test5 = [[Restaurant alloc] initName:@"Super Divey Pho" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color color5]];
    
    self.colors = @[[Color color1], [Color color2], [Color color3],[Color color4], [Color color5], [Color color4], [Color color3], [Color color2], [Color color1]];

    self.fakeRestaurantArray = @[test1, test2, test3, test4, test5];
    
    [[NetworkController sharedManager]getRestforGenres:self.selectedFood.name completionHandler:^(NSArray *list) {
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
    
    for (Restaurant *restaurants in self.restaurantArray) {
        CLLocationDegrees latDegree =  restaurants.latitude;
        CLLocationDegrees lonDegree =  restaurants.longitude;
        
        CLLocationDegrees latDelta = 1.0;
        CLLocationDegrees lonDelta = 1.0;
        MKCoordinateSpan span = MKCoordinateSpanMake(latDelta, lonDelta);
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latDegree, lonDegree);
        MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
        
        [self.mapView setRegion:region];
        
        CLLocationCoordinate2D pinLocation = CLLocationCoordinate2DMake(latDegree, lonDegree);
        MKPointAnnotation *objectAnnotation = [[MKPointAnnotation alloc]init];
        objectAnnotation.coordinate = pinLocation;
        objectAnnotation.title = restaurants.name;
        [self.mapView addAnnotation:objectAnnotation];
    }

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurantArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    Restaurant *selectedRest = self.restaurantArray[indexPath.row];
    cell.nameLabel.text = selectedRest.name;
    
    NSInteger index = indexPath.row % self.colors.count;
    cell.backgroundColor = self.colors[index];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReviewViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:(@"REVIEW_VC")];
    if ([newVC isKindOfClass:[UIViewController class]]){
        newVC.selectedRestaurant = self.restaurantArray[indexPath.row];
        newVC.selectedGenre = self.selectedFood;
        [self.navigationController pushViewController:newVC animated:true];
        
    }
    
    
}
@end
