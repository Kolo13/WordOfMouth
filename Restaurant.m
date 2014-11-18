//
//  Restaurant.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (instancetype) initName:(NSString *)name latInit:(double)lat lonInit:(double)lon colorInit:(UIColor *)color {
    self = [self init];
    if (self) {
        self.name = name;
        self.longitude = lon;
        self.latitude = lat;
        self.cellColor = color;
        
    }
    return self;
}

//test


@end
