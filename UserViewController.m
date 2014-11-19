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
  
  
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  
  
  if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"authToken"] isKindOfClass:[NSString class]]) {
      // getUserRatingList
  }else{
    
    UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"login" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [loginAlert addTextFieldWithConfigurationHandler:^(UITextField *userNameTextField) {
      userNameTextField.placeholder = @"username";
      userNameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }];
    
    [loginAlert addTextFieldWithConfigurationHandler:^(UITextField *passwordTextField) {
      passwordTextField.placeholder = @"Password";
      passwordTextField.secureTextEntry = true;
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
      NSString *login = loginAlert.textFields[0];
      NSString *password = loginAlert.textFields[1];
      NSLog(@"%@", login);
      NSLog(@"%@", password);

        //pass user data to network controller for authentication
        //return BOOL
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //return to previous tab
      [self.tabBarController setSelectedIndex:0];
    }];
    
   
    UIAlertAction *signUp = [UIAlertAction actionWithTitle:@"Sign Up" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      
      UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"sign up" message:nil preferredStyle:UIAlertControllerStyleAlert];
      
        [signUpAlert addTextFieldWithConfigurationHandler:^(UITextField *userNameTextField) {
        userNameTextField.placeholder = @"username";
        userNameTextField.keyboardType = UIKeyboardTypeEmailAddress;
      }];
      
      [signUpAlert addTextFieldWithConfigurationHandler:^(UITextField *emailTextField) {
        emailTextField.placeholder = @"email";
      }];
    
      [signUpAlert addTextFieldWithConfigurationHandler:^(UITextField *passwordTextField) {
        passwordTextField.placeholder = @"password";
        passwordTextField.secureTextEntry = true;
      }];
      
      [signUpAlert addTextFieldWithConfigurationHandler:^(UITextField *confirmPasswordTextField) {
        confirmPasswordTextField.placeholder = @"confirm password";
        confirmPasswordTextField.secureTextEntry = true;
      }];
     
      UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.login = signUpAlert.textFields[0];
        self.email = signUpAlert.textFields[1];
        self.password = signUpAlert.textFields[2];
        self.confirmPassword = signUpAlert.textFields[3];
        
        NSLog(@"%@", self.login);
        NSLog(@"%@", self.email);
        NSLog(@"%@", self.password);
        NSLog(@"%@", self.confirmPassword);

      }];
      
      UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //return to previous viewController
        [self.tabBarController setSelectedIndex:0];
      }];

        [signUpAlert addAction:Ok];
        [signUpAlert addAction:Cancel];
        [self presentViewController:signUpAlert animated:true completion:nil];

      }];
    
    [loginAlert addAction:ok];
    [loginAlert addAction:signUp];
    [loginAlert addAction:cancel];
    
    [self presentViewController:loginAlert animated:true completion:nil];
    
  }
  
  
  
  

}

@end
