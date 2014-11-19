//
//  Food.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Food : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *cellColor;

- (instancetype) initName:(NSString *)name colorInit:(UIColor *)color;

@end
