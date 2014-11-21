//
//  Review.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/17/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype) initWithJSONDictionary: (NSDictionary *) jsonDict {
    self = [self init];
    if (self) {
        NSArray * values = [jsonDict allValues];
        self.categories = [jsonDict objectForKey:@"catsArray"];
        self.restaurant = [jsonDict objectForKey:@"rest"];
        self.genreName = [jsonDict objectForKey:@"genre"];
        self.userName = [jsonDict objectForKey:@"user"];
        self.comment = [jsonDict objectForKey:@"str"];
      //  self.overallRating = [int [[jsonDict objectForKey:@"overallScore"] ]];
    }
    
    //genre is genreName
    //user is userName
    //str is comment
    //catsArray is categories
    //rest is restaurant
    //overallScore is score
    return self;
}

+ (NSArray *) parseDictionaryIntoArrayOfReviews: (NSDictionary *) dictionary selectedGenre: (Food *)selectedFood selectedRest: (Restaurant *)selectedRest {
    NSMutableArray * list = [[NSMutableArray alloc]init];
    for (id key in dictionary) {
        Review * currentReview = [[Review alloc]initWithJSONDictionary:key];
        currentReview.restaurant = selectedRest;
        if ([currentReview.genreName isEqualToString:selectedFood.name]) {
          [list addObject:currentReview];
        } else {
            NSLog(@"%@ didn't match the desired genre %@", currentReview.genreName, selectedFood.name);
        }
        
        
        
        
};
   // NSMutableArray * list = [[NSMutableArray alloc]init];
    
    
    
    return list;
    
}

@end
