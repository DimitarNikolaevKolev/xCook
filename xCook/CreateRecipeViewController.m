//
//  CreateRecipeViewController.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "CreateRecipeViewController.h"
#import "AppDelegate.h"
#import "Recipe+CoreDataClass.h"


@interface CreateRecipeViewController ()

@end

@implementation CreateRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;

    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.cornerRadius = 8;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Nationality is %@",_countryTakenFromList);
    
    _nationality.text = self.countryTakenFromList;
    _nameOfTheRecipe.text = self.nameTakenFromList;
    _timeToCook.text = self.timeTakenFromList;
    _portionsToEat.text = self.portionsTakenFromList;
    _textView.text = self.detailTakenFromList;
}


//When you try to enter nationality in the field
- (IBAction)chooseCountryAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ListCountryViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ListCountryViewController"];
    
    vc.nameOfRecipe = self.nameOfTheRecipe.text;
    vc.timeToCookOfRecipe = self.timeToCook.text;
    vc.portionsOfRepice = self.portionsToEat.text;
    vc.detailsOfRecipe = self.textView.text;
    
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)saveRecipeAction:(id)sender {
    
    //Вземане на информация от полетата за въвеждане
    NSString* name = self.nameOfTheRecipe.text;
    NSString* time = self.timeToCook.text;
    int portions = [self.portionsToEat.text intValue];
    NSString* nationality = self.nationality.text;
    NSString* info = self.textView.text;
    
    //Създаване на клас Recipe и асоцииране с CoreData
    Recipe *recipe = [[Recipe alloc] initWithContext:self.context];
    
    //Въвеждане в CoreData
    recipe.name = name;
    recipe.time = time;
    recipe.count = portions;
    recipe.nationality = nationality;
    recipe.detail = info;
    recipe.image = UIImagePNGRepresentation(self.chosenImageRecipe.image);
    
    //Метод за запазване на информацията
    [self.delegate saveContext];
    NSLog(@"Ime: %@ ,Vreme: %@ ,Porcii: %i Nacionalnost: %@ detaili: %@ ", recipe.name, recipe.time,recipe.count,recipe.nationality,recipe.detail);
}

//Действие за връщане към лист от Рецепти
- (IBAction)goBackToMainScreenAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    MainViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

//Избиране на картинка от галерията на телефон или снимка в реално време (PickerController)

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //Теглене на снимката от PickerController
    _chosenImage = info[UIImagePickerControllerEditedImage];
    
    //Присвояване на избраната снимка към UIImageView
    self.chosenImageRecipe.image = [UIImage imageWithData:UIImagePNGRepresentation(_chosenImage)];
    self.FadedImage.image = [UIImage imageWithData:UIImagePNGRepresentation(_chosenImage)];
    
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
    
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* choosePhoto = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [uploadPhotoAlert addAction:takePhoto];
    [uploadPhotoAlert addAction:choosePhoto];
    [uploadPhotoAlert addAction:cancel];
    [self presentViewController:uploadPhotoAlert animated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
