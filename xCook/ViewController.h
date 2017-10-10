//
//  ViewController.h
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationView.h"
#import "MainViewController.h"
#import "AlertView.h"
@import CoreData;
@class AppDelegate;


@interface ViewController : UIViewController

@property (nonatomic)NSManagedObjectContext *context;
@property (nonatomic,weak)AppDelegate *delegate;

@property (weak, nonatomic) IBOutlet UITextField *userNameInPut;
@property (weak, nonatomic) IBOutlet UITextField *passInPut;

- (IBAction)loginAction:(id)sender;
- (IBAction)goToRegistrationAction:(id)sender;

@end

