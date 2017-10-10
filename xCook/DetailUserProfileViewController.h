//
//  DetailUserProfileViewController.h
//  xCook
//
//  Created by macbook on 7/21/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "ViewController.h"
@import CoreData;
@class AppDelegate;

@interface DetailUserProfileViewController : UIViewController

@property (nonatomic)NSManagedObjectContext *context;
@property (nonatomic,weak)AppDelegate *delegate;
@property (nonatomic,strong)UIImage* chosenImage;

@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *familyName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilImage;

@end
