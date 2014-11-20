//
//  User.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/17/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Review.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSArray *reviewArray;
@property (nonatomic, strong) NSString *reviewText;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

+ (NSData*)DictSerialization: (NSString*)name email:(NSString*)email password:(NSString*)password;

- (instancetype) init;




@end
