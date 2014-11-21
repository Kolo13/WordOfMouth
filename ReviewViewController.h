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
#import "averageObject.h"
#import "RateView.h"
@interface ReviewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet RateView *rateView2;
@property (weak, nonatomic) IBOutlet RateView *rateView3;
@property (weak, nonatomic) IBOutlet RateView *rateView4;
@property (weak, nonatomic) IBOutlet RateView *rateView5;

@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel3;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel4;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel5;

@property (nonatomic, strong) Restaurant *selectedRestaurant;
@property (nonatomic, strong) Food *selectedGenre;
@property (nonatomic, strong) NSArray *previousReviews;

@property (nonatomic, strong) NSArray *foodRatingArray;
@property (nonatomic, strong) NSArray *reviewArray;
@property (nonatomic, strong) NSArray *foodCategoryArray;
@property (nonatomic, strong) averageObject *avgRest;

@property (nonatomic, strong) Review *review;
@property (nonatomic, strong) NSMutableArray *catKey;
@property (nonatomic, strong) NSMutableArray *catVal;

@property int rating1;
@property int rating2;
@property int rating3;
@property int rating4;
@property int rating5;

-(void)createRating:(RateView*)newRating;

- (IBAction)rateButtonPressed:(id)sender;


@end
