//
//  averageObject.h
//  GroupProject2nd
//
//  Created by Joshua M. Sacks on 11/20/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "Food.h"
#import "Restaurant.h"
#import <Foundation/Foundation.h>



//object that contains the Average values for a given resteraunt per data supplied from the server
@interface averageObject : NSObject

@property double avgOverallScore;
@property (nonatomic, strong) NSArray * catAvgArray;
@property int counts;
@property (nonatomic, strong) NSString * genre;
@property (nonatomic, strong) NSString * resteraunt;

+ (NSArray *) parseDictionaryIntoAverageObject: (NSDictionary *) dictionary selectedGenre: (Food *)selectedFood selectedRest: (Restaurant *)selectedRest;
- (instancetype) initWithJSONDictionary: (NSDictionary *) jsonDict;

@end
