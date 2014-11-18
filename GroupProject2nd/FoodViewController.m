
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

@interface FoodViewController ()

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
//    self.mapView.showsUserLocation = YES;
//    
    
//    Restaurant *phoBac = [[Restaurant alloc] initName:@"Pho Bac" latInit: 39.3148178201756 lonInit:-99.4621411360279];
//    Restaurant *sushiLand = [[Restaurant alloc] initName:@"sushiLand" latInit:39.298878761661 lonInit:-99.4662610094639];
//    Restaurant *paseo = [[Restaurant alloc] initName:@"paseo" latInit:39.5148178201756 lonInit:-99.4662610094639];
//    Restaurant *elCamion = [[Restaurant alloc] initName:@"elCamion" latInit:39.4148178201756 lonInit:-99.4662610094639];
    
    Restaurant *test = [[Restaurant alloc] initName:@"test" latInit:39.3148178201756 lonInit:-99.4621411360279 colorInit:[Color colorForSomePurpose]];
    

    self.fakeRestaurantArray = @[test];
    
    for (Restaurant *restaurants in self.fakeRestaurantArray) {
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fakeRestaurantArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"REST_CELL" forIndexPath:indexPath];
    Restaurant *selectedFood = self.fakeRestaurantArray[indexPath.row];
    cell.textLabel.text = selectedFood.name;
    cell.backgroundColor = selectedFood.cellColor;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:(@"REST_VC")];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
        
    }
}
@end
