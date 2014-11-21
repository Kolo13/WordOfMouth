//
//  RateViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "RateViewController.h"
#import "Restaurant.h"
#import "NetworkController.h"
@interface RateViewController ()


@end

@implementation RateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [NetworkController sharedManager];
  [self createRating:self.rateView];
  [self createRating:self.rateView2];
  [self createRating:self.rateView3];
  [self createRating:self.rateView4];
  [self createRating:self.rateView5];


}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
  if (rateView.tag == 1){
     self.rating1 = rating;
  }else if (rateView.tag == 2){
    self.rating2 = rating;
  }else if (rateView.tag == 3){
    self.rating3 = rating;
  }else if (rateView.tag == 4){
    self.rating4 = rating;
  }else if (rateView.tag == 5){
    self.rating5 = rating;
  }


}

-(void)createRating:(RateView*)newRating{
  newRating.notSelectedImage = [UIImage imageNamed:@"dot_empty.png"];
  newRating.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
  newRating.fullSelectedImage = [UIImage imageNamed:@"dot_selected.png"];
  newRating.rating = 0;
  newRating.editable = YES;
  newRating.maxRating = 5;
  newRating.delegate = self;
}

- (IBAction)rateSubmissionPressed:(id)sender {
  
  UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Rating Submitted" message:nil preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [self.navigationController popViewControllerAnimated:YES];

  }];
  
  [loginAlert addAction:ok];
  
  
  [self presentViewController:loginAlert animated:true completion:nil];

  
    

}
@end
