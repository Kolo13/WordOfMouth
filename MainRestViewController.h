//
//  MainRestViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface MainRestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UINavigationBarDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *restaurantArray;

@end
