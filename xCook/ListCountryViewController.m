//
//  ListCountryViewController.m
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ListCountryViewController.h"


@interface ListCountryViewController ()

@end

@implementation ListCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.counties = [[self getAllCountries] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSArray*)getAllCountries{
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
    }
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    return sortedCountryArray;
}

// Searchbar поволява търсене по ПЪРВА буква, като не е отзна§ение дали се изписват главни ли не букви
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //Задължително съждаме нов масив
    _searchedCounties = [NSMutableArray new];
    
    //Сменяме стойност на BOOL променливата
    isSearched = YES;
    
    //За да не дава грешка при празна търсачка правим задължителна проверка
    if ([searchText isEqualToString:@""]) {
        isSearched = NO;
        //В случай, че търсачката не е празна
    }else{
        //Претърваме всички елементи от масива, в който търсим до големина на масива
    for (int i = 0; i < _counties.count; i++) {
        
        //Елемента от масива, в който търсим
        NSString* ime = _counties[i];
        
        //Вземаме първите букви на търсента дума и на всеки обект от масива, в който търсим
        NSString* firstLetter = [_counties[i] substringToIndex:1];
        NSString* firstLetrerSearched = [searchText substringToIndex:1];
        //Проверя първа буква и търсена дума като приравнява всички букви на неглавни такива и ги сравнява
        if ([[ime lowercaseString] containsString:[searchText lowercaseString]] && [firstLetter isEqualToString:firstLetrerSearched]) {
            
            //Добаване на намерен по зададените критерии обект
            [_searchedCounties addObject:ime];
        }
    }
    }
    //Много е важно да се презареди таблицата
    [self.tableView reloadData];
}

// Връща броя на клетките в таблицата, да е равен на броя на елементите в масива
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isSearched) {
    return self.searchedCounties.count;
    }
    else{
    return self.counties.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (isSearched) {
        cell.textLabel.text = self.searchedCounties[indexPath.row];
    }else{
    cell.textLabel.text = self.counties[indexPath.row];
    }
    return cell;
}

//Действие при натискане на някой от клетките/някоя държава/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.countrySelected = cell.textLabel.text;
    
    // Вземаме Storyboard
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Вземаме новият контролер по ID /от класа на новия контролер/
    CreateRecipeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"CreateRecipeViewController"];
    
    vc.countryTakenFromList = self.countrySelected;
    vc.nameTakenFromList = self.nameOfRecipe;
    vc.timeTakenFromList = self.timeToCookOfRecipe;
    vc.portionsTakenFromList = self.portionsOfRepice;
    vc.detailTakenFromList = self.detailsOfRecipe;
    
    //Показваме новия контролер
    [self presentViewController:vc animated:YES completion:nil];
    
    [AlertView showAlertViewWithTitle:@"BRAVO" message:self.countrySelected controller:self];
}


@end
