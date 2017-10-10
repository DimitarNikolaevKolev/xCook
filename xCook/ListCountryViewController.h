//
//  ListCountryViewController.h
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateRecipeViewController.h"

@interface ListCountryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    BOOL isSearched;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray* counties;
@property (nonatomic,strong) NSMutableArray* searchedCounties;
@property (nonatomic,strong) NSString* countrySelected;
@property (nonatomic,strong) NSString* nameOfRecipe;
@property (nonatomic,strong) NSString* timeToCookOfRecipe;
@property (nonatomic,strong) NSString* portionsOfRepice;
@property (nonatomic,strong) NSString* detailsOfRecipe;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
