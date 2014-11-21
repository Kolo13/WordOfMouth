//
//  NetworkController.m
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "NetworkController.h"
#import "UserViewController.h"
#import "jsonParser.h"
#import "Review.h"

@interface  NetworkController()

@property (nonatomic, strong) NSURLSession *URLSession;
@property (nonatomic, strong) NSString *baseURL;

@end

@implementation NetworkController


+ (NetworkController*)sharedManager {
  static NetworkController *sharedMyManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyManager = [[self alloc] init];
  });

  return sharedMyManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.baseURL = @"https://immense-fjord-7475.herokuapp.com";
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.URLSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}


- (void)createNewUser: (NSData *)jsonObject completionHandler:(void(^)(bool success))completionHandler {

    NSString *urlString = @"https://immense-fjord-7475.herokuapp.com/api/users";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonObject length]]
   forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonObject];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(false);
            }];
        } else {
             //Extract JWT token and store it.
            BOOL success = [jsonParser extractJWTTokenAndStoreIt:(rawData)];
            
            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(true);

             }];
            }
            }
    }];
}

-(void)getList: (NSString *)listType completionHandler:(void(^)(NSArray* list))completionHandler {
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    
    if ([listType  isEqualToString: @"genre"]){
        //make call to get list of catagories
        [urlString appendString: @"/genre/list"];
    }
    else if ([listType isEqualToString: @"rest"]) {
        //make call to get list of resteraunts
        [urlString appendString: @"/rest/list"];
    }
    else {
        NSLog(@"Attempted to get a non valid list type");
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(@[]);
        }];
    }
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSArray *list = [jsonParser parseJSONIntoListArray:(rawData)];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
    
}
//test

-(void)getGenresForRest: (NSString *)restName completionHandler:(void(^)(NSArray* list))completionHandler {
    NSLog(@"Entered Network Controller");
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/rest/genres/"];
    [urlString appendString: restName];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSArray *list = [jsonParser parseJSONIntoListArray:(rawData)];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
    
}

- (void)performRequest:(NSMutableURLRequest *)request completionHandler:(void (^)(NSData* rawData))completionHandler {
    NSLog(@"Performing Request");
    NSURLSessionDataTask *dataTask = [self.URLSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Performing Task...");
        if (error != nil) {
            NSLog(@"DATA TASK ERROR: %@", [error localizedDescription]);
        } else {
            NSLog(@"Entered Else");
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSInteger statusCode = [httpResponse statusCode];
                NSLog(@"The response message is: %@",responseString);
                
                if (statusCode >= 200 && statusCode <= 299) {
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler(data);
                    }];
                    
                } else if (statusCode >= 400 && statusCode <= 499) {
                    
                    NSLog(@"Error! Status code is: %lu", statusCode);
                    NSLog(@"The failure mesage is: %@", responseString);
                    NSLog(@"This is the clients fault");
                    
                } else if (statusCode >= 500 && statusCode <= 599) {
                    
                    NSLog(@"Error! Status code is: %lu", statusCode);
                    
                    NSLog(@"This is the server's fault");
                } else {
                    NSLog(@"Error! Status code is: %lu", statusCode);
                    NSLog(@"Bad Response");
                }
            }
        }
    }];
    [dataTask resume];
}

- (void)getReviewsForRestInGenre: (Restaurant *)restName selectedFood: (Food *) selectedFood completionHandler:(void(^)(NSArray* list))completionHandler {
  //get(rest/comments/_name_)
    NSLog(@"Entered Network Controller");
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/rest/comments/"];
    [urlString appendString: restName.name];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSDictionary *dictionaryOfReviews = [jsonParser parseJSONIntoReviewDictionary:rawData selectedGenre:selectedFood];
            NSArray *list = [Review parseDictionaryIntoArrayOfReviews:dictionaryOfReviews selectedGenre:selectedFood selectedRest:restName];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
    
    
}


