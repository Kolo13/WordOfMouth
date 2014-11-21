//
//  ReviewViewController.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "ReviewViewController.h"
#import "RateViewController.h"
#import "CommentCell.h"
#import "DetailedReviewViewController.h"
#import "RatingCategoryCell.h"
#import "Review.h"
#import "NetworkController.h"


@interface ReviewViewController ()

@end

@implementation ReviewViewController


- (void)viewDidLoad {
    [super viewDidLoad];

  [self createRating:self.rateView];
  
  
 //  [self createRating:self.rateView2];
//  [self createRating:self.rateView3];
//  [self createRating:self.rateView4];
//  [self createRating:self.rateView5];
//
  
  
  
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    [self.commentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
    [self.commentTableView registerNib:nib forCellReuseIdentifier:@"COMMENT_CELL"];
  
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[NetworkController sharedManager]getAverageRatingObjectForRest:self.selectedRestaurant selectedFood:self.selectedGenre completionHandler:^(averageObject *avgRest) {
        self.avgRest = avgRest;
        
        self.catKey = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dictionary in self.avgRest.catAvgArray){
            [self.catKey addObjectsFromArray:[dictionary allKeys]];
        }
        self.scoreLabel1.text = self.catKey[0];
        self.scoreLabel2.text = self.catKey[1];
        self.scoreLabel3.text = self.catKey[2];
        self.scoreLabel4.text = self.catKey[3];
        self.scoreLabel5.text = self.catKey[4];
        self.restaurantLabel.text = self.avgRest.resteraunt;
    }];
    //populate self.previousReviews with Review Objects
    [[NetworkController sharedManager] getReviewsForRestInGenre:self.selectedRestaurant selectedFood:self.selectedGenre completionHandler:^(NSArray *list) {
        self.reviewArray = list;
        [self.commentTableView reloadData];
        
    }];
    [self.commentTableView reloadData];
    [self.commentTableView deselectRowAtIndexPath:self.commentTableView.indexPathForSelectedRow animated:true];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviewArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL" forIndexPath:indexPath];
    Review *comment = self.reviewArray[indexPath.row];
        cell.commentLabel.text = comment.comment;
        cell.userLabel.text = comment.userName;
        cell.dateLabel.text = comment.genreName;
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedReviewViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DETAILED_VC"];

    newVC.selectedReview = self.reviewArray[indexPath.row];
    
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
    }
}

- (IBAction)rateButtonPressed:(id)sender {
    RateViewController*newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RATING_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        newVC.selectedFood = self.selectedGenre;
        newVC.selectedRestaurant = self.selectedRestaurant;
        newVC.selectedReview = self.avgRest;
        [self.navigationController pushViewController:newVC animated:true];
    }

}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
  if (rateView.tag == 1){
    [self.rateView setRating:3];

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
  newRating.editable = NO;
  newRating.maxRating = 5;
  newRating.delegate = self;
}



@end





