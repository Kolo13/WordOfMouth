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


+ (BOOL) extractJWTTokenAndStoreIt: (NSData *) jsonData {
    NSString* tokenString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if ([tokenString containsString:@"jwt"]) {
       // NSLog(tokenString);
        NSArray *stringArray = [tokenString componentsSeparatedByString: @"\""];
        // NSArray *stringArray2 = [stringArray[1] componentsSeparatedByString: @"'\'"];
        NSString* authToken2 = stringArray[3];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:authToken2 forKey:@"authToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return (true);
    }else {
        NSLog(@"There was a problem with the token: %@", tokenString);
        return (false);
    }
    
}

+ (NSDictionary *) parseJSONIntoReviewDictionary: (NSData *) jsonData selectedGenre: (Food *) selectedFood {
    NSError* error;
    NSDictionary* dictionaryOfObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *itemsDictionary;
    for (NSDictionary *dictionary in dictionaryOfObjects) {
        if ([[dictionary objectForKey:@"genre"] isEqualToString:selectedFood.name]) {
          itemsDictionary = dictionary[@"ratings"];
        return itemsDictionary;
        }
    }
   
    
   // NSArray* itemsArray = itemsDictionary[@"catsArray"];
    return itemsDictionary;
}

+ (averageObject *) parseJSONIntoAvgReviewObject: (NSData *) jsonData {
    NSError* error;
    NSDictionary* dictionaryOfObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *itemsDictionary;
            itemsDictionary = dictionaryOfObjects[@"avgObject"];
    averageObject * avgObject = [[averageObject alloc] initWithJSONDictionary:itemsDictionary];
    return avgObject;

}



@end
