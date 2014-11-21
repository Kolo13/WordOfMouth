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

@property (nonatomic, strong) NSArray *colors;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.navigationController.navigationBar.barTintColor = [Color color6];
  
    self.colors = @[[Color color1], [Color color2], [Color color3],[Color color4], [Color color5], [Color color4], [Color color3], [Color color2]];

    [[NetworkController sharedManager]getList:@"genre" completionHandler:^(NSArray *list) {
        NSLog(@"Got genre list back...");
        if (list != nil){
            NSMutableArray *newFoods = [[NSMutableArray alloc] initWithCapacity:40];
            for (NSString* foodNames in list) {
                Food *currentFood = [[Food alloc]initName:foodNames colorInit:[Color color1]];
                [newFoods addObject:currentFood];
            }
            self.tableData = newFoods;
        }
        else {
            NSLog([NSString stringWithFormat:@"Got an array with %lu items back",(unsigned long)self.tableData.count]);
        }
        [self.tableView reloadData];
    }];
    
    UINib *nib = [UINib nibWithNibName:@"FoodTypeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FOOD_CELL"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    


    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
     Food *selectedFood = self.tableData[indexPath.row];
    cell.foodLabel.text = selectedFood.name;
    
    NSInteger index = indexPath.row % self.colors.count;
    cell.backgroundColor = self.colors[index];
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FOOD_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        newVC.selectedFood = self.tableData[indexPath.row];
        [self.navigationController pushViewController:newVC animated:true];
    }
    
}





@end
