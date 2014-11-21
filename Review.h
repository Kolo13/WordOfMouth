//
//  Review.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/17/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Restaurant.h"
#import "Food.h"

@interface Review : NSObject

@property Restaurant *restaurant;
@property (nonatomic, strong) NSString *genreName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *comment;
@property  NSInteger overallRating;
@property (nonatomic, strong) NSDictionary *categories;


- (instancetype) initWithJSONDictionary: (NSDictionary *) jsonDict;
+ (NSArray *) parseDictionaryIntoArrayOfReviews: (NSDictionary *) dictionary selectedGenre: (Food *)selectedFood selectedRest: (Restaurant *)selectedRest;

@end
