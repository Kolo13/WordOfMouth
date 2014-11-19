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
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setContentOffset:CGPointMake(0.0, self.tableView.tableHeaderView.frame.size.height) animated:YES];
    
    self.fakeData = @[@"pho", @"burgers", @"pasta", @"ramen", @"sashimi", @"steak"];
    [[NetworkController sharedManager]createNewUser:[User DictSerialization] completionHandler:^(bool *success) {
        if (success) {
             NSLog(@"Completed");
        }
        else if (!success) {
             NSLog(@"Failed");
        }
        else {
            NSLog(@"Now I don't have a fucking clue");
        }
    }];
    
    [[NetworkController sharedManager]getList:@"genre" completionHandler:^(NSArray *list) {
        NSLog(@"Got list back...");
        if (list != nil){
            self.tableData = list;
        }
        else {
            NSLog([NSString stringWithFormat:@"Got an array with %lu items back",(unsigned long)self.tableData.count]);
        }
        [self.tableView reloadData];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
    [self.tableView setContentOffset:CGPointMake(0, 44)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FOOD_CELL" forIndexPath:indexPath];
     NSString *selectedFood = self.tableData[indexPath.row];
    cell.textLabel.text = selectedFood;
    cell.backgroundColor = [Color colorForSomePurpose];
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   FoodViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:(@"FOOD_VC")];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
        
    }
    
}





@end
