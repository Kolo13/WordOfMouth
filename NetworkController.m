//
//  NetworkController.m
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "NetworkController.h"
#import "UserViewController.h"

@interface  NetworkController()

@property (nonatomic, strong) NSURLSession *URLSession;

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







@end
