//
//  DetailRecipeViewController.m
//  xCook
//
//  Created by macbook on 7/21/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "DetailRecipeViewController.h"
#import "Recipe+CoreDataClass.h"
#import "AppDelegate.h"

@interface DetailRecipeViewController ()

@property (nonatomic) NSArray <Recipe*>*recipes;

@end

@implementation DetailRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    
    //Метод за пълнена на рецепти от CoreData в масива recipes
    [self fetchAllUsers];
    
    //Извеждане по номер на избраната от потребителя рецепта
    Recipe *recipe = self.recipes[_rowDidSelectedDetail];
      
    
    //Наименование на рецептата
    self.headerRecipeDetail.text = recipe.name;
    self.titleBarRecipe.topItem.title = recipe.name;
    
    //Време за приготвяне
    self.timeToCookRecipeDetail.text = recipe.time;
    
    //Колко порции могат да се направят
    self.portionsCountRecipeDetail.text = [NSString stringWithFormat:@"%i", recipe.count];
    
    // Националност
    self.nationalityRecipeDetail.text = recipe.nationality;
    
    //Допълнителна информация
    self.additionalInfoRecipeDetail.text = recipe.detail;
    
    //Снимка на рецептата
    NSData *data = recipe.image;
    self.imageRecipeDetail.image = [UIImage imageWithData:data];
    
}

//Зареждане на масива recipes с всички рецепти от CoreData
-(void)fetchAllUsers{
    
    NSFetchRequest *request = [NSFetchRequest
                               fetchRequestWithEntityName:@"Recipe"];
    self.recipes = [self.context executeFetchRequest:request error:nil];
}

- (IBAction)goBackToListRecipeAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    MainViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
