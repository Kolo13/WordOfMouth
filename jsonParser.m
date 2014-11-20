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
        [[NSUserDefaults standardUserDefaults] setObject:tokenString forKey:@"authToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return (true);
    }else {
        NSLog(@"There was a problem with the token: %@", tokenString);
        return (false);
    }
    
    
//    NSError* error;
//    NSArray* dictionaryOfObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//    //NSArray* itemsArray = dictionaryOfObjects[@"list"];
   
}



@end
