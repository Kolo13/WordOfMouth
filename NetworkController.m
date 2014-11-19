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
             
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     completionHandler(true);
             }];
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


- (void)performRequest:(NSMutableURLRequest *)request completionHandler:(void (^)(NSData* rawData))completionHandler {
    NSLog(@"Performing Request");
    NSURLSessionDataTask *dataTask = [self.URLSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Performing Task...");
        if (error != nil) {
            NSLog(@"ERROR: %@", [error localizedDescription]);
        } else {
            NSLog(@"Entered Else");
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSInteger statusCode = [httpResponse statusCode];
                NSLog(@"The status code is %l",statusCode);
                if (statusCode >= 200 && statusCode <= 299) {
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler(data);
                    }];
                    
                } else if (statusCode >= 400 && statusCode <= 499) {
                    
                    NSLog(@"Error! Status code is: %lu", statusCode);
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





@end
