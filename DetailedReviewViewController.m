//
//  DetailedReviewViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "DetailedReviewViewController.h"

@interface DetailedReviewViewController ()

@end

@implementation DetailedReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catKey = [[NSMutableArray alloc]init];
    self.commentLabel.text = [self.selectedReview comment];
    self.userLabel.text = [self.selectedReview userName];
    
    //int x = 0;
    for (NSDictionary *dictionary in self.selectedReview.categories){
        [self.catKey addObjectsFromArray:[dictionary allKeys]];
    }
    
   // self.catKey = [self.selectedReview.categories allKeys];
   // self.catVal = [self.selectedReview.categories allValues];
    
    self.scoreLabel1.text = self.catKey[0];
    self.scoreLabel2.text = self.catKey[1];
    self.scoreLabel3.text = self.catKey[2];
    self.scoreLabel4.text = self.catKey[3];
    self.scoreLabel5.text = self.catKey[4];
    
}



@end
