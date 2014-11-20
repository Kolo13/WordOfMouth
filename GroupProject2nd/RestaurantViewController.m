//
//  RestaurantViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "RestaurantViewController.h"
#import "Food.h"
#import "Color.h"
#import "ReviewViewController.h"
#import "RateViewController.h"
#import "FoodTypeCell.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    Food *food1 = [[Food alloc]initName:@"burger" colorInit:[Color color1]];
    Food *food2 = [[Food alloc]initName:@"pho" colorInit:[Color color2]];
    Food *food3 = [[Food alloc]initName:@"pizza" colorInit:[Color color3]];
    //make a network call to generate list of genres for THIS resteraunt
   
    
    
    [[NetworkController sharedManager]getGenresForRest:self.selectedRestaurant.name completionHandler:^(NSArray *list) {
        NSLog(@"Got rest list back...");
        if (list != nil){
            NSMutableArray *newFoods = [[NSMutableArray alloc] initWithCapacity:40];
            for (NSString* foodNames in list) {
                Food *currentFood = [[Food alloc]initName:foodNames colorInit:[Color color1]];
                [newFoods addObject:currentFood];
            }
            
            self.foodRatingArray = newFoods;
        }
        else {
            // NSLog([NSString stringWithFormat:@"Got an array with %lu items back",(unsigned long)self.restaurantArray.count]);
        }
        [self.tableView reloadData];
    }];
}
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    Food *selectedFood = self.foodRatingArray[indexPath.row];
    cell.foodLabel.text = selectedFood.name;
    cell.backgroundColor = selectedFood.cellColor;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.foodRatingArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"REVIEW_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        newVC.selectedRestaurant = self.selectedRestaurant;
        newVC.selectedGenre = self.foodRatingArray[indexPath.row];
        [self.navigationController pushViewController:newVC animated:true];
    }
}

- (IBAction)rateButtonPressed:(id)sender {
    RateViewController*newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RATING_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
    }

}
@end
