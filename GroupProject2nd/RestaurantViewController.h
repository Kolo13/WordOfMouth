//
//  RestaurantViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface RestaurantViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *foodRatingArray;

- (IBAction)rateButtonPressed:(id)sender;



@end
