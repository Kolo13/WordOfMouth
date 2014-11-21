//
//  RateViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "RateViewController.h"
#import "NetworkController.h"
#import "Review.h"
@interface RateViewController ()


@end

@implementation RateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self createRating:self.rateView];
  [self createRating:self.rateView2];
  [self createRating:self.rateView3];
  [self createRating:self.rateView4];
  [self createRating:self.rateView5];
    
    
    self.catKey = [[NSMutableArray alloc]init];
    //int x = 0;
    for (NSDictionary *dictionary in self.selectedReview.catAvgArray){
        [self.catKey addObjectsFromArray:[dictionary allKeys]];
    }
    
    self.scoreLabel1.text = self.catKey[0];
    self.scoreLabel2.text = self.catKey[1];
    self.scoreLabel3.text = self.catKey[2];
    self.scoreLabel4.text = self.catKey[3];
    self.scoreLabel5.text = self.catKey[4];
   
    self.restaurantLabel.text = self.selectedReview.resteraunt;
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
  if (rateView.tag == 1){
//     self.scoreLabel1.text = [NSString stringWithFormat:@"%f", rating];
//  }else if (rateView.tag == 2){
//    self.scoreLabel2.text = [NSString stringWithFormat:@"%f", rating];
//  }else if (rateView.tag == 3){
//    self.scoreLabel3.text = [NSString stringWithFormat:@"%f", rating];
//  }else if (rateView.tag == 4){
//    self.scoreLabel4.text = [NSString stringWithFormat:@"%f", rating];
//  }else if (rateView.tag == 5){
//    self.scoreLabel5.text = [NSString stringWithFormat:@"%f", rating];
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
}
@end
