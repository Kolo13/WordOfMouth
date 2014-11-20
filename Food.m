//
//  Food.m
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "Food.h"

@implementation Food

- (instancetype) initName:(NSString *)name colorInit:(UIColor *)color {
    self = [self init];
    if (self) {
        self.name = name;
        self.cellColor = color;
        
    }
    return self;
}

@end
