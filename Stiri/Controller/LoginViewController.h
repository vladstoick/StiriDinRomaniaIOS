//
//  LoginViewController.h
//  Stiri
//
//  Created by Vlad Stoica on 8/7/13.
//  Copyright (c) 2013 Stoica Vlad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <FacebookSDK/FacebookSDK.h>
@class GPPSignInButton;

@interface LoginViewController : UIViewController <GPPSignInDelegate , FBLoginViewDelegate> 
@property (weak, nonatomic) IBOutlet GPPSignInButton *gpLogin;
- (IBAction)loginWithFacebook:(id)sender;
@end
