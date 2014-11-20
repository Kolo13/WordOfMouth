//
//  ReviewViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "MainViewController.h"
#import "Food.h"

@interface ReviewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *foodRatingTableView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (nonatomic, strong) Restaurant *selectedRestaurant;
@property (nonatomic, strong) Food *selectedGenre;
@property (nonatomic, strong) NSArray *previousRatings;


@end
