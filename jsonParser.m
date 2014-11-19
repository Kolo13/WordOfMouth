//
//  jsonParser.m
//  GroupProject2nd
//
//  Created by Joshua M. Sacks on 11/19/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "jsonParser.h"

@implementation jsonParser


+ (NSArray *) parseJSONIntoListArray: (NSData *) jsonData {
    NSError* error;
    NSDictionary* dictionaryOfObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSArray* itemsArray = dictionaryOfObjects[@"list"];
    return itemsArray;
    }



@end
