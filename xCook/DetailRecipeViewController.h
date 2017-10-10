//
//  DetailRecipeViewController.h
//  xCook
//
//  Created by macbook on 7/21/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@import CoreData;
@class AppDelegate;


@interface DetailRecipeViewController : UIViewController

@property (nonatomic)NSManagedObjectContext *context;
@property (nonatomic,weak)AppDelegate *delegate;

@property (weak, nonatomic) IBOutlet UINavigationBar *titleBarRecipe;
@property (weak, nonatomic) IBOutlet UIImageView *imageRecipeDetail;
@property (weak, nonatomic) IBOutlet UILabel *headerRecipeDetail;
@property (weak, nonatomic) IBOutlet UILabel *timeToCookRecipeDetail;
@property (weak, nonatomic) IBOutlet UILabel *portionsCountRecipeDetail;
@property (weak, nonatomic) IBOutlet UILabel *nationalityRecipeDetail;
@property (weak, nonatomic) IBOutlet UITextView *additionalInfoRecipeDetail;
@property (nonatomic) int rowDidSelectedDetail;

@end
