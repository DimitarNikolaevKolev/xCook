//
//  RegistrationView.h
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ViewController.h"
#import "ListUsersViewController.h"
@import CoreData;
@class AppDelegate;


@interface RegistrationView : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>;

@property (nonatomic)NSManagedObjectContext *context;
@property (nonatomic,weak)AppDelegate *delegate;
@property (nonatomic,strong)UIImage* chosenImage;
@property (weak, nonatomic) IBOutlet UIImageView *showenImage;


@property (weak, nonatomic) IBOutlet UITextField *firstNameReg;
@property (weak, nonatomic) IBOutlet UITextField *userNameReg;
@property (weak, nonatomic) IBOutlet UITextField *mailReg;
@property (weak, nonatomic) IBOutlet UITextField *passReg;
@property (weak, nonatomic) IBOutlet UITextField *passConfirmReg;


- (IBAction)goBackLoginAction:(id)sender;
- (IBAction)createRegistrationAction:(id)sender;
- (IBAction)seeListUsersAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *seeListUsersAction;

@end
