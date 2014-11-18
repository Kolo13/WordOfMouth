//
//  Restaurant.h
//  GroupProject2nd
//
//  Created by Tuan Vu on 11/16/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property NSInteger foodRating;
@property NSInteger yelpRating;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *typeOfRestaurant;
@property (nonatomic, strong) NSString *address;
@property double latitude;
@property double longitude;
@property (nonatomic, strong) UIColor *cellColor;

- (instancetype) initName:(NSString *)name latInit:(double)lat lonInit:(double)lon colorInit:(UIColor *)color;


@end
