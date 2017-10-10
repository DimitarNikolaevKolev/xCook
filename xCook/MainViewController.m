//
//  MainViewController.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "CreateRecipeViewController.h"
#import "Recipe+CoreDataClass.h"
#import "AppDelegate.h"


@interface MainViewController ()

@property (nonatomic) NSArray <Recipe*>*recipes;
@property (nonatomic,strong) Recipe* person;
@property (nonatomic) NSArray <Recipe*>*searchedRecipes;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Метод за забаване операции с произволен брой секунди
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // Логнат потрбител ДА
        //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogged"];
    //});
    
    //Регистрира ръчно направената клетка
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecipeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RecipeTableViewCell class])];
    
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = self.delegate.persistentContainer.viewContext;
    _searchBar.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self fetchAllUsers];
    [self.tableView reloadData];
    [self checkIfThereIsRecipe];

}

/*Метод, който проверява дали има рецепта и ако няма, препраща към
  създаване на такава
*/
-(void)checkIfThereIsRecipe{
    if (_recipes.count == 0) {
        NSLog(@"Nqma recepti!!!!!!");
        // Вземаме Storyboard
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        //Вземаме новият контролер по ID /от класа на новия контролер/
        CreateRecipeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateRecipeViewController"];
        
        //Показваме новия контролер
        [self presentViewController:vc animated:YES completion:nil];
    }
}

//Извежда рецептите
-(void)fetchAllUsers{
    
    NSFetchRequest *request = [NSFetchRequest
                               fetchRequestWithEntityName:@"Recipe"];
    self.recipes = [self.context executeFetchRequest:request error:nil];
}


//Върни към предишен контролер
- (IBAction)goBackAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    ViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
    
}

//Действие препраща към контролер за създаване на рецепта
-(IBAction)addRecipeAction:(id)sender{
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    CreateRecipeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateRecipeViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

//Показване на детаили/профил на Потребителя
- (IBAction)goToProfilDetailAction:(id)sender {
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    DetailUserProfileViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailUserProfileViewController"];
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}


//Създава tableView с големина, колкото рецепти има в CoreData
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isSearched) {
        return self.masiv.count;
    }else{
    return self.recipes.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecipeTableViewCell class]) forIndexPath:indexPath];
    
    //При използване на searchbar-a се извежда новия масив от обекти "masiv"
    if (isSearched) {
        self.person = self.masiv[indexPath.row];
    }else{
        self.person = self.recipes[indexPath.row];
    }
    
    
    //Изграждане на клетката
    cell.headerRecipeLabel.text = _person.name;
    
    //cell.headerRecipeLabel.layer.borderWidth = 2.0;
    //cell.headerRecipeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //cell.headerRecipeLabel.layer.cornerRadius = 15.0;
    
    cell.timeToCookRecipeLabel.text = _person.time;
    
    //Изтегля снимакта от CoreData
    NSData *data = _person.image;
    
    //Прикрепя снимката към UIImageView на клетката
    cell.imageRecipe.image = [UIImage imageWithData:data];
    
    
    //Действие за триене на рецепта и запзване на номер на реда в таг-а на бутона
    cell.deleteRecipeActionButton.tag = indexPath.row;
    [cell.deleteRecipeActionButton addTarget:self action:@selector(deleteRecipeActionButton: ) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

//Делегейт метод на SearchBar-a и връща параметър "searchText"
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    isSearched = YES;
    _masiv = [NSMutableArray new];
    //Проверка дали има текст в searchbar-a
    if ([searchText isEqualToString:@""]) {
        isSearched = NO;
    }
    //Обхождане на Core Data _recipe и ако някой от имета на рецептите съдържат тръсената дума се добавят в нов масив
    for (Recipe* recipe in _recipes) {
        NSString* ime = recipe.name;
        NSString* firstletter = [ime substringToIndex:1];
        
        //Същинската проверка
        if ([[ime lowercaseString] containsString:[searchText lowercaseString]] && [[searchText lowercaseString] containsString:[firstletter lowercaseString]]) {
            //Добавяне на обекта отговарящ на условието в нов масив
            [_masiv addObject:recipe];
        }
    }
    
    [self.tableView reloadData];
}

//При натискане на някоя от рецептите се отваря екран детайли
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    DetailRecipeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailRecipeViewController"];
    
    _rowDidSelected = (int)indexPath.row;
    NSLog(@"%i",_rowDidSelected);
    
    vc.rowDidSelectedDetail = _rowDidSelected;

    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(IBAction)deleteRecipeActionButton:(id)sender{
    
    UIButton *buttonClicked = (UIButton *)sender;

    //Изтриване на обекта
    NSManagedObjectContext *user = [self context];
    [user deleteObject:self.recipes[buttonClicked.tag]];
    [self.delegate saveContext];
    
    //Презареждане на таблицата
    [self fetchAllUsers];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
