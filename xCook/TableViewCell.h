//
//  TableViewCell.h
//  xCook
//
//  Created by macbook on 7/20/17.
//  Copyright © 2017 macKolev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *headerRecipeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeToCookLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfTheRecipe;

@end
