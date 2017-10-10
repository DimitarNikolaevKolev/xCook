//
//  MainViewController.h
//  xCook
//
//  Created by macbook on 7/19/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import "ViewController.h"
#import "RecipeTableViewCell.h"
#import "DetailRecipeViewController.h"
#import "DetailUserProfileViewController.h"
@import CoreData;
@class AppDelegate;

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>{
    BOOL isSearched;
}

@property (nonatomic)NSManagedObjectContext *context;
@property (nonatomic,weak)AppDelegate *delegate;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addRecipeAction;
@property (nonatomic) int rowDidSelected;

@property (nonatomic,strong) NSMutableArray* masiv;
@property (nonatomic,strong) NSMutableArray* searchedResults;

@end
