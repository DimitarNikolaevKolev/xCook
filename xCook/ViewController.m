//
//  ViewController.m
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Users+CoreDataClass.h"

@interface ViewController (){
    
    //AppDelegate *appDelegate;
    //NSManagedObjectContext *context;
    //NSArray *dictionaries;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogged"]){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogged"];
        
        // Вземаме Storyboard
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //Вземаме новият контролер по ID /от класа на новия контролер/
        MainViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        //Показваме новия контролер
        [self presentViewController:vc animated:YES completion:nil];
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Действия при натиска на бутон Влез
- (IBAction)loginAction:(id)sender {

    NSString *userName = self.userNameInPut.text;
    NSString *pass = self.passInPut.text;
    
    // Проверява дали има въвеждане в полето Потребителско име
    if ([userName length] == 0) {
        
        // Съобщение за празно поле
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Няма въведен потребител!" controller:self];
    }
    if ([pass length] == 0) {
        // Съобщение за празно поле
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Няма въведен парола!" controller:self];
    }
    
    
    // Fetch заявка
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    NSArray<Users*>* allUsers = [self.context executeFetchRequest:request error:nil];
    
    // Check if user entered right USERNAME AND PASS
    for (Users *person in allUsers) {
        
        if ([person.userName isEqualToString:[NSString stringWithFormat:@"%@",userName]] && [person.password isEqualToString:[NSString stringWithFormat:@"%@",pass]])
        //При правилно въвеедено потребителско име и парола
        {
            
            //Запазване на данните на текущия успешно влязъл потребител
            NSString *valueToSave = person.userName;
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceUserName"];
            valueToSave = person.firstName;
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceFirstName"];
            valueToSave = person.familyName;
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceFamilyName"];
            valueToSave = person.email;
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceEmail"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
            [[NSUserDefaults standardUserDefaults] synchronize];            
            
            // Вземаме Storyboard
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //Вземаме новият контролер по ID /от класа на новия контролер/
            MainViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            //Показваме новия контролер
            [self presentViewController:vc animated:YES completion:nil];
        }
        }
    //If there is username with incorrect password
    [AlertView showAlertViewWithTitle:@"Грешка" message:@"Въвели сте грешно потребителско име или парола. Пробвайте отново!" controller:self];
    
    //Delete textfields
    self.userNameInPut.text = @"";
    self.passInPut.text = @"";
}


//Действия при натиска не бутон Регистрация
- (IBAction)goToRegistrationAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    RegistrationView* vc = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationView"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}
@end
