//
//  RateViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "RateViewController.h"

@interface RateViewController ()


@end

@implementation RateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.rateView.notSelectedImage = [UIImage imageNamed:@"dot_empty.png"];
  self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
  self.rateView.fullSelectedImage = [UIImage imageNamed:@"dot_selected.png"];
  self.rateView.rating = 0;
  self.rateView.editable = YES;
  self.rateView.maxRating = 5;
  self.rateView.delegate = self;
  
  self.rateView2.notSelectedImage = [UIImage imageNamed:@"dot_empty.png"];
  self.rateView2.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
  self.rateView2.fullSelectedImage = [UIImage imageNamed:@"dot_selected.png"];
  self.rateView2.rating = 0;
  self.rateView2.editable = YES;
  self.rateView2.maxRating = 5;
  self.rateView2.delegate = self;
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
     self.scoreLabel1.text = [NSString stringWithFormat:@"%f", rating];

}


- (IBAction)rateSubmissionPressed:(id)sender {
}
@end
