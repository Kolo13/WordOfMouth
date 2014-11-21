//
//  ReviewViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h"
#import "Restaurant.h"
#import "MainViewController.h"
#import "Food.h"

@interface ReviewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel3;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel4;
@property (weak, nonatomic) IBOutlet UIView *scoreLabel5;
@property (nonatomic, strong) Restaurant *selectedRestaurant;
@property (nonatomic, strong) Food *selectedGenre;
@property (nonatomic, strong) NSArray *previousReviews;

@property (nonatomic, strong) NSArray *foodRatingArray;
@property (nonatomic, strong) NSArray *commentArray;
@property (nonatomic, strong) NSArray *foodCategoryArray;

- (IBAction)rateButtonPressed:(id)sender;


@end
