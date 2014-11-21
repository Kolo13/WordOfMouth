//
//  RateViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import "Restaurant.h"
#import "MainViewController.h"
#import "Food.h"
#import "Restaurant.h"
#import "averageObject.h"
#import "Review.h"


@interface RateViewController : UIViewController

-(void)createRating:(RateView*)newRating;

- (IBAction)rateSubmissionPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet RateView *rateView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel2;
@property (weak, nonatomic) IBOutlet RateView *rateView2;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel3;
@property (weak, nonatomic) IBOutlet RateView *rateView3;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel4;
@property (weak, nonatomic) IBOutlet RateView *rateView4;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel5;
@property (weak, nonatomic) IBOutlet RateView *rateView5;

@property (weak, nonatomic) IBOutlet UILabel *restaurantLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextField;


@property (nonatomic, strong) averageObject *selectedReview;

@property int rating1;
@property int rating2;
@property int rating3;
@property int rating4;
@property int rating5;
@property Food *selectedFood;
@property Restaurant *selectedRestaurant;
@property (nonatomic, strong) NSMutableArray *catKey;
@property (nonatomic, strong) NSMutableArray *catVal;

@end
