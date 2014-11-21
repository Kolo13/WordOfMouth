//
//  averageObject.m
//  GroupProject2nd
//
//  Created by Joshua M. Sacks on 11/20/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "averageObject.h"

@implementation averageObject

- (instancetype) initWithJSONDictionary: (NSDictionary *) jsonDict {
    self = [self init];
    if (self) {
        self.catAvgArray = [jsonDict objectForKey:@"catAvgArray"];
        self.resteraunt = [jsonDict objectForKey:@"restaurant"];
        self.avgOverallScore = [[jsonDict objectForKey:@"avgOverallScore"] doubleValue];
        self.counts = [[jsonDict objectForKey:@"counts"] intValue];
        self.genre = [jsonDict objectForKey:@"genre"];
    }
    
    return self;
}

+ (NSArray *) parseDictionaryIntoAverageObject: (NSDictionary *) dictionary selectedGenre: (Food *)selectedFood selectedRest: (Restaurant *)selectedRest {
    NSMutableArray * list = [[NSMutableArray alloc]init];
    NSDictionary *avgDictionary = [dictionary objectForKey:@"avgObject"];
    
    // NSMutableArray * list = [[NSMutableArray alloc]init];
    
    
    
    return list;
    
}

@end

