//
//  User.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/17/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) init {
    self = [self init];
    if (self) {
        
    }
    return self;
}


+ (NSData*)DictSerialization{
  NSMutableDictionary *profileDict = [[NSMutableDictionary alloc] init];
   [profileDict setObject:@"Tuan" forKey:@"name"];
   [profileDict setObject:@"tnahvu@gmail.com" forKey:@"email"];
   [profileDict setObject:@"123456" forKey:@"password"];
   [profileDict setObject:@"123456" forKey:@"passwordConfirm"];
   NSError *error;
   NSData *profileJSON = [NSJSONSerialization dataWithJSONObject:profileDict options:0 error:&error];
   return profileJSON;
   }

@end
