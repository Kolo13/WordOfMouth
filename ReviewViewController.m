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
    
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;

    UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
    [self.commentTableView registerNib:nib forCellReuseIdentifier:@"COMMENT_CELL"];
    
    
  
    self.foodRatingArray = @[@"Food Label 1", @"Food Label 2", @"Food Label 3"];
    
    //populate self.previousReviews with Review Objects
    [[NetworkController sharedManager] getReviewsForRestInGenre:self.selectedRestaurant selectedFood:self.selectedGenre completionHandler:^(NSArray *list) {
        self.previousReviews = list;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [self.commentTableView deselectRowAtIndexPath:self.commentTableView.indexPathForSelectedRow animated:true];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodRatingArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COMMENT_CELL" forIndexPath:indexPath];
    
        cell.commentLabel.text = @"Given that, the short menu seems like an afterthought — maybe some nibbles to accompany your Chateau ";
        cell.userLabel.text = @"teapain";
        cell.dateLabel.text = @"11/23/14";
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedReviewViewController *newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DETAILED_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
    }
}

- (IBAction)rateButtonPressed:(id)sender {
    RateViewController*newVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RATING_VC"];
    if ([newVC isKindOfClass:[UIViewController class]]){
        [self.navigationController pushViewController:newVC animated:true];
    }

}


@end





