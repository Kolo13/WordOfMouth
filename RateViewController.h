//
//  RateViewController.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateViewController : UIViewController

- (IBAction)rateSubmissionPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel1;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel2;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel3;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel4;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel5;



@end
