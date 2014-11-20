//
//  MainViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "MainViewController.h"
#import "Food.h"
#import "FoodViewController.h"
#import "Color.h"
#import "User.h"
#import "FoodTypeCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    Food *food1 = [[Food alloc]initName:@"burger" colorInit:[Color color1]];
    Food *food2 = [[Food alloc]initName:@"pho" colorInit:[Color color2]];
    Food *food3 = [[Food alloc]initName:@"pizza" colorInit:[Color color3]];
    Food *food4 = [[Food alloc]initName:@"sushi" colorInit:[Color color4]];
    Food *food5 = [[Food alloc]initName:@"tacos" colorInit:[Color color5]];
    
    self.fakeData = @[food1, food2, food3, food4, food5];
    
    UINib *nib = [UINib nibWithNibName:@"FoodTypeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FOOD_CELL"];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fakeData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
    Food *selectedFood = self.fakeData[indexPath.row];
    cell.backgroundColor = selectedFood.cellColor;
    cell.foodLabel.text = selectedFood.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FOOD_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
        
    }
    
}





@end
