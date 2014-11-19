//
//  UserViewController.m
//  GroupProject2nd
//
//  Created by Kori Kolodziejczak on 11/18/14.
//  Copyright (c) 2014 Tuan Vu. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"


@interface UserViewController ()

@end

@implementation UserViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
   if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"] isKindOfClass:[NSString class]]) {
      // Show User Data
  }else{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"login" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //code
    }];
    UIAlertAction *signUp = [UIAlertAction actionWithTitle:@"Sign Up" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //code
    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //code
    }];
    
    UITextField *userNameTextField;
    UITextField *passwordTextField;
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
      userNameTextField.placeholder = @"User Name";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
      userNameTextField.placeholder = @"Password";
    }];
    
    [alert addAction:ok];
    [alert addAction:signUp];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:true completion:nil];
    
  }
  

  
  
  
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
}

@end
