//
//  RecipeTableViewCell.h
//  xCook
//
//  Created by macbook on 7/20/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageRecipe;
@property (weak, nonatomic) IBOutlet UILabel *headerRecipeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeToCookRecipeLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteRecipeActionButton;

@end
