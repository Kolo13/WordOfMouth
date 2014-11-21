//
//  NetworkController.h
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"
#import "Food.h"
#import "averageObject.h"

@interface NetworkController : NSObject

@property (nonatomic, strong) NSDictionary *bodyDictionary;


+ (NetworkController*)sharedManager;
- (NSData*)DictSerialization;
- (void)createNewUser: (NSData *)jsonObject completionHandler:(void(^)(bool success))completionHandler;
- (void)performRequest:(NSMutableURLRequest *)request completionHandler:(void (^)(NSData* rawData))completionHandler;
- (void)getList: (NSString *)listType completionHandler:(void(^)(NSArray* list))completionHandler;
-(void)getGenresForRest: (NSString *)restName completionHandler:(void(^)(NSArray* list))completionHandler;
-(void)getReviewsForRestInGenre: (Restaurant *)restName selectedFood: (Food *) selectedFood completionHandler:(void(^)(NSArray* list))completionHandler;
-(void)getRestforGenres: (NSString *)genreName completionHandler:(void(^)(NSArray* list))completionHandler;
-(void) getAverageRatingObjectForRest: (Restaurant *)restName selectedFood: (Food *) selectedFood completionHandler:(void(^)(averageObject* avgRest))completionHandler;
-(void) getGenreTemplateForRatingSubmission: (NSString *)genreName completionHandler:(void(^)(NSArray* list))completionHandler;
-(void) submitNewReview: (NSDictionary *) newRaiting completionHandler:(void(^)(bool success)) completionHandler;
@end
