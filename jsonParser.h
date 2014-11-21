//
//  jsonParser.h
//  GroupProject2nd
//
//  Created by Joshua M. Sacks on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"
#import "averageObject.h"

@interface jsonParser : NSObject

+ (NSArray *) parseJSONIntoListArray: (NSData *) jsonData;
+ (BOOL) extractJWTTokenAndStoreIt: (NSData *) jsonData;
+ (NSDictionary *) parseJSONIntoReviewDictionary: (NSData *) jsonData selectedGenre: (Food *) selectedFood;
+ (averageObject *) parseJSONIntoAvgReviewObject: (NSData *) jsonData;

@end
