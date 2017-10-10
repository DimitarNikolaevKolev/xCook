//
//  RegistrationView.m
//  xCook
//
//  Created by macbook on 7/18/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "RegistrationView.h"
#import "Users+CoreDataClass.h"
#import "AppDelegate.h"
#import "AlertView.h"


@interface RegistrationView ()

@end

@implementation RegistrationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    self.showenImage.layer.masksToBounds = YES;
    self.showenImage.layer.cornerRadius = 63;
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)goBackLoginAction:(id)sender {
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}


//Създаване на Профил и записване в CoreData, след което пренасяне към екран за логване
- (IBAction)createRegistrationAction:(id)sender {
    
    //Съобщение при въвеждане на невалиден емайл
    if (![self isValidEmail:_mailReg.text]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Невалиден е-майл!" controller:self];
        return;
    }
    
    if (![self.passReg.text isEqualToString:self.passConfirmReg.text]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Паролата не съвпада!" controller:self];
        return;

    }
    
    NSString *firstName = self.firstNameReg.text;
    //NSString *familyName = self.familyNameReg.text;
    NSString *userName = self.userNameReg.text;
    NSString *emailName = self.mailReg.text;
    NSString *pass = self.passReg.text;
    
    //Check if firstname field is empty and add new user to CoreData
    if([firstName length] != 0){
        
    Users *user = [[Users alloc] initWithContext:self.context];
    user.firstName = firstName;
    //user.familyName = familyName;
    user.userName = userName;
    user.email = emailName;
    user.password = pass;
    user.image = UIImagePNGRepresentation(self.showenImage.image);
    [self.delegate saveContext];

    }
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)seeListUsersAction:(id)sender{
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ListUsersViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ListUsersViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

//Проверка за валиден е-майл
-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

//Избиране на картинка от галерията на телефон или снимка в реално време (PickerController)

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //Теглене на снимката от PickerController
    _chosenImage = info[UIImagePickerControllerEditedImage];
    
    //Преобразуване в NSDATA
    NSData *pictureBufferVariable = UIImagePNGRepresentation(_chosenImage);
    
    //Присвояване на избраната снимка към UIImageView
    self.showenImage.image = [UIImage imageWithData:pictureBufferVariable];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)checkCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [AlertView showAlertViewWithTitle:@"Грешка" message:@"Device has no camera" controller:self];
    }
}


- (IBAction)uploadPhotoButoon:(id)sender {
    
    UIAlertController* uploadPhotoAlert = [UIAlertController alertControllerWithTitle:@"Снимка на рецептата" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Снимай" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Избери снимка" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Отказ" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [uploadPhotoAlert addAction:takePhoto];
    [uploadPhotoAlert addAction:choosePhoto];
    [uploadPhotoAlert addAction:cancel];
    [self presentViewController:uploadPhotoAlert animated:YES completion:nil];
    
}


@end
