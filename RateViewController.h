//
//  RateViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

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
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@property float rating1;
@property float rating2;
@property float rating3;
@property float rating4;
@property float rating5;


@end
