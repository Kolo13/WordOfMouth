//
//  MainViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkController.h"
#import "User.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *fakeData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *tableData;


@end
