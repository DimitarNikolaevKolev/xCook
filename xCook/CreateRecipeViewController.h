//
//  CreateRecipeViewController.h
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ViewController.h"
#import "ListCountryViewController.h"
@import CoreData;
@class AppDelegate;

@interface CreateRecipeViewController : ViewController<UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>;

//@property (nonatomic)NSManagedObjectContext *contexte;
//@property (nonatomic,weak)AppDelegate *delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *nameOfTheRecipe;
@property (weak, nonatomic) IBOutlet UITextField *timeToCook;
@property (weak, nonatomic) IBOutlet UITextField *portionsToEat;
@property (weak, nonatomic) IBOutlet UITextField *nationality;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addRecipePicActionButton;
@property (nonatomic,strong)UIImage* chosenImage;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageRecipe;
@property (weak, nonatomic) IBOutlet UIImageView *FadedImage;


@property (nonatomic,strong) NSString* countryTakenFromList;
@property (nonatomic,strong) NSString* nameTakenFromList;
@property (nonatomic,strong) NSString* timeTakenFromList;
@property (nonatomic,strong) NSString* portionsTakenFromList;
@property (nonatomic,strong) NSString* detailTakenFromList;
@end
