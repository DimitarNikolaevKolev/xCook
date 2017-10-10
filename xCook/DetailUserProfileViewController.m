//
//  DetailUserProfileViewController.m
//  xCook
//
//  Created by macbook on 7/21/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "DetailUserProfileViewController.h"
#import "Users+CoreDataClass.h"
#import "AppDelegate.h"


@interface DetailUserProfileViewController ()

@end

@implementation DetailUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    
    //Изписване Име на потребителя
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceFirstName"];
    self.firstName.text = savedValue;
    
    //Show picture ot logged user in profile Page
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    NSArray<Users*>* user = [self.context executeFetchRequest:request error:nil];
    
    for (Users *person in user) {
        if ([person.firstName isEqualToString:savedValue]) {
            NSLog(@"Imeto ot CoreData: %@",person.firstName);
            NSLog(@"Imeto na vlezliq user: %@",savedValue);
            
            NSData *data = person.image; // data that you receive
            self.profilImage.image = [UIImage imageWithData:data];
        }
    }
    
    
    //Изписване на фамилно име на потребителя
    savedValue = [[NSUserDefaults standardUserDefaults]
                  stringForKey:@"preferenceFamilyName"];
    self.familyName.text = savedValue;
    
    //Изписване на email на потребителя
    savedValue = [[NSUserDefaults standardUserDefaults]
                  stringForKey:@"preferenceEmail"];
    self.emailLabel.text = savedValue;
    
    //Изписване на username на потребителя
    savedValue = [[NSUserDefaults standardUserDefaults]
                  stringForKey:@"preferenceUserName"];
    self.userName.text = savedValue;
    
}


//Действие за връщане към лист от рецепти
- (IBAction)goBackToListRecipeAction:(id)sender {
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    MainViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

//Разлогване на потребителя
- (IBAction)logOutAction:(id)sender {
    
    //Разлогване на потрбител
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogged"];
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
