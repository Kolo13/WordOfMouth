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
#import "Food.h"
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

    [self submitRating];
  UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Rating Submitted" message:nil preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
    [self.navigationController popViewControllerAnimated:YES];
    
  }];
  
  [loginAlert addAction:ok];
  
  if (self.rating1 && self.rating2 && self.rating3 && self.rating4 && self.rating5) {
    [self presentViewController:loginAlert animated:true completion:nil];
  }

  
  
    

}

- (void)submitRating {
   // post body must contain {"restaurant": "testaurant","rating": [5,5,5,2,4], "genre": "burger", "str": "testing add a comment1"}
    NSArray *ratingArray = @[[NSNumber numberWithInt:self.rating1], [NSNumber numberWithInt:self.rating2], [NSNumber numberWithInt:self.rating3], [NSNumber numberWithInt:self.rating4], [NSNumber numberWithInt:self.rating5]];
        NSDictionary* dictToSubmit = @{
                                          @"restaurant": self.selectedRestaurant.name,
                                          @"rating": ratingArray,
                                          @"genre": self.selectedFood.name,
                                          @"str" : self.commentTextField.text
                                          };
    [[NetworkController sharedManager] submitNewReview:dictToSubmit completionHandler:^(bool success) {
        if (success) {
            NSLog(@"Post Successful!");
                  } else {
                      NSLog(@"Post Fail");
                  }
    }];
//    NSDictionary* dictionary0 = @{self.catVal[0] : [NSNumber numberWithInt:self.rating1]};
//    NSDictionary* dictionary1 = @{self.catVal[1] : [NSNumber numberWithInt:self.rating2]};
//    NSDictionary* dictionary2 = @{self.catVal[2] : [NSNumber numberWithInt:self.rating3]};
//    NSDictionary* dictionary3 = @{self.catVal[3] : [NSNumber numberWithInt:self.rating4]};
//    NSDictionary* dictionary4 = @{self.catVal[4] : [NSNumber numberWithInt:self.rating5]};
//    NSArray* catArray =@[dictionary0, dictionary1, dictionary2, dictionary3, dictionary4];
    
    
    
    
}
    @end
