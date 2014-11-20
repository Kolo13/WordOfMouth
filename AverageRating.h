//
//  AverageRating.h
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/20/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AverageRating : NSObject

@property (nonatomic, strong) NSString *restName;
@property NSInteger restID;

@property (nonatomic, strong) NSString *genreName;
@property (nonatomic, strong) NSDictionary *categories;
@property double overallScore;




@end
