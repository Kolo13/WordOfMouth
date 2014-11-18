//
//  NetworkController.h
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewController.h"

@interface NetworkController : NSObject

@property (nonatomic, strong) NSDictionary *bodyDictionary;


+ (NetworkController*)sharedManager;
- (NSData*)DictSerialization;
- (void)createNewUser: (NSData *)jsonObject completionHandler:(void (^)(NSData* rawData))completionHandler;
@end