-(void)getRestforGenres: (NSString *)genreName completionHandler:(void(^)(NSArray* list))completionHandler {
    NSLog(@"Entered Network Controller");
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/genre/listRests/"];
    [urlString appendString: genreName];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSArray *list = [jsonParser parseJSONIntoListArray:(rawData)];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
    
}
    
-(void) getAverageRatingObjectForRest: (Restaurant *)restName selectedFood: (Food *) selectedFood completionHandler:(void(^)(averageObject* avgRest))completionHandler {
//get('/rest/avg/_genre_/_restaurant_')
    NSLog(@"Entered Network Controller");
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/rest/avg/"];
    [urlString appendString:selectedFood.name];
    [urlString appendString:@"/"];
    [urlString appendString: restName.name];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            averageObject * avgRest = [jsonParser parseJSONIntoAvgReviewObject:rawData];
            //NSArray *list = [Review parseDictionaryIntoArrayOfReviews:dictionaryOfReviews selectedGenre:selectedFood selectedRest:restName];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(avgRest);
            }];
        }
    }];
}

-(void) getGenreTemplateForRatingSubmission: (Food *) selectedFood completionHandler:(void(^)(NSArray* list))completionHandler {
    //genre/cat/:genre
    NSLog(@"Entered Network Controller");
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/genre/cat/"];
    [urlString appendString: selectedFood.name];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSLog(@"Request ready to go!");
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSArray *list = [jsonParser parseJSONIntoListArray:(rawData)];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
    
}

-(void) submitNewReview: (NSDictionary *) newRaiting completionHandler:(void(^)(bool success)) completionHandler {
//        ('comment/add') - post body must contain {"restaurant": "testaurant","rating": [5,5,5,2,4], "genre": "burger", "str": "testing add a comment1"}
        
        NSLog(@"Entered Network Controller to post a new review");
        NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
        [urlString appendString: @"/comment/add"];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSError *error;
        NSData *jsonObject = [NSJSONSerialization dataWithJSONObject:newRaiting options:0 error:&error];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonObject length]]
       forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:jsonObject];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString* authToken =[[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
        [request setValue:authToken forHTTPHeaderField:@"jwt"];
        [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
            //TO-DO Store the Token contained in rawData
            if (rawData == nil) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(false);
                }];
            } else {
                //Verify comment was added successfully.
                NSString *responseString = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
                
                if ([responseString isEqualToString:@"comment added"]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler(true);
                    }];
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler(false);
                    }];
                }

                }
        }];
}


//comment/user/list
-(void)getUserComments: (void(^)(NSArray* list))completionHandler {
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:self.baseURL];
    [urlString appendString: @"/comment/user/list"];
    NSLog(urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSString* authToken =[[NSUserDefaults standardUserDefaults] objectForKey:@"authToken"];
    [request setValue:authToken forHTTPHeaderField:@"jwt"];
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            NSLog(@"Raw data was Nil");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(@[]);
            }];
        } else {
            //call json parser with RawData
            NSLog(@"Have raw data that needs to be processed");
            NSDictionary *dictionaryOfReviews = [jsonParser parseJSONIntoReviewDictionaryForSingleUser:rawData];
            NSArray *list = [Review parseFullDictionaryIntoArrayOfReviews:dictionaryOfReviews];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(list);
            }];
        }
    }];
}

- (void)loginUser: (NSString *)encodedString completionHandler:(void(^)(bool success))completionHandler {
    
    NSString *urlString = @"https://immense-fjord-7475.herokuapp.com/api/users";
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"Get"];
    [request setValue:encodedString forHTTPHeaderField:@"Authentication"];
    [[NetworkController sharedManager]performRequest:request completionHandler:^(NSData *rawData) {
        //TO-DO Store the Token contained in rawData
        if (rawData == nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(false);
            }];
        } else {
            //Extract JWT token and store it.
            BOOL success = [jsonParser extractJWTTokenAndStoreIt:(rawData)];
            
            if (success) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(true);
                    
                }];
            }
        }
    }];
}


@end
