//
//  Review.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/17/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Review : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *review;
@property  NSInteger rating;

- (instancetype) init;

@end
